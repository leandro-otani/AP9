module muxRn(selectRegister,r0,r1,r2,r3,r4,r5,r6,r7,m3OrM4);
	input  wire  [3:0]  selectRegister;
	input  wire  [15:0]  r0;
	input  wire  [15:0]  r1;
	input  wire  [15:0]  r2;
	input  wire  [15:0]  r3;
	input  wire  [15:0]  r4;
	input  wire  [15:0]  r5;
	input  wire  [15:0]  r6;
	input  wire  [15:0]  r7;
	output wire  [15:0] m3OrM4;
	assign m3OrM4  =  	(selectRegister == 3'b000 ) ? r0 : 
	(selectRegister == 3'b001 ) ? r1 : 
	(selectRegister == 3'b010 ) ? r2 : 
	(selectRegister == 3'b011 ) ? r3 : 
	(selectRegister == 3'b100 ) ? r4 : 
	(selectRegister == 3'b101 ) ? r5 : 
	(selectRegister == 3'b110 ) ? r6 : 
	(selectRegister == 3'b111 ) ? r7 : 8'h00;
endmodule
