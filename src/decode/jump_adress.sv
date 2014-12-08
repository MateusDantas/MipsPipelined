`include "CPU_def.sv"

module jump_adress(
	input [25 : 0] instr_d,
	input [3 : 0] pc_plus_4d,

	output [PC_BITS - 1 : 0] pc_jump
);

	always_comb pc_jump = {{pc_plus_4d[3 : 0]}, {instr_d[25 : 0] << 2}};

endmodule

