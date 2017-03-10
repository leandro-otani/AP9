`define loadInstruction \
casex(stage) \
  8'h01: begin \
     bus_RAM_ADDRESS=PC;\
  end \
  8'h02: begin \
     processing_instruction=1'b1; \
     IR=bus_RAM_DATA_OUT; \
     PC=PC+1'b1; \
     resetStage=1'b1; \
  end \
endcase
