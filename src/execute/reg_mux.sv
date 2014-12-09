`include "../CPU_def.sv"

module reg_mux(
	input reg reg_dst_e, 
	input rt_e,
	input rd_e,

	output write_reg_e
);

	always_comb begin
		if (reg_dst_e == 2'b00)
			write_reg_e = rt_e;
		else if (reg_dst_e == 2'b01)
			write_reg_e = rd_e;
		else
			write_reg_e = 5'b11111;
	end

endmodule
