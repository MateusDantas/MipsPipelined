`include "../CPU_def.sv"

module data_mux(
	input logic [PC_BITS - 1 : 0] read_data_1,
	input logic [PC_BITS - 1 : 0] read_data_2,

	input logic [PC_BITS - 1 : 0] alu_out_m,

	input wire forward_a_d,
	input wire forward_b_d,

	output wire equal_d
);

	always_comb begin
		equal_d = ((forward_a_d ? alu_out_m : read_data_1) == (forward_b_d ? alu_out_m : read_data_2));
	end

endmodule
