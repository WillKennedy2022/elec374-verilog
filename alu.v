// alu.v, Arithmetic Logic Unit module
`timescale 1ns/10ps

module alu (

	output reg [31:0] regZH, regZL,
	
	input clock,
	input clear, 
	input IncPC,

	input wire [31:0] regA,
	input wire [31:0] regB,
	input wire [4:0] opcode

);

	parameter alu_add = 5'b00011, alu_sub = 5'b00100, alu_shr = 5'b00101, alu_shl = 5'b00110, alu_ror = 5'b00111, alu_rol = 5'b01000, alu_and = 5'b01001, alu_or = 5'b01010, alu_mult = 5'b01110, 
	alu_div = 5'b01111, alu_neg = 5'b10000, alu_not = 5'b10001; //following the opcode provided in the CPU_spec file provided for the lab

	wire [31:0] IncPC_out, add_op_sum, add_op_cout, sub_op_sum, sub_op_cout, shr_op_out, shl_op_out, ror_op_out, rol_op_out, and_op_out, or_op_out, neg_op_out, not_op_out;
	wire [63:0] mult_op_out, div_op_out;

	always @ (*)
		begin
			case(opcode)

			alu_add: begin
				regZL <= add_op_cout[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the ADDITION operation 
				regZH <= 32'd0; //initialization
			end

			alu_sub: begin
				regZL <= sub_op_cout[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the SUBTRACTION operation 
				regZH <= 32'd0; //initialization
			end

			alu_shr: begin
				regZL <= shr_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the SHIFT RIGHT operation 
				regZH <= 32'd0; //initialization
			end
	
			alu_shl: begin
				regZL <= shl_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the SHIFT LEFT operation 
				regZH <= 32'd0; //initialization
			end

			alu_ror: begin
				regZL <= ror_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the ROTATE RIGHT operation 
				regZH <= 32'd0; //initialization
			end

			alu_rol: begin
				regZL <= rol_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the ROTATE LEFT operation 

				regZH <= 32'd0; //initialization
			end

			alu_and: begin
				regZL <= and_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the AND operation 
				regZH <= 32'd0; //initialization
			end

			alu_or: begin
				regZL <= or_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the OR operation 
				regZH <= 32'd0; //initialization
			end

			alu_mult: begin
				regZH <= ~mult_op_out[63:32]; 
				regZL <= mult_op_out[31:0]; 
			end
	
			alu_div: begin
				regZH <= div_op_out[63:32]; 
				regZL <= div_op_out[31:0];  //sets the 32-bit output wire regZ to the 32-bit ([32*2-1:0]) sum of the DIVISION operation 
			end

			alu_neg: begin
				regZL <= neg_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the NEGATE operation 
				regZH <= 32'd0; //initialization
			end

			alu_not: begin
				regZL <= not_op_out[31:0]; //sets the 32-bit output wire regZ to the 32-bit sum of the NOT operation 
				regZH <= 32'd0; //initialization
			end
			
			default: begin // Default to prevent latching
				regZL <= 32'd0; 
				regZH <= 32'd0; 
			end 
		endcase
	end
	//instantiate the ALU module operations  
	add_op add_M0(.regA(regA), .regB(regB), .cin({1'd0}), .sum(add_op_sum), .cout(add_op_cout));
	sub_op sub_M0(.regA(regA), .regB(regB), .cin({1'd0}), .sum(sub_op_sum), .cout(sub_op_cout));
	shr_op shr_M0(regA, regB, shr_op_out);
	shl_op shl_M0(regA, regB, shl_op_out);
	ror_op ror_M0(regA, regB, ror_op_out);
	rol_op rol_M0(regA, regB, rol_op_out);
	and_op and_M0(regA, regB, and_op_out);
	or_op or_M0(regA, regB, or_op_out);
	mult_op mult_M0(regA, regB, mult_op_out);
	div_op div_M0(regA, regB, div_op_out);
	neg_op neg_M0(regB, neg_op_out); //shown in regB in simplified datapath given for lab
	not_op not_M0(regB, not_op_out); //shown in regB in simplified datapath given for lab
	IncPC_op IncPC_M0(regA, IncPC, IncPC_out);
	
endmodule
	
