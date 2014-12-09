`include "../CPU_def.sv"

module mux_wb(
	input mem_to_reg_wb,
	input reg [PC_BITS - 1 : 0] alu_out_wb,
	input [PC_BITS - 1 : 0] read_data_wb,
	input pc_plus_4wb,

	output result_w
);
	
	always_comb begin
		if (mem_to_reg_wb == 2'b00)
			result_w = read_data_wb;
		else if (mem_to_reg_wb == 2'b01)
			result_w = alu_out_wb;
		else
			result_w = pc_plus_4wb;
	end

endmodule
