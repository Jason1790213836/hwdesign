#include <ap_axi_sdata.h>
#include <ap_int.h>
#include <hls_stream.h>
#include <hls_math.h>

#include "line_inter.hpp"

void line_inter(hls::stream<axis_word_t>& in_stream, hls::stream<axis_word_t>& out_stream) {
#pragma HLS INTERFACE axis port=in_stream
#pragma HLS INTERFACE axis port=out_stream
#pragma HLS INTERFACE ap_ctrl_none port=return

    // 1. 读取命令报头
    CmdHdr cmd_hdr;
    streamutils::tlast_status cmd_hdr_tlast = streamutils::tlast_status::no_tlast;
    cmd_hdr.read_axi4_stream<WORD_BW>(in_stream, cmd_hdr_tlast);

    // 2. 将变量转移到本地并进行分区，以便并行访问
    float a[ndim], b[ndim], uab[ndim];
    #pragma HLS ARRAY_PARTITION variable=a complete
    #pragma HLS ARRAY_PARTITION variable=b complete
    #pragma HLS ARRAY_PARTITION variable=uab complete
    
    float dab = cmd_hdr.dab;
    unsigned short nsamp = cmd_hdr.nsamp;
    
    // 【修复 1】: tid 改为 trans_id
    unsigned short trans_id = cmd_hdr.trans_id;

    copy_params: for (int j = 0; j < ndim; j++) {
        #pragma HLS UNROLL
        a[j] = cmd_hdr.a.data[j];
        b[j] = cmd_hdr.b.data[j];
        uab[j] = cmd_hdr.uab.data[j];
    }

    // 3. 立即返回响应报头以进行事务匹配
    RespHdr resp_hdr;
    // 【修复 2】: tid 改为 trans_id
    resp_hdr.trans_id = trans_id;
    // 第三个参数为 false，表示这还不是整个事务的最后一个词
    resp_hdr.write_axi4_stream<WORD_BW>(out_stream, false);

    // 4. 创建输入样本数组并分区
    float x[max_nsamp][ndim];
    #pragma HLS ARRAY_PARTITION variable=x dim=2 complete 

    // 5. 从输入流读取数据到 x
    // 【修复 3】: 将 unsigned int 改为 int，以匹配底层引用的参数类型
    int nelem_read = 0;
    streamutils::tlast_status samp_in_tlast = streamutils::tlast_status::no_tlast;
    
    // 【修复 4】: 纠正参数顺序 (流, 目标地址, tlast状态, 已读数量, 总长度)
    float32_array_utils::read_axi4_stream<WORD_BW>(in_stream, &x[0][0], samp_in_tlast, nelem_read, nsamp * ndim);

    // 6. 主计算循环
    float dsq_results[max_nsamp];

    compute_loop: for (int i = 0; i < nsamp; ++i) {
        #pragma HLS PIPELINE II=1
        
        float vec_ax[ndim];
        #pragma HLS ARRAY_PARTITION variable=vec_ax complete
        
        // 计算点到起点 a 的向量
        for (int j = 0; j < ndim; j++) {
            #pragma HLS UNROLL
            vec_ax[j] = x[i][j] - a[j];
        }

        // 计算点积 w = (x-a) · uab
        float w = 0;
        for (int j = 0; j < ndim; j++) {
            #pragma HLS UNROLL
            w += vec_ax[j] * uab[j];
        }

        // 限制范围 (Clamping)
        float w_clamped;
        if (w < 0.0f) w_clamped = 0.0f;
        else if (w > dab) w_clamped = dab;
        else w_clamped = w;

        // 计算最近点 z 并同时计算距离平方
        float current_dsq = 0;
        for (int j = 0; j < ndim; j++) {
            #pragma HLS UNROLL
            float z_j = a[j] + w_clamped * uab[j];
            float diff = x[i][j] - z_j;
            current_dsq += diff * diff;
        }
        
        dsq_results[i] = current_dsq;
    }

    // 7. 将计算结果写回输出流
    // 【修复 5】: 纠正参数顺序，第3个参数必须是 bool (false), 第4个参数是长度 (nsamp)
    float32_array_utils::write_axi4_stream<WORD_BW>(out_stream, dsq_results, false, nsamp);

    // 8. 错误检测与总结
    RespFtr resp_ftr;
    resp_ftr.nelem_read = nelem_read;
    
    // 【修复 6】: 所有的 status 全部改为 error
    resp_ftr.error = IntersectError::NO_ERROR;
    bool need_flush = false;

    if (cmd_hdr_tlast == streamutils::tlast_status::tlast_early) {
        resp_ftr.error = IntersectError::TLAST_EARLY_CMD_HDR;
    } else if (cmd_hdr_tlast == streamutils::tlast_status::no_tlast) {
        resp_ftr.error = IntersectError::NO_TLAST_CMD_HDR;
        need_flush = true;
    } else if (nsamp == 0) {
        resp_ftr.nelem_read = 0;
    } else if (samp_in_tlast == streamutils::tlast_status::tlast_early) {
        resp_ftr.error = IntersectError::TLAST_EARLY_SAMP_IN;
    } else if (samp_in_tlast == streamutils::tlast_status::no_tlast) {
        resp_ftr.error = IntersectError::NO_TLAST_SAMP_IN;
        need_flush = true;
    } else if (nelem_read != ndim * nsamp) { // 移除了多余的强转
        resp_ftr.error = IntersectError::WRONG_NSAMP;
    }

    if (need_flush) {
        streamutils::flush_axi4_stream_to_tlast<WORD_BW>(in_stream);
    }

    // 发送最后的页脚，TLAST 置为 true
    resp_ftr.write_axi4_stream<WORD_BW>(out_stream, true);
}