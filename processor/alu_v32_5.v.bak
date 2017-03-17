module alu_v(wire_clock,enable_alu, m2, m3, m4,opCode,FR_in,FR_out,useCarry,flagToShifthAndRot,dec);
   input  wire         wire_clock;
   input  wire         enable_alu;
   output reg  [15:0]  m2;
   input  wire [15:0]  m3;
   input  wire [15:0]  m4;
   input  wire [5:0]   opCode;
   input  wire [15:0]  FR_in;
   output reg  [15:0]  FR_out=16'h0000;
   input  wire         useCarry;
   input  wire [2:0]   flagToShifthAndRot;     
   input  wire         dec;
   
   reg [7:0]          stage=8'h00;
   reg                resetStage=1'b1;
   reg [31:0]         temp;
   reg [31:0]         addInv;
   
   reg [15:0]         FR;
   reg                enable_alu_prev=1'b0;

   


   always @ (posedge wire_clock) begin 
	  if(enable_alu==1'b1 && enable_alu_prev==1'b0) begin
		 resetStage=1'b0;
         enable_alu_prev=1'b1;    
			
	  end
      else begin 
         if(enable_alu==1'b1) begin
            enable_alu_prev=1'b1;    
         end
         else  begin
            enable_alu_prev=1'b0;    
         end
      end
	  if(enable_alu==1'b1 && stage>8'h00) begin
		 casex(opCode)
           16'b000110: begin
              casex(stage)
				     8'h01: begin
                        FR_out=FR_in;
                        resetStage=1'b1;                   
                     end
              endcase
		   end	
		   6'b100000: begin
			  //`instructions_add_and_addc;=======================
			  casex(stage)
				8'h01: begin 
                   if(useCarry==1'b1) begin
                      temp=32'h00000000+m3+m4+FR_in[11];                    
                   end    
                   else  begin
                      temp=32'h00000000+m3+m4;                    
                   end
                end
                8'h02: begin
                   if(temp>32'h0000ffff) begin
                      FR_out[11]=1'b1;                    
                   end
                   else begin
                      FR_out[11]=1'b0;
                   end
                   m2=temp[15:0];
                   if(temp[15:0]==16'h0000) begin
                      FR_out[12]=1'b1;
                   end
                   else begin
                      FR_out[12]=1'b0;
                   end                   
                   resetStage=1'b1;                       
                end
              endcase
           end 
           6'b100001: begin
              //`instructions_sub_and_subc;=======================
              casex(stage)
                8'h01: begin 
                   addInv=-m4;                 
                end
                8'h02: begin 
                   if(useCarry==1'b1) begin
                      temp=m3+addInv+FR_in[11]; 
                   end    
                   else  begin
                      temp=m3+addInv;                    
                   end
                end
                8'h03: begin
				   if(useCarry==1'b0) begin
					  if(m4>m3) begin
                         FR_out[6]=1'b1;
                         m2=16'h0000;                    
					  end
					  else begin
						 FR_out[6]=1'b0;
						 m2=temp[15:0];
					  end
				   end
				   if(useCarry==1'b1) begin
					  if(m4>(m3+FR_in[11])) begin
						 FR_out[6]=1'b1;
						 m2=16'h0000;                    
					  end
					  else begin
						 FR_out[6]=1'b0;
						 m2=temp[15:0];
					  end
				   end
                   if(temp[15:0]==16'h0000) begin
                      FR_out[12]=1'b1;
                   end
                   else begin
                      FR_out[12]=1'b0;
                   end                   
                   resetStage=1'b1;
                end
              endcase
           end 
           6'b100010: begin
              //`instruction_mul;=================================
              casex(stage)
                8'h01: begin 
                   temp=m3*m4;
                end
                8'h02: begin
                   m2=temp[15:0];
                   if(temp>32'h0000ffff) begin
                      FR_out[10]=1'b1;
                   end
                   else begin
                      FR_out[10]=1'b0;
                   end
                   if(temp[15:0]==16'h0000) begin
                      FR_out[12]=1'b1;
                   end
                   else begin
                      FR_out[12]=1'b0;
                   end  
                   resetStage=1'b1;
                end
              endcase
           end
           6'b100011: begin
              //`instruction_div;=================================
              casex(stage)
                8'h01: begin
                   if(m4==16'h0000) begin
                      FR_out[9]=1'b1;                   
                   end
                   else begin
                      m2=m3/m4;    
                      FR_out[9]=1'b0;                 
                   end                  
                end
                8'h02: begin
                   if(m2==16'h0000) begin
                      FR_out[12]=1'b1;
                   end
                   else begin
                      FR_out[12]=1'b0;
                   end  
                   resetStage=1'b1;
                end
              endcase
           end 
           6'b100101: begin
              //`instruction_mod;=================================
              casex(stage)
                8'h01: begin
                   if(m4==16'h0000) begin
                      FR_out[9]=1'b1;                   
                   end
                   else begin
                      m2=m3%m4;
                      FR_out[9]=1'b0;  
                   end                  
                end
                8'h02: begin
                   if(m2==16'h0000) begin
                      FR_out[12]=1'b1;
                   end
                   else begin
                      FR_out[12]=1'b0;
                   end  
                   resetStage=1'b1;
                end
              endcase
           end 
           6'b100100: begin
              //`instructions_inc_and_Dec;========================
              casex(stage)
                8'h01: begin
                   if(dec ==1'b0) begin
                      m2=m3+16'h0001;
                   end
                   else begin
                      m2=m3-16'h0001;
                   end
                   resetStage=1'b1;                
                end
              endcase
           end         
           6'b010110: begin
              //`instruction_cmp;=================================
              casex(stage)
                8'h01: begin					 
                   if(m3 == m4) begin
                      FR_out[15:13]=3'b001;
                   end
                   if(m3<m4) begin
                      FR_out[15:13]=3'b010;
                   end
                   if(m3>m4) begin
                      FR_out[15:13]=3'b100;
                   end
                   resetStage=1'b1;                
                end
              endcase
           end                     
           6'b010010: begin
              //`instruction_and;=================================
              casex(stage)
                8'h01: begin
                   m2=m3 & m4;                
                end
                8'h02: begin
                   if(m2==16'h0000) begin
                      FR_out[12]=1'b1;                   
                   end
                   resetStage=1'b1;
                end
              endcase
           end
           6'b010011: begin
              //`instruction_or;==================================
              casex(stage)
                8'h01: begin
                   m2=m3 | m4;                
                end
                8'h02: begin
                   if(m2==16'h0000) begin
                      FR_out[12]=1'b1;                   
                   end
                   resetStage=1'b1;
                end
              endcase
           end
           6'b010100: begin
              //`instruction_xor;=================================
              casex(stage)
                8'h01: begin
                   m2=m3 ^ m4;
                end
                8'h02: begin
                   if(m2==16'h0000) begin
                      FR_out[12]=1'b1;                   
                   end
                   resetStage=1'b1;
                end
              endcase
           end 
           6'b010101: begin
              //`instruction_not;=================================
              casex(stage)
                8'h01: begin
                   m2=~m3;
                end
                8'h02: begin
                   if(m2==16'h0000) begin
                      FR_out[12]=1'b1;                   
                   end
                   resetStage=1'b1;
                end
              endcase
           end 
           6'b010000 : begin
              //'instructions_shifts_and_rots=====================
              casez(flagToShifthAndRot)
                3'b10?: begin
                   casex(stage)
                     8'h01: begin
                        m2=((m3<<m4)&16'hffff)|(m3>>(16'h000f-m4));
                        resetStage=1'b1;                      
                     end
                   endcase
                end
                3'b11?: begin
                   casex(stage)
                     8'h01: begin
                        m2=(((m3>>(16'h0010-m4)))|(m3<<m4))&(16'hffff);
                        resetStage=1'b1;                      
                     end
                   endcase
                end
                3'b000: begin
                   casex(stage)
                     8'h01: begin
                        m2=m3<<m4;
                        resetStage=1'b1;                      
                     end
                   endcase
                end
                3'b001: begin
                   casex(stage)
                     8'h01: begin
                        m2=m3<<m4;
                        resetStage=1'b1;                      
                     end
                   endcase
                end
                3'b010: begin
                   casex(stage)
                     8'h01: begin
                        m2=m3>>m4;
                        resetStage=1'b1;                      
                     end
                   endcase
                end
                3'b011: begin
                   casex(stage)
                     8'h01: begin
                        m2=m3>>m4;
                        resetStage=1'b1;                      
                     end
                   endcase
                end
              endcase
           end
         endcase       
	  end
   end
   always @( negedge wire_clock) begin
      if(resetStage==1'b1) begin
         stage=8'h00;
      end
      else begin
		 stage=stage+8'h01;   
      end		
   end   
endmodule
