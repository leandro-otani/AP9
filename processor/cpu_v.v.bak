module  cpu_v(wire_clock, wire_reset, bus_RAM_DATA_IN,bus_RAM_DATA_OUT,bus_RAM_ADDRESS,wire_RW, bus_keyboard, videoflag, bus_vga_pos, bus_vga_char,data_debug, led);
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
   output reg [15:0]  data_debug;
   output [15:0]      led;

   
   reg                resetStage;   
   reg [7:0]          stage=8'h00;
   reg                processing_instruction=1'b0;
   reg                definingVariables=1'b1;
   reg                startedProcessing;
   reg [15:0]         IR;
   reg [15:0]         PC;
   
   
   reg [15:0]         Rn [0:7] ;
   
   
   
   reg [15:0]         END;
   reg [5:0]         endReg;
   reg [15:0]        dataIn;
   reg [15:0]        dataOut;
   reg [31:0]        SP;
   reg               wr;
   reg               clock;


   reg               EQual;
   reg               Zero;
   reg               Carry;
   reg               GReater;
   reg               LEsser;
   reg               Overflow;
   reg               Negative;
   reg               DivbyZero;






   assign led[15:0] = bus_vga_char[15:0];




   always @ (posedge wire_clock & startedProcessing) begin
      if(definingVariables==1'b1) begin
	     wire_RW=1'b0;        
	     PC= 16'h0000;
	     EQual=1'b1;
	     Zero=1'b0;
	     Carry=1'b0;
	     GReater=1'b0;
	     LEsser=1'b0;     
	     Overflow=1'b0;
	     Negative=1'b0;
	     DivbyZero=1'b0;
	     videoflag=1'b0;
	     resetStage=1'b0;
	     data_debug=16'h0246;
	     Rn[1]=16'h0121;
	     Rn[3]=16'h0241;
	     bus_vga_pos= 16'h0205;
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
            
         end else begin 
		    //debug with vga===============================
		    casex(stage) 
		      8'h40: begin 
			     videoflag=1'b1; 					
              end 				 
		      8'h41: begin 				 
			     bus_vga_pos= 16'h0205; 					
                 bus_vga_char= Rn[3];
		      end 
		      8'h42: begin 
			     videoflag=1'b0; 				
		      end 
		    endcase	
		    //end===================================	
            casez(IR)   
              16'b110000??????????: begin
                 //`instruction_load;==================================
                 casex(stage) 
                   8'h01: begin 
                      bus_RAM_ADDRESS=PC;
                   end 
                   8'h02: begin 
                   END=bus_RAM_DATA_IN; 
                   PC=PC+1;     
                 end 
              8'h03: begin 
                 bus_RAM_ADDRESS=END;
                 end 
         8'h04: begin 
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
                   PC=PC+1;
                 end 
              8'h03: begin 
                 bus_RAM_ADDRESS=END;
                 end 
         8'h04: begin 
            wire_RW=1'b1;
            bus_RAM_DATA_OUT=Rn[IR[9:7]];
         end 
                   8'h05: begin 
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
                      PC=PC+1; 
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
                 endcase
              end
              16'b110011??????????: begin
                 //`instruction_mov;=================================
                 
                 casex(stage) 
                   8'h01: begin 
                      casez(IR[1:0]) 
                        2'bX0: begin 
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
                 //data_debug=2'h0041;
			     casex(stage)
                   8'h01: begin 
				      bus_vga_pos=Rn[IR[6:4]]; 
                      bus_vga_char= Rn[IR[9:7]]; 
                   end 
                   8'h02: begin 
                      videoflag=1'b1; 
                   end 
				   8'h03: begin 
				      videoflag=1'b0; 
				   end 
                   8'h90: begin                    
                      processing_instruction=1'b0; 
                      resetStage=1'b1; 
                   end 
			     endcase
              end
              16'b000010??????????: begin
                 //`instructions_jump;==============================
                 
                 
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
                           if(EQual==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0010: begin 
                           if(EQual==1'b0) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0011: begin 
                           if(Zero==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0100: begin 
                           if(Zero==1'b0) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end
                        4'b0101: begin 
                           if(Carry==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0110: begin 
                           if(Carry==1'b0) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b0111: begin 
                           if(GReater==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1000: begin 
                           if(LEsser==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1001: begin 
                           if((GReater|EQual)==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1010: begin 
                           if((LEsser|EQual)==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1011: begin 
                           if(Overflow==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1100: begin 
                           if(Overflow==1'b0) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1101: begin 
                           if(Negative==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                        4'b1110: begin 
                           if(DivbyZero==1'b1) begin 
                              PC=bus_RAM_DATA_IN-16'h0001; 
                           end 
                        end 
                      endcase 
                   end 
				   8'h03: begin
				      PC=PC+16'h0001;
				   end
                   8'h04: begin 
				      bus_RAM_ADDRESS=PC;                    
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
