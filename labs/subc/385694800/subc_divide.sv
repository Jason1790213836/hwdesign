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
    // TODO:  Complete the code for the divide operation   
    state_t current_state;
    always_comb begin
	    
	    outvalid=(current_state==DONE);
	    inready=(current_state==IDLE);
	    z=z_reg;

    end

    always_ff@(posedge clk)begin
	    if(rst==1)begin   // first modification
	   //	inready<=0;
		current_state<=IDLE;//
		a_reg<='0;
		b_reg<='0;
		z_reg<='0;
		count<='0;
		nbits_reg<='0;

	        //invalid<=0;
        	//outvalid<=0;
	        //outready<=0;	
	end else begin

               case(current_state)
		      IDLE:begin

                          // inready<=1; no recommantion  because its morelike
			  // a combination logic
			  // outvalid<=0;
 			   
			   if(invalid)begin
				   
				   a_reg<=a;
				   b_reg<=b;
				   count<='0;
				   z_reg<='0;


				   nbits_reg<=nbits;
				   if(nbits==0)
					current_state<=DONE;
				   else
					 current_state<=RUN;
			   end
		       end

		       RUN:begin
			       
			     
			      logic [32:0]a_shift;
			      logic [32:0]b_corre;
			     

			      a_shift={a_reg,1'b0};
			      b_corre={1'b0,b_reg};

	  	      if(a_shift>=b_corre)begin
			      a_reg<=32'(a_shift-b_corre);
			      z_reg<=(z_reg<<1)|1'b1;
		      end else begin
			        a_reg<=32'(a_shift);
 				z_reg<=(z_reg<<1);
		      end
					     
				   
				      
					count<=count+1;
					if(count==nbits_reg-1)begin
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
