`define PC_BITS 32
`define PC_ADDR_SIZE 5
`define MAX_MEM_SIZE 1024
`define SIZE_MEMORY 1024

`define ALU_ADD 4'b0010
`define ALU_SUB 4'b0110
`define ALU_AND 4'b0000
`define ALU_OR 4'b0001
`define ALU_SLT 4'b0111
`define ALU_MUL 4'b1111

`define ROP_CONTROL 2'b10
`define LWSW 2'b00
`define IOP 2'b01

`define ADD 6'b1000000
`define SUB 6'b100010
`define AND 6'b100100
`define OR 6'b100101
`define SLT 6'b101010
`define MUL 6'b100001

`define ROP 6'b000000
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100
`define ADDI 6'b001000
`define NOP 6'b100000
`define J 6'b000010
`define JAL 6'b000011
`define LWR 7'b0



