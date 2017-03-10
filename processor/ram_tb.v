module ram_tb;
reg  [15:0] address_tb;
reg clock_tb;
reg [15:0] data_tb;
reg wren_tb;
wire  [15:0]q_tb;
RAM ram_dut(address_tb, clock_tb, data_tb, wren_tb, q_tb);
initial
begin
address_tb = 16'h0000;	clock_tb = 1'b0;	data_tb = 16'h0000;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
address_tb = 16'h0000;	clock_tb = 1'b1;	data_tb = 16'h0000;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
address_tb = 16'h0000;	clock_tb = 1'b0;	data_tb = 16'h0000;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
address_tb = 16'h0000;	clock_tb = 1'b1;	data_tb = 16'h0000;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);

//address_tb = 16'h0002;	clock_tb = 1'b0;	data_tb = 16'h0003;  wren_tb=1'b0;  #1
//$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
//address_tb = 16'h0002;	clock_tb = 1'b1;	data_tb = 16'h0003;  wren_tb=1'b1;  #1
//$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
//address_tb = 16'h0002;	clock_tb = 1'b0;	data_tb = 16'h0003;  wren_tb=1'b1;  #1
//$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
//address_tb = 16'h0002;	clock_tb = 1'b1;	data_tb = 16'h0003;  wren_tb=1'b1;  #1
//$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);

address_tb = 16'h0002;	clock_tb = 1'b0;	data_tb = 16'h0003;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
address_tb = 16'h0002;	clock_tb = 1'b1;	data_tb = 16'h0003;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
address_tb = 16'h0002;	clock_tb = 1'b0;	data_tb = 16'h0003;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
address_tb = 16'h0002;	clock_tb = 1'b1;	data_tb = 16'h0003;  wren_tb=1'b0;  #1
$display("address = %h, clock = %x, data = %h, wren = %x, q = %h", address_tb, clock_tb, data_tb, wren_tb,q_tb);
end

endmodule