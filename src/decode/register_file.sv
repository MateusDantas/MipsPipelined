`include "CPU_def.sv"

module register_file(
	input wire clk,
	input wire rst,
	
	input wire halt,

	input wire [PC_ADDR_SIZE - 1 : 0] read_adress_1, 
	input wire [PC_ADDR_SIZE - 1 : 0] read_adress_2, 

	input wire [PC_ADDR_SIZE - 1 : 0] write_adress, 
	input wire [PC_BITS - 1 : 0] write_data, 
	input wire write_enable, 
	
	output logic [PC_BITS - 1 : 0] read_data_1, 
	output logic [PC_BITS - 1 : 0] read_data_2,
);

	logic [PC_BITS - 1 : 0] mem[PC_BITS - 1 : 0];

	always_comb begin
		read_data_1 = mem[read_adress_1];
		read_data_2 = mem[read_adress_2];
	end	

	always_ff@(posedge clk, posedge rst) begin
		if (rst) begin
			mem <= '{default:0};
		end
		else if (~halt && write_enable) begin
			mem[write_adress] <= write_data;
		end
	end

endmodule
				
			
