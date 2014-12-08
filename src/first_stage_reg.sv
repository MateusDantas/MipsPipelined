`include "CPU_def.sv"

module first_stage_reg(
	input clk, 
	input enable, input clr, 
	
	input [PC_BITS - 1 : 0] instr_f, 
	input [PC_BITS - 1 : 0] pc_plus_4f, 
	
	output [PC_BITS - 1 : 0] instr_d, 
	output [PC_BITS - 1 : 0] pc_plus_4d
);

always @(posedge clr, posedge clr) begin
	if (clr) begin
		instr_d <= 32'd0;
		pc_plus_4d <= 32'd0;
	end
	else if (enable) begin
		instr_d <= instr_f;
		pc_plus_4d <= pc_plus_4f;
	end

endmodule


