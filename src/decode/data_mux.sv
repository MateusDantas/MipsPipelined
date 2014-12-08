`include "CPU_def.sv"

module data_mux(
	input logic [PC_BITS - 1 : 0] read_data_1,
	input logic [PC_BITS - 1 : 0] read_data_2,

	input logic [PC_BITS - 1 : 0] alu_out_m,

	input wire forward_a,
	input wire forward_b,

	output wire equal_d
);

	always_comb begin
		equal_d = ((forward_a ? alu_out_m : read_data_1) == (forward_b ? alu_out_m : read_data_2));
	end

endmodule
