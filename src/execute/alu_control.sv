`include "CPU_def.sv"

module alu_control(
	input [5 : 0] funct,
	input alu_control_e,
	
	output reg [3 : 0] alu_control_opr
);

	always_comb begin
		case (alu_control_e)
			ROP: begin
				case (funct)
					ADD: alu_control_opr <= ALU_ADD;
					SUB: alu_control_opr <= ALU_SUB;
					AND: alu_control_opr <= ALU_AND;
					OR: alu_control_opr <= ALU_OR;
					SLT: alu_control_opr <= ALU_SLT;
					MUL: alu_control_opr <= ALU_MUL;
					default: $display("unknown funct");
				endcase
			LWSW: alu_control_ex <= ALU_ADD;
			IOP: alu_control_ex <= ALU_SUB;
			default: $display("unknown opr");
		endcase
	end

endmodule
