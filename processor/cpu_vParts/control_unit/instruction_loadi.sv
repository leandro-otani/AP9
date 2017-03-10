`define instruction_loadi \
casex(stage) \
  8'h01: begin \
     bus_RAM_ADDRESS=Rn[IR[6:4]];\
  end \
  8'h02: begin \
     Rn[IR[9:7]]=bus_RAM_DATA_OUT;\
     processing_instruction=1'b0;\
     resetStage=1'b1; \
  end \
endcase
