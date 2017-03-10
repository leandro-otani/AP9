module muxForM3AndM4Input (wire_clock,selectRegister,r0,r1,r2,r3,r4,r5,r6,r7,wireForM3OrM4);
   input  wire  wire_clock;
	input  wire  [3:0]  selectRegister;
	output  reg  [15:0]  r0;
	output  reg  [15:0]  r1;
	output  reg  [15:0]  r2;
	output  reg  [15:0]  r3;
	output  reg  [15:0]  r4;
	output  reg  [15:0]  r5;
	output  reg  [15:0]  r6;
	output  reg  [15:0]  r7;
   input	  wire [15:0]  wireForM3OrM4;
	always @ (posedge wire_clock ) begin
		casex(selectRegister) 
			3'b000: r0=wireForM3OrM4;
			3'b001: r1=wireForM3OrM4;
			3'b010: r2=wireForM3OrM4;
			3'b011: r3=wireForM3OrM4;
			3'b100: r4=wireForM3OrM4;
			3'b101: r5=wireForM3OrM4;
			3'b110: r6=wireForM3OrM4;
			3'b111: r7=wireForM3OrM4;
		endcase
	end

endmodule