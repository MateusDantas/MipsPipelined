`include "CPU_def.sv"

module pc_branch_add(
	input wire [PC_BITS - 1 : 0] sign_imm, 
	input wire [PC_BITS - 1 : 0] pc_plus_4d, 

	output wire [PC_BITS - 1 : 0] pc_branch_d
);
	
	always_comb pc_branch_d = (sign_imm << 2) + pc_plus_4d;

endmodule
