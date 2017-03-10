`define instruction_outchar \
casex(stage) \
  8'h01: begin \
	 videoflag=1'b1;\
  end \
  8'h10: begin \
     bus_vga_char=16'h0241; \
	 bus_vga_pos=16'h0131; \
   end \
    8'h13: begin \
     videoflag=1'b0;\
   end \
   8'h15: begin \
      bus_vga_char=16'h0242; \
      bus_vga_pos=16'h0101;\
   end \
   8'h19: begin \
      videoflag=1'b1;\
   end \
  8'h39: begin \
     videoflag=1'b1;\
     processing_instruction=1'b1; \
     resetStage=1'b0; \
  end \
endcase
