module  cpu_v32_5(wire_clock, wire_reset, bus_RAM_DATA_IN,bus_RAM_DATA_OUT,bus_RAM_ADDRESS,wire_RW, bus_keyboard, videoflag, bus_vga_pos, bus_vga_char,data_debug, led);
   input wire         wire_clock;
   input wire         wire_reset;
   input wire [31:0]  bus_RAM_DATA_IN; //from 16 to 32
   output wire [31:0]  bus_RAM_DATA_OUT; //from 16 to 32
   output wire [31:0]  bus_RAM_ADDRESS; //from 16 to 32
   output wire         wire_RW;
   input  wire [7:0]  bus_keyboard;
   output wire         videoflag;
   output wire [15:0]  bus_vga_pos;
   output wire [15:0]  bus_vga_char;
   output wire [15:0]  data_debug;
   output wire [15:0]  led;

    
   wire [31:0]         m2;             
   wire [31:0]         m3;
   wire [31:0]         m4;
   
   
   wire                enable_alu;      
   wire [5:0]          opCode;
   wire                useCarry;
   wire                useDec;
   wire [15:0]         FR_in_at_control;
   wire [15:0]         FR_out_at_control;   


   wire [2:0]          flagToShifthAndRot;
   
   alu_v32_5 alu_v_dut(wire_clock,enable_alu,m2,m3,m4,opCode,FR_out_at_control,FR_in_at_control,useCarry,flagToShifthAndRot,useDec);
   control_unit_v control_v_dut(wire_clock, wire_reset, bus_RAM_DATA_IN,bus_RAM_DATA_OUT,bus_RAM_ADDRESS,wire_RW, bus_keyboard, videoflag, bus_vga_pos, bus_vga_char,enable_alu,FR_in_at_control,FR_out_at_control,opCode,useCarry,flagToShifthAndRot,useDec,m2,m3,m4,data_debug, led);
   
endmodule 
