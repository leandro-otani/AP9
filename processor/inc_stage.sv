module  inc_stage(stage_input,stage_output, startedProcessing, clock ) ;
           
   input wire [7:0] stage_input;
   output reg [7:0] stage_output;
   output           startedProcessing;
   input  wire      clock;
   
   always @( negedge clock) begin
      startedProcessing=1'b1;
      stage_output<=stage_input+8'h01;
   end
   
endmodule 
