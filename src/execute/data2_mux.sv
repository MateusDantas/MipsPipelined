`include "../CPU_def.sv"

module data2_mux(
	input wire forward_a_e,
	
	input logic [PC_BITS - 1 : 0] read_data_1_e,
	input logic [PC_BITS - 1 : 0] read_data_2_e,


