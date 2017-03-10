`include "cpu_vParts/control_unit/loadInstruction.sv"
`include "cpu_vParts/control_unit/instruction_load.sv"
`include "cpu_vParts/control_unit/instruction_store.sv"
`include "cpu_vParts/control_unit/instruction_storei.sv"
`include "cpu_vParts/control_unit/instruction_loadi.sv"
`include "cpu_vParts/control_unit/instruction_loadn.sv"
`include "cpu_vParts/control_unit/instruction_mov.sv"
`include "cpu_vParts/control_unit/instruction_outchar.sv"
`include "cpu_vParts/control_unit/instructions_jump.sv"
module  cpu_v(wire_clock, wire_reset, bus_RAM_DATA_IN,bus_RAM_DATA_OUT,bus_RAM_ADDRESS,wire_RW, bus_keyboard, videoflag, bus_vga_pos, bus_vga_char,data_debug);
   input wire         wire_clock;
   input wire         wire_reset;
   output reg [15:0]  bus_RAM_DATA_IN;
   input wire [15:0]  bus_RAM_DATA_OUT;
   output reg [15:0]  bus_RAM_ADDRESS;
   output reg         wire_RW;
   input  wire [7:0]  bus_keyboard;
   output reg        videoflag;
   output reg [15:0] bus_vga_pos;
   output reg [15:0] bus_vga_char;
   output reg [15:0]  data_debug;

   
   reg               resetStage;   
   reg [7:0]         stage;
   reg               processing_instruction;
   reg [15:0]        IR;
   reg [15:0]        PC;
   reg [7:0][15:0]   Rn;
   reg [15:0]        END;
   reg [5:0]         endReg;
   reg [15:0]        dataIn;
   reg [15:0]        dataOut;
   reg [31:0]        SP;
   reg               wr;
   reg               clock;
   
   
   reg               EQual;
   reg               Zero;
   reg               Carry;
   reg               GReater;
   reg               LEsser;
   reg               Overflow;
   reg               Negative;
   reg               DivbyZero;


   reg               startedProcessing;



//selectRegisterToWrite selRxToW(endReg,Rn1,dataIn,wr);
//selectRegisterToRead  selRxToR(endReg,Rn,dataOut,wr);
   initial begin
      stage=8'h00;
      processing_instruction=1'b0;
      wire_RW=1'b0;    
      data_debug=16'h0000;
      PC= 16'h0000;
      EQual=1'b1;
      Zero=1'b0;
      Carry=1'b0;
      GReater=1'b0;
      LEsser=1'b0;     
      Overflow=1'b0;
      Negative=1'b0;
      DivbyZero=1'b0;
      startedProcessing=1'b0;      
   end
   always @ (posedge wire_clock & startedProcessing) begin
      if(resetStage==1'b1 && stage==8'h01 ) begin
         resetStage=1'b0;         
      end
      if(processing_instruction == 1'b0) begin
         `loadInstruction;
         data_debug=16'hffff;
      end else begin 
         casez(IR)   
           16'b110000??????????: begin
              `instruction_load;
           end
           16'b110001??????????: begin
              data_debug=16'h1111;
              `instruction_store;
           end
		   16'b111101??????????: begin
              data_debug=16'haaaa;
              `instruction_storei;
           end
           16'b111100??????????: begin
              data_debug=16'hbbbb;
              `instruction_loadi;
           end
           16'b111000??????????: begin
              data_debug=16'h2222;
              `instruction_loadn;
           end
           16'b110011??????????: begin
              data_debug=16'h3333;
              `instruction_mov;
           end
           16'b110010??????????: begin
              `instruction_outchar;
           end
           16'b000010??????????: begin
              data_debug=16'h7777;
              `instructions_jump;
           end
         endcase
      end 
   end // always @ (posedge wire_clock)
   always @( negedge wire_clock) begin
      startedProcessing=1'b1;
      if(resetStage==1'b1) begin
         stage<=8'h01;    
      end
      else begin
         stage<=stage+8'h01;    
      end
   end
endmodule 
