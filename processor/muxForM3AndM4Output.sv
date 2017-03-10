module muxForM3AndM4Output(wire_clock,selectRegister,r0,r1,r2,r3,r4,r5,r6,r7,wireForM3OrM4);
   input  wire  wire_clock;
   input  wire  [3:0]  selectRegister;
	input  wire  [15:0]  r0;
	input  wire  [15:0]  r1;
	input  wire  [15:0]  r2;
	input  wire  [15:0]  r3;
	input  wire  [15:0]  r4;
	input  wire  [15:0]  r5;
	input  wire  [15:0]  r6;
	input  wire  [15:0]  r7;
	output reg  [15:0]  wireForM3OrM4;
	always @ (posedge wire_clock ) begin
		casex(selectRegister) 
			3'b000: wireForM3OrM4=r0;
			3'b001: wireForM3OrM4=r1;
			3'b010: wireForM3OrM4=r2;
			3'b011: wireForM3OrM4=r3;
			3'b100: wireForM3OrM4=r4;
			3'b101: wireForM3OrM4=r5;
			3'b110: wireForM3OrM4=r6;
			3'b111: wireForM3OrM4=r7;		 
		endcase
	end
endmodule
