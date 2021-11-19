`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 03:41:48 AM
// Design Name: 
// Module Name: SignExtend_U_tb
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
//  Para las operaciones tipo U se requiere para la operacion LUI y AUIPC se necesita tomar un inmediato, hacer un corrimiento logico hacia la izquierda
//  de 12 bits y despues extender su signo a 32 bits

module SignExtend_U_tb;
    //  Entrada
    reg [19:0] Entrada;
    //  Salida
    wire [31:0] Salida;
    //  Se realiza la prueba para SignExtend_U
    SignExtend_U uut (      //  Establecimiento de parametros
        .Entrada(Entrada),
        .Salida(Salida)
    );
    
    initial begin
        Entrada=20'b01111100111001110011;   //  La salida esperada ante esta entrada es 00000000000001110011000000000000
        #20;
        Entrada=20'b11111001110011100110;   //  La salida esperada ante esta entrada es 11111111111111100110000000000000
    end

endmodule
