`include "CPU_def.sv"

module pc_adder(input [PC_BITS - 1 : 0] pc, output [PC_BITS - 1 : 0] pc_plus_4);
	always_comb pc_plus_4 = pc + 4;
endmodule 
