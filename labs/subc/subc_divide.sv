`timescale 1ns/1ps

module subc_divide(
    input  logic         clk,
    input  logic         rst,

    // Handshake for inputs
    input  logic         invalid,
    output logic         inready,

    // Inputs
    input  logic [31:0]  a,
    input  logic [31:0]  b,
    input  logic [5:0]   nbits,     // runtime number of iterations (0–32)

    // Handshake for outputs
    input  logic         outready,
    output logic         outvalid,

    // Output
    output logic [31:0]  z
);

    // Internal registers
    logic [31:0] a_reg, b_reg;
    logic [31:0] z_reg;
    logic [5:0]  count;
    logic [5:0]  nbits_reg; // 需要寄存 nbits，因为输入可能在计算过程中变化
    typedef enum logic [1:0] {
        IDLE,
        RUN,
        DONE
    } state_t;
    state_t current_state;
    // TODO:  Complete the code for the divide operation   
    always_comb begin
          
	    if(current_state==IDLE)begin
		inready=1;
		outvalid=0;
	    end
   	    if(current_state==RUN)begin
		inready=0;
		outvalid=0;
	    end
	    if(current_state==DONE)begin
	    	inready=0;
		outvalid=1;
	    end

          z=z_reg;

    end
    always_ff@(posedge clk)begin
	    if(rst)begin
		    current_state<=IDLE;
		    a_reg<='0;
		    b_reg<='0;
		    z_reg<='0;
		    count<='0;
		    nbits_reg<='0;
	    end else begin
			case(current_state)
				IDLE:begin
				 if(invalid)begin
					 a_reg<=a;
					 count<='0;
					 z_reg<='0;
					 b_reg<=b;
				         nbits_reg<=nbits;
					 if(nbits==0)
					 current_state<=DONE;
				 	else
						current_state<=RUN;
				 end
			         end
			 	RUN:begin
					logic [32:0] a_shift;
					logic [32:0] b_comp;
					a_shift={a_reg,1'b0};
					b_comp={1'b0,b_reg};
					if(a_shift>=b_comp)begin
						a_reg<=32'(a_shift-b_comp);
						z_reg<=(z_reg<<1)|1'b1;
					end else begin
						a_reg<=32'(a_shift);
						z_reg<=(z_reg<<1);

					end
					count<=count+1;
					if(nbits_reg-1==count)begin
						current_state<=DONE;
					end
				end
				DONE:begin
					if(outready)begin
						current_state<=IDLE;
					end	
					end
				default : current_state<=IDLE;

			 	endcase
	    end
          
    end
endmodule