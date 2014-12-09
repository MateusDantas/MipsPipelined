`include "../CPU_def.sv"

module forward_data_b(
	input [PC_BITS - 1 : 0] read_data_2_e,
	input [PC_BITS - 1 : 0] result_w,
	input [PC_BITS - 1 : 0] alu_out_m,
	
	input wire forward_b_e,

	output reg [PC_BITS - 1 : 0] write_data_e
);

	always_comb begin
		if (forward_b_e == 2'b00)
			write_data_e = read_data_2_e;
		else if (forward_b_e == 2'b01)
			write_data_e = result_w;
		else
			write_data_e = alu_out_m;
	end

endmodule

	


