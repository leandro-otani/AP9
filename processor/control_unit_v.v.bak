module  control_unit_v(wire_clock, wire_reset, bus_RAM_DATA_IN,bus_RAM_DATA_OUT,bus_RAM_ADDRESS,wire_RW, bus_keyboard, videoflag, bus_vga_pos, bus_vga_char,enable_alu,FR_in_at_control,FR_out_at_control,opcode,useCarry,flagToShifthAndRot,useDec,m2,m3,m4,data_debug, led);
   input wire         wire_clock;
   input wire         wire_reset;
   input wire [15:0]  bus_RAM_DATA_IN;
   output reg [15:0]  bus_RAM_DATA_OUT;
   output reg [15:0]  bus_RAM_ADDRESS;
   output reg         wire_RW;
   input  wire [7:0]  bus_keyboard;
   output reg         videoflag;
   output reg [15:0]  bus_vga_pos;
   output reg [15:0]  bus_vga_char;
   output reg         enable_alu=1'b0;
   input  wire [15:0] FR_in_at_control;
   output reg [15:0]  FR_out_at_control;
   output reg [5:0]   opcode;
   output reg         useCarry;
   output reg [2:0]   flagToShifthAndRot;
   output reg         useDec;
   input  wire [15:0] m2;  
   output reg [15:0]  m3;  
   output reg [15:0]  m4;  
   output reg [15:0]  data_debug;
   output [15:0]      led;

   reg                resetStage;   
   reg [7:0]          stage=8'h00;
   reg                processing_instruction=1'b0;
   reg                definingVariables=1'b1;
   reg                startedProcessing;
   reg [15:0]         IR;
   reg [15:0]         PC;
   
   reg [15:0]         Rn [0:7];
   reg [15:0]         END;
   reg [15:0]         SP=16'h7ffc;
   
		
	assign led[15:0] = bus_vga_char[15:0];
   
	
	
   always @ (posedge wire_clock & startedProcessing) begin
      if(definingVariables==1'b1) begin
	     wire_RW=1'b0;        
	     PC= 16'h0000;
		 FR_out_at_control=16'h0000;
	     videoflag=1'b0;
	     resetStage=1'b0;   
	     Rn[1]=16'h0121;
	     Rn[3]=16'h0241;
	     definingVariables=1'b0;
      end
      else begin
		
         if(resetStage==1'b1 && stage==8'h01 ) begin
            resetStage=1'b0;         
         end
         if(processing_instruction == 1'b0) begin
            //`loadInstruction;====================
            casex(stage) 
              8'h01: begin 
                 bus_RAM_ADDRESS=PC;
              end 
              8'h02: begin 
                 processing_instruction=1'b1; 
                 IR=bus_RAM_DATA_IN; 
                 PC=PC+1'b1; 
                 resetStage=1'b1; 
              end 			  
            endcase
            data_debug=16'hffff;
         end else begin 
				data_debug=16'h0000;
            casez(IR) 
		        default : begin
				    casex(stage) 
				      8'h03: begin 
                      wire_RW=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1; 
                   end 
                 endcase
				  end  
              16'b110000??????????: begin
                 //`instruction_load;==================================
                 casex(stage) 
                   8'h01: begin 
                      bus_RAM_ADDRESS=PC;
                   end 
                   8'h02: begin 
                      END=bus_RAM_DATA_IN; 
                   end 
                   8'h03: begin 
                      bus_RAM_ADDRESS=END;
                   end 
                   8'h04: begin
                      PC=PC+16'h0001;     
                      Rn[IR[9:7]]=bus_RAM_DATA_IN;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end 
                 endcase              
              end
              16'b110001??????????: begin
                 //`instruction_store;================================ 
                 casex(stage) 
                   8'h01: begin 
                      bus_RAM_ADDRESS=PC;
                   end 
                   8'h02: begin 
                      END=bus_RAM_DATA_IN; 
                   end 
                   8'h03: begin 
                      bus_RAM_ADDRESS=END;
                   end 
                   8'h04: begin 
                      wire_RW=1'b1;
                      bus_RAM_DATA_OUT=Rn[IR[9:7]];
                   end
                   8'h05: begin
                      PC=PC+16'h0001;
                      wire_RW=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end 
                 endcase
              end
		        16'b111101??????????: begin
                 //`instruction_storei;================================= 
                 casex(stage) 
                   8'h01: begin 
                      bus_RAM_ADDRESS=Rn[IR[9:7]];
                   end 
                   8'h02: begin 
                      wire_RW=1'b1;
                      bus_RAM_DATA_OUT=Rn[IR[6:4]];
                   end 
                   8'h03: begin 
                      wire_RW=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1; 
                   end 
                 endcase
              end
              16'b111100??????????: begin
                 //`instruction_loadi;================================  
                 casex(stage) 
                   8'h01: begin 
                      bus_RAM_ADDRESS=Rn[IR[6:4]];
                   end 
                   8'h02: begin 
                      Rn[IR[9:7]]=bus_RAM_DATA_IN;
                      processing_instruction=1'b0;
                      resetStage=1'b1; 
                   end 
                 endcase
              end
              16'b111000??????????: begin              
                 //`instruction_loadn;=============================== 
                 casex(stage) 
                   8'h01: begin 
                      bus_RAM_ADDRESS=PC; 
                   end 
                   8'h02: begin 
                      Rn[IR[9:7]]=bus_RAM_DATA_IN; 
                      PC=PC+16'h0001; 
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
                 endcase
              end
              16'b110011??????????: begin
                 //`instruction_mov;=================================
                 casex(stage) 
                   8'h01: begin 
                      casex(IR[1:0]) 
                        2'b?0: begin 
                           Rn[IR[9:7]]= Rn[IR[6:4]]; 
                        end 
                        2'b01: begin 
                           Rn[IR[9:7]]=SP; 
                        end 
                        2'b11: begin 
                           SP=Rn[IR[9:7]]; 
                        end 
                      endcase 
                   end 
                   8'h02: begin 
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
                 endcase              
              end
              16'b110010??????????: begin
			     //`instruction_outchar;==============================                
			         casex(stage)
                   8'h01: begin 
				          bus_vga_pos=Rn[IR[6:4]]; 
                      bus_vga_char= Rn[IR[9:7]]; 
                   end
						 8'h02: begin 
				          if(bus_vga_char[11:8]==4'h0) begin
							    bus_vga_char=Rn[IR[9:7]]+16'h0f00;
							 end
							 else if (bus_vga_char[11:8]==4'hf) begin
							    bus_vga_char=Rn[IR[9:7]]-16'h0f00;
							 end
                   end 
                   8'h03: begin 
						 
                      videoflag=1'b1; 
                   end 
				       8'h04: begin 
				          videoflag=1'b0; 
				       end 
                   8'h90: begin                    
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
			         endcase
              end 
				  16'b110101??????????: begin
				  //`instruction_inchar;===============================
                 casex(stage)
                  8'h01: begin 						 
							Rn[IR[9:7]]=16'h0000+bus_keyboard;
					   end
					   8'h02: begin                    
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
                  endcase				 
				  end
              16'b000101??????????: begin
                 //`instruction_push;================================
                  casex(stage)
                    8'h01: begin
                       bus_RAM_ADDRESS=SP;
                    end
                    8'h02: begin
                       wire_RW=1'b1;
                       if(IR[6]==1'b0) begin                    
                          bus_RAM_DATA_OUT=Rn[IR[9:7]];                    
                       end
                       else begin
                          bus_RAM_DATA_OUT=FR_in_at_control;
                       end
                    end
                    8'h03: begin       
                       wire_RW=1'b0;               
                       processing_instruction=1'b0; 
                       resetStage=1'b1;
                       SP=SP-16'h0001;
                    end
                  endcase
              end 
              16'b000110??????????: begin
                 //`instruction_pop;=================================
                  casex(stage)
                    8'h01: begin
                       SP=SP+16'h0001;                       
                    end
                    8'h02: begin
                       bus_RAM_ADDRESS=SP;
                    end
                    8'h03: begin
                       if(IR[6]==1'b0) begin                    
                          Rn[IR[9:7]]=bus_RAM_DATA_IN;
                       end
                       else begin
                          FR_out_at_control=bus_RAM_DATA_IN;
								  opcode=IR[15:10];
								  enable_alu=1'b1;                                           
                       end                       
                    end
                    8'h06: begin
                       enable_alu=1'b0;
                       processing_instruction=1'b0; 
                       resetStage=1'b1;
                    end
                  endcase
              end 
              
              16'b000100??????????: begin
                 //`instruction_rts;=================================
                  casex(stage)
                    8'h01: begin
                       SP=SP+16'h0001;                       
                    end
                    8'h02: begin
                       bus_RAM_ADDRESS=SP;
                    end
                    8'h03: begin
                      PC=bus_RAM_DATA_IN;
                    end
                    8'h04: begin
                       PC=PC+16'h0001;                       
                       processing_instruction=1'b0; 
                       resetStage=1'b1;
                    end
                  endcase
              end
              16'b100000??????????: begin
                 //`instructions_add_and_addc;=======================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      useCarry=IR[0];
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end 
              16'b100001??????????: begin
                 //`instructions_sub_and_subc;=======================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      useCarry=IR[0];
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;							
                   end
                  endcase
              end 
              16'b100010??????????: begin
                 //`instruction_mul;=================================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end 
              16'b100011??????????: begin
                 //`instruction_div;================================= 
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end // case: 16'b100011??????????
              16'b100101??????????: begin				      
                 //`instruction_mod;================================= 
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end 
              16'b100100??????????: begin
                 //`instructions_inc_and_Dec;======================== 
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[9:7]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                      useDec=IR[6];                      
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end 
              16'b010110??????????: begin
                 //`instruction_cmp;=================================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[9:7]];
                      m4=Rn[IR[6:4]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];							 
                   end
                   8'h06: begin
							 bus_vga_char=FR_in_at_control;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end 
              16'b010010??????????: begin
                 //`instruction_and;=================================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end 
              16'b010011??????????: begin
                 //`instruction_or;==================================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;							 
                   end
                  endcase
              end 
              16'b010100??????????: begin
                 //`instruction_xor;=================================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      m4=Rn[IR[3:1]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
							 bus_vga_char=m2;
                   end
                  endcase
              end 
              16'b010101??????????: begin
                 //`instruction_not;=================================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[6:4]];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                  endcase
              end 
              16'b010000??????????: begin
                 //'instructions_shifts_and_rots=====================
                 casex(stage)
                   8'h01: begin
                      m3=Rn[IR[9:7]];
							 m4[3:0]=IR[3:0];
                      enable_alu=1'b1;
                      opcode=IR[15:10];
                      flagToShifthAndRot=IR[6:4];                      
                   end
                   8'h06: begin
                      Rn[IR[9:7]]=m2;
                      enable_alu=1'b0;
                      processing_instruction=1'b0;
                      resetStage=1'b1;
                   end
                 endcase
              end
              16'b000010??????????: begin
                 //`instructions_jump;===============================
                 casex(stage) 
                   8'h01: begin 
                      bus_RAM_ADDRESS=PC; 
                   end 
                   8'h02: begin 
                      casex(IR[9:6]) 
                        4'b0000: begin 
                           PC=bus_RAM_DATA_IN-16'h0001; 
                        end 
                        4'b0001: begin 
                           if(FR_in_at_control[13]==1'b1) begin
                              //Equal
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0010: begin 
                           if(FR_in_at_control[13]==1'b0) begin
                              //Not EQual
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0011: begin 
                           if(FR_in_at_control[12]==1'b1) begin
                              //Zero
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0100: begin 
                           if(FR_in_at_control[12]==1'b0) begin
                              //Not Zero
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end
                        4'b0101: begin 
                           if(FR_in_at_control[11]==1'b1) begin
                              //Carry
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0110: begin 
                           if(FR_in_at_control[11]==1'b0) begin
                              //NotCarry
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0111: begin 
                           if(FR_in_at_control[15]==1'b1) begin
                              //GReater
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1000: begin 
                           if(FR_in_at_control[14]==1'b1) begin
                              //LEsser
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1001: begin 
                           if((FR_in_at_control[15]|FR_in_at_control[13])==1'b1) begin
                              //GReater|EQual
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1010: begin 
                           if((FR_in_at_control[14]|FR_in_at_control[13])==1'b1) begin
                              //(LEsser|EQual)
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1011: begin 
                           if(FR_in_at_control[10]==1'b1) begin
                              //Overflow
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1100: begin 
                           if(FR_in_at_control[10]==1'b0) begin
                              //NotOverflow
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1101: begin 
                           if(FR_in_at_control[6]==1'b1) begin
                              //Negative
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1110: begin 
                           if(FR_in_at_control[9]==1'b1) begin
                              //DivbyZero
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                      endcase 
                   end 
				   8'h03: begin
				      PC=PC+16'h0001;
				   end
                   8'h04: begin 
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
                 endcase
              end 
              16'b000011??????????: begin
                 //`instructions_call;===============================
                 casex(stage)
                   8'h01: begin
                      bus_RAM_ADDRESS=SP;                      
                   end
                   8'h02: begin 
                      wire_RW=1'b1;
                      bus_RAM_DATA_OUT=PC;                      
                   end
                   8'h03: begin 
                      wire_RW=1'b0;
                   end
                   8'h04: begin 
                      bus_RAM_ADDRESS=PC;                      
                   end
                   8'h05: begin                     
                      casex(IR[9:6]) 
                        4'b0000: begin 
                           PC=bus_RAM_DATA_IN-16'h0001;
                           SP=SP-16'h0001;                           
                        end 
                        4'b0001: begin 
                           if(FR_in_at_control[13]==1'b1) begin
                              //Equal
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;                           
                           end 
                        end 
                        4'b0010: begin 
                           if(FR_in_at_control[13]==1'b0) begin
                              //Not EQual
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b0011: begin 
                           if(FR_in_at_control[12]==1'b1) begin
                              //Zero
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b0100: begin 
                           if(FR_in_at_control[12]==1'b0) begin
                              //Not Zero
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end
                        4'b0101: begin 
                           if(FR_in_at_control[11]==1'b1) begin
                              //Carry
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b0110: begin 
                           if(FR_in_at_control[11]==1'b0) begin
                              //NotCarry
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b0111: begin 
                           if(FR_in_at_control[15]==1'b1) begin
                              //GReater
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b1000: begin 
                           if(FR_in_at_control[14]==1'b1) begin
                              //LEsser
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b1001: begin 
                           if((FR_in_at_control[15]|FR_in_at_control[13])==1'b1) begin
                              //GReater|EQual
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b1010: begin 
                           if((FR_in_at_control[14]|FR_in_at_control[13])==1'b1) begin
                              //(LEsser|EQual)
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b1011: begin 
                           if(FR_in_at_control[10]==1'b1) begin
                              //Overflow
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b1100: begin 
                           if(FR_in_at_control[10]==1'b0) begin
                              //NotOverflow
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b1101: begin 
                           if(FR_in_at_control[6]==1'b1) begin
                              //Negative
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                        4'b1110: begin 
                           if(FR_in_at_control[9]==1'b1) begin
                              //DivbyZero
                              PC=bus_RAM_DATA_IN-16'h0001;
                              SP=SP-16'h0001;
                           end 
                        end 
                      endcase 
                   end 
				   8'h06: begin
				      PC=PC+16'h0001;
				   end
                   8'h07: begin 
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
                 endcase
              end
            endcase 
            
         end 
      end
   end // always @ (posedge wire_clock)
   
   always @( negedge wire_clock) begin
      startedProcessing<=1'b1;
	  
      if(resetStage==1'b1) begin
         stage=8'h01;    			
      end
      else begin
		 if(definingVariables==1'b0) begin
			stage=stage+8'h01;   
		 end
      end
   end

endmodule 
