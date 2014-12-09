`include "../CPU_def.sv"

module alu(
	input reg [PC_BITS - 1 : 0] src_a_e,
	input reg [PC_BITS - 1 : 0] src_b_e,
	
	input reg [3 : 0] alu_control_opr

	output reg [PC_BITS - 1 : 0] alu_out_e
);

	always_comb begin
		case (alu_control_opr)
			ALU_ADD: alu_out_e = src_a_e + src_b_e;
			ALU_SUB: alu_out_e = src_a_e - src_b_e;
			ALU_AND: alu_out_e = src_a_e & src_b_e;
			ALU_OR: alu_out_e = src_a_e | src_b_e;
			ALU_SLT: alu_out_e = src_a_e < src_b_e;
			ALU_MUL: alu_out_e = src_a_e * src_b_e;
			default alu_out_e = 32'b0;
		endcase
	end

endmodule
