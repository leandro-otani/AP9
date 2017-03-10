`define instruction_mov \
casex(stage) \
  8'h01: begin \
     casez(IR[1:0]) \
       2'b?0: begin \
          Rn[IR[9:7]]= Rn[IR[6:4]]; \
       end \
       2'b01: begin \
          Rn[IR[9:7]]=SP; \
       end \
       2'b11: begin \
          SP=Rn[IR[9:7]]; \
      end \
     endcase \
  end \
  8'h02: begin \
     processing_instruction=1'b0; \
     resetStage=1'b1; \
  end \
endcase
