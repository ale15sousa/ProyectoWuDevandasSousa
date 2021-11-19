`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 09:41:02 AM
// Design Name: 
// Module Name: Main_ALU_tb
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


module Main_ALU_tb;

    //  Entradas
    reg [4:0] Control;
	reg [31:0] A;
	reg [31:0] B;
	
	// Salidas
	wire [31:0] ALU_out;
	wire Flag;
	
	// Modulo de prueba es Main_ALU
	Main_ALU uut (
	   .Control(Control),
	   .A(A),
	   .B(B),
	   .ALU_out(ALU_out),
	   .Flag(Flag)
	);
	
	initial begin
	   //  Prueba de add positivos
	   #20;
	   Control=5'b00000;
	   A=32'd10;                               //  10+15=25
	   B=32'd15;                               //  Se espera un resultado de 25 en decimal, hexa de 00000019
	   //  Prueba de add con dos signos opuestos, resultado positivo
	   #20;
	   A=32'b11111111111111111111111111110011; //-13 en decimal
	   B=32'd25;                               //  25 en decimal
	                                           //  Se espera que el resultado sea 12 en decimal, en hexa 0000000c
	   //  Prueba de add con dos signos opuestos, resultado negativo
	   #20;
	   A=32'b11111111111111111111111111110011; //-13 en decimal
	   B=32'd10;                               //  10 en decimal
	                                           //  Se espera que el resultado sea -3 en decimal, en hexa ffffffd
	   //  Prueba de add con dos negativos, resultado negativo
	   #20;
	   A=32'b11111111111111111111111111110011; //-13 en decimal
	   B=32'b11111111111111111111111111110101; //  -11 en decimal
	                                           //  Se espera que el resultado sea -24 en decimal, en hexa ffffffe8
	   //  Prueba de sub positivos
	   #20;
	   Control=5'b00001;
	   A=32'd15;                               //  15-10=5
	   B=32'd10;                               //  Se espera un resultado de 5 en decimal, hexa de 00000005
	   //  Prueba de sub con dos signos opuestos, resultado positivo
	   #20;
	   A=32'd25;                               //  25 en decimal
	   B=32'b11111111111111111111111111110011; //  -13 en decimal
	                                           //  Se espera que el resultado sea 38 en decimal, en hexa 00000026
	   //  Prueba de sub con dos signos opuestos, resultado negativo
	   #20;
	   A=32'b11111111111111111111111111110011; //  -13 en decimal
	   B=32'd2;                                //  2 en decimal
	                                           //  Se espera que el resultado sea -15 en decimal, en hexa fffffff1
	   //  Prueba de sub con dos negativos, resultado negativo
	   #20;
	   A=32'b11111111111111111111111111110011; //  -13 en decimal
	   B=32'b11111111111111111111111111110101; //  -11 en decimal
	                                           //  Se espera que el resultado sea -2 en decimal, en hexa fffffffe
	   //  Prueba de shift logical left positivo
	   #20;
	   Control=5'b00010;
	   A=32'b10110011100011110000111110000011;
	   B=32'b00000000000000000000000000000100; //  Se hace un shift de 4 se espera como resultado
	                                           //  00111000111100001111100000110000
	   //  Prueba de set less than, caso dos positivos
	   #20;
	   Control=5'b00011;
	   A=32'b00000000000000000000000000000100;
	   B=32'b00110011100011110000111110000011; //  Se espera que el Flag este en alto
	   //  Prueba de set less than, caso signos opuestos, si cumple
	   #20;
	   A=32'b11111111111111111111111111110011; //  -13 en decimal
	   B=32'b00000000000000000000000000000100; //  Se espera que el Flag este en alto
	   //  Prueba de set less than, caso signos opuestos, no cumple
	   #20;
	   A=32'b00000000000000000000000000000100; //  Se espera que el Flag este en bajo
	   B=32'b11111111111111111111111111110011; //  -13 en decimal
	   //  Prueba de set less than, caso dos negativos
	   #20;
	   A=32'b11111111111111111111111111110011; //  -13 en decimal
	   B=32'b11111111111111111111111111110101; //  -11 en decimal  Se espera Flag en alto
	   //  Prueba de set less than unsigned, cumple
	   Control=5'b00100;
	   #20;
	   A=32'b00000000000000000000000000000100; //  Se espera que el Flag este en alto
	   B=32'b11111111111111111111111111110011; 
	   //  Prueba de set less than unsigned, no cumple
	   #20;
	   A=32'b11111111111111111111111111110011; 
	   B=32'b00000000000000000000000000000100; //  Se espera que el Flag este en bajo
	   //  Prueba de xor
	   #20;
	   Control=5'b00101;
	   A=32'b10101010101010101010101010101010;
	   B=32'b11111111111111110000000000000000;
	                                           //  Resultado esperado: 01010101010101011010101010101010
	   //  Prueba de shift logical right positivo
	   #20;
	   Control=5'b00110;
	   A=32'b10110011100011110000111110000011;
	   B=32'b00000000000000000000000000000100; //  Se hace un shift de 4 se espera como resultado
	                                           //  00001011001110001111000011111000
	   //  Prueba de shift right arithmetic, caso positivo
	   #20;
	   Control=5'b00111;
	   A=32'b10110011100011110000111110000011;
	   B=32'b00000000000000000000000000000100; //  Se hace un shift de 4 se espera como resultado
	                                           //  11111011001110001111000011111000
	   //  Prueba de bitwise or
	   #20;
	   Control=5'b01000;
	   A=32'b10101010101010101010101010101010;
	   B=32'b11111111111111110000000000000000;
	                                           //  Resultado esperado: 11111111111111111010101010101010
	   //  Prueba de bitwise and
	   #20;
	   Control=5'b01001;
	   A=32'b10101010101010101010101010101010;
	   B=32'b11111111111111110000000000000000;
	                                           //  Resultado esperado: 10101010101010100000000000000000
	   //  Prueba de pass B
	   #20;
	   Control=5'b01010;
	   A=32'b10101010101010101010101010101010;
	   B=32'b11111111111111110000000000000000; // Resultado esperado: 11111111111111110000000000000000
	   //  Prueba de equal
	   #20;
	   Control=5'b01011;
	   A=32'b10101010101010101010101010101010;
	   B=32'b10101010101010101010101010101010; //  Salida en 1 si es igual
	   #20;
	   A=32'b10101010101010101010101010101010;
	   B=32'b11111010101010101010101010101010; //  Salida en 0 no es igual
	   //  Prueba de not equal
	   #20;
	   Control=5'b01100;
	   A=32'b10101010101010101010101010101010;
	   B=32'b10101010101010101010101010101010; //  Salida en 0 si es igual
	   #20;
	   A=32'b10101010101010101010101010101010;
	   B=32'b11111010101010101010101010101010; //  Salida en 1 no es igual
	   //  Prueba de less than
	   #20;
	   Control=5'b01101;
	   A=32'b11111111111111111111111111110011;
	   B=32'b00000000000000000000000000000000; //  Salida en 1, si es menor
	   #20;
	   A=32'b00000001000000000000000000000000;
	   B=32'b01100000000000000000000000000000; //  Salida en 1, si es menor
	   //  Prueba de greater than
	   #20;
	   Control=5'b001110;
	   A=32'b00000000000000000000010000000000;
	   B=32'b11111111111111111111011111110111; //  Salida en 1, si es mayor
	   #20;
	   A=32'b00000000000100000000000000000000;
	   B=32'b00000000000000000000000000100000; //  Salida en 1, si es mayor
	   //  Prueba de less than unsigned, dos positivos, cumple
	   #20;
	   Control=5'b01111;
	   A=32'b11111111111111111111111111110011;
	   B=32'b00000000000000000000000000000000; //  Salida en 0, no es menor
	   #20;
	   A=32'b00000001000000000000000000000000;
	   B=32'b01100000000000000000000000000000; //  Salida en 1, si es menor
	   //  Prueba de greater than unsigned, dos positivos, cumple
	   #20;
	   Control=5'b10000;
	   A=32'b00000000000000000000010000000000;
	   B=32'b11111111111111111111011111110111; //  Salida en 0, no es mayor
	   #20;
	   A=32'b00000000000100000000000000000000;
	   B=32'b00000000000000000000000000100000; //  Salida en 1, si es mayor
	end
    
endmodule
