`define instructions_jump \
casex(stage) \
   8'h01: begin \
     bus_RAM_ADDRESS=PC; \
  end \
  8'h02: begin \
     casex(IR[9:6]) \
       4'b0000: begin \
          PC=bus_RAM_DATA_OUT-16'h0001; \
       end \
       4'b0001: begin \
          if(EQual==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b0010: begin \
          if(EQual==1'b0) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b0011: begin \
          if(Zero==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b0100: begin \
          if(Zero==1'b0) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b0101: begin \
          if(Carry==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b0110: begin \
          if(Carry==1'b0) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b0111: begin \
          if(GReater==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b1000: begin \
          if(LEsser==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b1001: begin \
          if((GReater|EQual)==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b1010: begin \
          if((LEsser|EQual)==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b1011: begin \
          if(Overflow==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b1100: begin \
          if(Overflow==1'b0) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b1101: begin \
          if(Negative==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
       4'b1110: begin \
          if(DivbyZero==1'b1) begin \
             PC=bus_RAM_DATA_OUT-16'h0001; \
          end \
       end \
     endcase \
  end \
  8'h03: begin \
     Rn[IR[9:7]]=bus_RAM_DATA_OUT; \
     PC=PC+1; \
     processing_instruction=1'b0; \
     resetStage=1'b1; \
  end \
endcase
