`include "../CPU_def.sv"

module forward_data_a(
	input [PC_BITS - 1 : 0] read_data_1_e,
	input [PC_BITS - 1 : 0] result_w,
	input [PC_BITS - 1 : 0] alu_out_m,
	
	input wire forward_a_e,

	output reg [PC_BITS - 1 : 0] src_a_e
);

	always_comb begin
		if (forward_a_e == 2'b00)
			src_a_e = read_data_1_e;
		else if (forward_a_e == 2'b01)
			src_a_e = result_w;
		else
			src_a_e = alu_out_m;
	end

endmodule

	


