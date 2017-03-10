`define loadInstruction() \
stage=stage+8'h01; \
casex(stage) \
  8'h01: begin \
     data_debug=instruction;\
     processing_instruction=1'b1;\
     stage=8'h00; \
    end  \
  8'h02: begin \
  end \
endcase
