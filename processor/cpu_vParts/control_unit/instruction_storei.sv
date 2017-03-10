`define instruction_storei \
casex(stage) \
  8'h01: begin \
     bus_RAM_ADDRESS=Rn[IR[9:7]];\
  end \
  8'h02: begin \
     wire_RW=1'b1;\
     bus_RAM_DATA_IN=Rn[IR[6:4]];\
  end \
  8'h03: begin \
     wire_RW=1'b0;\
     processing_instruction=1'b0;\
     resetStage=1'b1; \
  end \
endcase
