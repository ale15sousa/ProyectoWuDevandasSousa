`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 02:20:47 AM
// Design Name: 
// Module Name: PC_ALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//  Esta prueba tiene como objetivo el comprobar la funcionalidad de PC_ALU, suma ambas entradas, A y B de 32 bits, el resultado
//  tambien es de 32 bits

module PC_ALU_tb;
    // Entradas
    reg [31:0] A;
	reg [31:0] B;
	// Salida
	wire [31:0] ALU_out;
	
	// Modulo d eprueba es PC_ALU
	PC_ALU uut (
	   .A(A),
	   .B(B),
	   .ALU_out(ALU_out)
	);
	
	initial begin      //  Se proporcionan diferentes valores de las entradas para corroborrar el correcto funcionamiento, esta hardcoded a suma
	   A=32'd100;
	   B=32'd100;      //  Se espera un valor en decimal de 200
	   #10;
	   A=32'd0;
	   B=32'd100;      //  Se espera un valor en decimal de 100
	   #10;
	   A=32'd250;
	   B=32'd25;       //  Se espera un valor en decimal de 275
	   #10;
	   A=32'd1;
	   B=32'd20;       //  Se espera un valor en decimal de 21
	   #10;
	   A=32'd50;
	   B=32'd50;       //  Se espera un valor en decimal de 100
	   #10;
	   A=32'd0;
	   B=32'd0;        //  Se espera un valor en decimal de 0
	   #10;
	   A=32'd1;
	   B=32'd1;        //  Se espera un valor en decimal de 2
	   #10;
	end
endmodule
