module  clock_gen (clk_out);
   reg clk;   
   output wire clk_out;   
   initial clk=1;
	assign clk_out=clk;
   always begin
	#20000 clk=~clk;
	
   end	
endmodule //
