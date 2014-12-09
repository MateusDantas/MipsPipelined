`include "../CPU_def.sv"


module instr_mem(input clk, input [PC_BITS - 1 : 0] adress, output reg [PC_BITS - 1 : 0] data_out);

	reg [PC_BITS - 1 : 0] mem [MAX_MEM_SIZE - 1 : 0];
	
	always_comb data_out = mem[adress];

endmodule
