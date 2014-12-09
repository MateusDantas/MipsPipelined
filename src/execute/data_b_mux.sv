`include "CPU_def.sv"

module data_b_mux(
	input reg [PC_BITS - 1 : 0] write_data_e,
	input [PC_BITS - 1 : 0] sign_imm_e,
	
	input reg alu_src_e,

	output reg [PC_BITS - 1 : 0] src_b_e
);

	always_comb begin
		if (alu_src_e == 1'b0)
			src_b_e <= write_data_e;
		else
			src_b_e <= sign_imm_e;
	end

endmodule
