`include "CPU_def.sv"

module pc_mux(
	input [PC_BITS - 1 : 0] pc_plus_4, 
	input [PC_BITS - 1 : 0] pc_branch, 
	input [PC_BITS - 1 : 0] pc_jump, 
	input pc_scr, 
	input jump, 

	output [PC_BITS - 1 : 0] pc
);

	always_comb pc = jump ? pc_jump : (pc_scr ? pc_branch : pc_plus_4);

endmodule
