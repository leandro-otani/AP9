`define instruction_load \
casex(stage) \
  8'h01: begin \
     bus_RAM_ADDRESS=PC;\
  end \
  8'h02: begin \
     END=bus_RAM_DATA_OUT; \
     PC=PC+1;     \
   end \
  8'h03: begin \
      bus_RAM_ADDRESS=END;\
  end \
  8'h04: begin \
     Rn[IR[9:7]]=bus_RAM_DATA_OUT;\
     processing_instruction=1'b0;\
     resetStage=1'b1;\
  end \
endcase
