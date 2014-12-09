`include "CPU_def.sv"

module hazard_unit(
	input [4 : 0] rs_e,
	input [4 : 0] rt_e,
	
	input rs_d,
	input rt_d,
	
	input mem_to_reg_e,
	input mem_to_reg_m,

	input write_reg_e,
	input reg_write_e,
	input write_reg_m,
	input reg_write_m,
	input write_reg_w,
	input reg_write_w,

	input branch_d,

	output [1 : 0] forward_a_e,
	output [1 : 0] forward_b_e,

	output forward_a_d,
	output forward_b_d,
	
	output stall_f,
	output stall_d,
	output flush_e
);

	always_comb begin
		if ((rs_e != 0) & (rs_e == write_reg_m) & reg_write_m)
			forward_a_e = 2'b10;
		else if ((rs_e != 0) && (rs_e == write_reg_w) && reg_wrote_w)
			forward_a_e = 2'b01;
		else
			forward_a_e = 2'b00;
	end

	always_comb begin
		if ((rt_e != 0) && (rt_e == write_reg_m) && reg_write_m)
			forward_b_e = 2'b10;
		else if ((rt_e != 0) && (rt_e == write_reg_w) && reg_wrote_w)
			forward_b_e = 2'b01;
		else
			forward_b_e = 2'b00;
	end
	
	logic forward_decode;
	
	always_comb begin
		forward_a_d = (rs_d != 0) & (rs_d == write_reg_m) & reg_write_m;
		forward_b_d = (rt_d != 0) & (rt_d == write_reg_m) & reg_write_m;
	end

	logic lwstall;
	logic branch_stall;

	always_comb begin
		lwstall = ((rs_d == rt_e) | (rt_d == rt_e)) & mem_to_reg_e;
		branch_stall = (branch_d & reg_write_e & (write_reg_e == rs_d | write_reg_e == rt_d)) | (branch_d & mem_to_reg_m & (write_reg_m == rs_d | write_reg_m == rt_d); 
		stall_f = lw_stall | branch_stall;
		stall_d = lw_stall | branch_stall;
		flush_e = lw_stall | branch_stall;
	end

endmodule
	
