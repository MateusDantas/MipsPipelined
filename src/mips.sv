
module mips(input clk, output result_w);

	parameter N = 32;
	parameter PC_ADDR_SIZE = 5;

	// FETCH
	wire [N - 1 : 0] pc;
	wire [N - 1 : 0] pc_f;
	
	
	wire [N - 1 : 0] pc_plus_4f;
	wire [N - 1 : 0] pc_branch_d;
	
	wire [N - 1 : 0] pc_jump;

	wire [N - 1 : 0] instr_f;
	//
	// FETCH - DECODE
	wire stall_d;	
	//
	// DECODE
	wire [N - 1 : 0] src_d;
	wire [N - 1 : 0] jump_d;
	wire [N - 1 : 0] instr_d;
	wire [N - 1 : 0] pc_plus_4d;
	wire [N - 1 : 0] sign_imm_d;
	wire halt;
	wire rst_register_file;
	wire [PC_ADDR_SIZE - 1 : 0] read_adress_1;
	wire [PC_ADDR_SIZE - 1 : 0] read_adress_2;
	wire [PC_ADDR_SIZE - 1 : 0] write_adress;
	wire [PC_ADDR_SIZE - 1 : 0] write_data;
	wire reg_write_d;
	wire mem_to_reg_d;
	wire mem_write_d;
	wire alu_control_d;
	wire alu_src_d;
	wire reg_dst_d;
	wire ext_op;
	wire branch_d;
	wire read_data_1_d;
	wire read_data_2_d;
	wire equal_d;
	wire funct;
	wire opcode;
	wire rs_d;
	wire rt_d;
	wire rd_d;
	//	
	// EXEC
	wire read_data_1_e;
	wire read_data_2_e;
	wire [N - 1 : 0] pc_plus_4e;
	wire [N - 1 : 0] sign_imm_e;
	wire rs_e;
	wire rt_e;
	wire rd_e;
	wire reg_write_e;
	wire mem_to_reg_e;
	wire mem_write_e;
	wire alu_control_e;
	wire alu_src_e;
	wire reg_dst_e;
	wire write_reg_e;
	wire [N - 1 : 0] write_data_e;
	wire [N - 1 : 0] src_a_e;
	wire [N - 1 : 0] src_b_e;
	wire [3 : 0] alu_control_opr;
	wire [N - 1 : 0] alu_out_e;
	//
	// MEMORY
	wire [N - 1 : 0] alu_out_m;
	wire reg_write_m;
	wire mem_to_reg_m;
	wire mem_write_m;
	wire [N - 1 : 0 ] write_data_m;
	wire [N - 1 : 0] pc_plus_4m;
	wire write_reg_m;
	wire [N - 1 : 0] read_data_m;
	//

	// WRITE BACK
	wire write_reg_w;
	wire reg_write_w;
	wire mem_to_reg_w;
	wire [N - 1 : 0] read_data_w;
	wire [N - 1 : 0] alu_out_w;
	wire [N - 1 : 0] pc_plus_4w; 
	// 
	

	// HAZARD UNIT
	wire forward_a_d;
	wire forward_b_d;
	wire forward_a_e;
	wire forward_b_e;
	wire flush_e;
	//

	wire stall_f;

	// BEGIN FETCH STAGE
		// PC MUX
		pc_mux pc_mux(
			.pc_plus_4f(pc_plus_4f),
			.pc_branch(pc_branch_d),
			.pc_jump(pc_jump),
			.jump(jump_d),
			.pc_scr(src_d),
			.pc(pc));

		// PC REG
		pc_reg pc_reg(
			.clk(clk),
			.stall_f(stall_f),
			.pc(pc),
			.pc_f(pc_f));

		// PC ADDER
		pc_adder pc_adder(
			.pc(pc_f),	
			.pc_plus_4(pc_plus_4f));

		// INSTRUCTION MEMORY
		instr_mem instr_mem(
			.clk(clk),
			.adress(pc_f),
			.data_out(instr_f));
	// END FET STAGE
	// BEGIN REG FETCH TO DECODE STAGE
	first_stage_reg first_stage_reg(
					.clk(clk),
					.stall_d(stall_d),
					.clr(src_d | jump_d),
					.instr_f(instr_f),
					.pc_plus_4f(pc_plus_4f),
					.instr_d(instr_d),
					.pc_plus_4d(pc_plus_4d));
	// END REG FETCH TO DECODE STAGE
	
	// BEGIN DECODE STAGE	
	jump_adress jump_adress(
				.instr_d(instr_d),
				.pc_plus_4d(pc_plus_4d),
				.pc_jump(pc_jump));
	
	sign_extend sign_extend(
				.instr_d(instr_d),
				.sign_imm(sign_imm_d));

	assign rst_register_file = 0;
	assign halt = 0;
	assign read_address_1 = instr_d[25 : 21];
	assign read_address_2 = instr_d[20 : 16];

	register_file register_file(
				.clk(clk),
				.rst(rst_register_file),
				.halt(halt),
				.read_address_1(read_src_a_eadress_1),
				.read_address_2(read_adress_2),
				.write_address(write_reg_w),
				.write_data(result_w),
				.write_enable(reg_write_w),
				.read_data_1(read_data_1_d),
				.read_data_2(read_data_2_d));

	pc_branch_add(
			.sign_imm(sign_imm_d),
			.pc_plus_4d(pc_plus_4d),
			.pc_branch_d(pc_branch_d));

	data_mux data_mux(
			.read_data_1(read_data_1_d),
			.read_data_2(read_data_2_d),
			.alu_out_m(alu_out_m),
			.forward_a_d(forward_a_d),
			.forward_b_d(forward_b_d),
			.equal_d(equal_d));

	assign funct = instr_d[31 : 26];
	assign opcode = instr_d[5 : 0];

	control_unit control_unit(
				.funct(funct),
				.op_code(opcode),
				.reg_write_d(reg_write_d),
				.mem_to_reg_d(mem_to_reg_d),
				.mem_write_d(mem_write_d),
				.alu_control_d(alu_control_d),
				.alu_src_d(alu_src_d),
				.reg_dst_d(reg_dst_d),
				.ext_op(ext_op),
				.jump_d(jump_d),
				.branch_d(branch_d));

	assign src_d = equal_d | branch_d;

	// END DECODE STAGE
	// BEGIN REG DECODE TO EXECUTE STAGE	
	reg_decode_exec reg_decode_exec(
					.clk(clk),
					.flush_e(flush_e),
					.reg_write_d(reg_write_d),
					.mem_to_reg_d(mem_to_reg_d),
					.mem_write_d(mem_write_d),
					.alu_control_d(alu_control_d),
					.alu_src_d(alu_src_d),
					.reg_dst_d(reg_dst_d),
					.read_data_1_d(read_data_1_d),
					.read_data_2_d(read_data_2_d),
					.read_data_1_e(read_data_1_e),
					.read_data_2_e(read_data_2_e),
					.pc_plus_4d(pc_plus_4d),
					.pc_plus_4e(pc_plus_4e),
					.sign_imm_d(sign_imm_d),
					.sign_imm_e(sign_imm_e),
					.rs_d(rs_d),
					.rt_d(rt_d),
					.rd_d(rt_d),
					.rs_e(rs_e),
					.rt_e(rt_e),
					.rd_e(rd_e),
					.reg_write_e(reg_write_e),
					.mem_to_reg_e(mem_to_reg_e),
					.mem_write_e(mem_write_e),
					.alu_control_e(alu_control_e),
					.alu_src_e(alu_src_e),
					.reg_dst_e(reg_dst_e));
	// END REG DECODE TO EXEC STAGE
	// EXEC STAGE
	reg_mux reg_mux(
			.reg_dst_e(reg_dst_e),
			.rt_e(rt_e),
			.rd_e(rd_e),
			.write_reg_e(write_reg_e));
	forward_data_b forward_data_b(
				.read_data_2_e(read_data_2_e),
				.result_w(result_w),
				.alu_out_m(alu_out_m),
				.forward_b_e(forward_b_e),
				.write_data_e(write_data_e));
	forward_data_a forward_data_a(
				.read_data_1_e(read_data_1_e),
				.result_w(result_w),
				.alu_out_m(alu_out_m),
				.forward_a_e(forward_a_e),
				.src_a_e(src_a_e));
	data_b_mux data_b_mux(
				.write_data_e(write_data_e),
				.sign_imm_e(sign_imm_e),
				.alu_src_e(alu_src_e),
				.src_b_e(src_b_e));
	alu_control alu_control(
				.funct(funct),
				.alu_control_e(alu_control_e),
				.alu_control_opr(alu_control_opr));
	alu alu(
		.src_a_e(src_a_e),
		.src_b_e(src_b_e),
		.alu_control_opr(alu_control_opr),
		.alu_out_e(alu_out_e));
	// END EXEC STAGE
	// BEGIN REG EXEC TO MEM STAGE
	wire clr_exec_reg;
	assign clr_exec_reg = 0;
	reg_exec_mem reg_exec_mem(
				.clk(clk),
				.clr(clr_exec_reg),
				.reg_write_e(reg_write_e),
				.mem_to_reg_e(mem_to_reg_e),	
				.mem_write_e(mem_write_e),
				.alu_out_e(alu_out_e),
				.write_data_e(write_data_e),
				.pc_plus_4e(pc_plus_4e),
				.write_reg_e(write_reg_e),
				.reg_write_m(reg_write_m),
				.mem_to_reg_m(mem_to_reg_m),	
				.mem_write_m(mem_write_m),
				.alu_out_m(alu_out_m),
				.write_data_m(write_data_m),
				.pc_plus_4m(pc_plus_4m),
				.write_reg_m(write_reg_m));
				
	// END REG EXEC TO MEM STAGE
	// BEGIN MEMORY STAGE
	data_memory data_memory(
				.clk(clk),
				.rst(clr_exec_reg),
				.alu_out_m(alu_out_m),
				.write_data_m(write_data_m),
				.mem_write_m(mem_write_m),
				.read_data_m(read_data_m));
	// END MEMORY STAGE
	// BEGIN REG MEMORY TO WRITE BACK STAGE
	reg_mem_wb reg_mem_wb(
				.clk(clk),
				.rst(clr_exec_reg),
				.reg_write_m(reg_write_m),
				.mem_to_reg_m(mem_to_reg_m),
				.read_data_m(read_data_m),
				.alu_out_m(alu_out_m),
				.write_reg_m(write_reg_m),
				.pc_plus_4m(pc_plus_4m),
				.reg_write_w(reg_write_w),
				.mem_to_reg_w(mem_to_reg_w),
				.read_data_w(read_data_w),
				.alu_out_w(alu_out_w),
				.write_reg_w(write_reg_w),
				.pc_plus_4w(pc_plus_4w));
	// END REG MEMORY TO WRITE BACK STAGE
	// BEGIN WRITE BACK
	mux_wb mux_wb(
			.mem_to_reg_wb(mem_to_reg_w),
			.alu_out_wb(alu_out_w),
			.read_data_wb(read_data_w),
			.pc_plus_4wb(pc_plus_4w),
			.result_w(result_w));
	// END WRITE BACK

endmodule
