`include "CPU_def.sv"

module sign_extend(input [15 : 0] instr_d, output [PC_BITS - 1 : 0] sign_imm);
	
	always_comb sign_imm = {{16{instr_d[15]}}, instr_d[15 : 0]};

endmodule
