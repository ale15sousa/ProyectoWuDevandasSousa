`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:47:47 AM
// Design Name: 
// Module Name: PC_ALU
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
// DOCUMENTACION
//////////////////////////////////////////////////////////////////////////////////
//  La PC_ALU se encarga del manejo de las operaciones de PC, por ejemplo, si para la siguiente instruccion se le suman 4 o bien
//  tenemos presencia de un Branch

module PC_ALU(
	input [31:0] A,    //  Primer operando
	input [31:0] B,    //  Segundo operando
	output reg [31:0] ALU_out  //  Salida de ALU
    );
        
    always @(*) begin   //  Ante cualquier cambio en su entrada altera su salida
    
        ALU_out=A+B;    //  Esta ALU esta hard-codeada a suma

		end
endmodule
