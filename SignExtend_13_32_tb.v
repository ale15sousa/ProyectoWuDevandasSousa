`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:06:08 PM
// Design Name: 
// Module Name: SignExtend_13_32_tb
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
// Objetivo del testbench: comprobar el correcto funcionamiento del extensor de signo para diferentes
// valores de entrada

module SignExtend_13_32_tb;
    //  Entradas
    reg [12:0] Entrada;
    //  Salidas
    wire [31:0] Salida;
    //  El modulo objetivo de la prueba es SignExtend_13_32
    SignExtend_13_32 uut (
        .Entrada(Entrada),  //  Se define la entrada
        .Salida(Salida)     //  Se define la salida
    );
    
    initial                             //  Se ejecuta una unica vez
    begin                               //  Comienzo de la prueba
        Entrada=13'b0000000000000;      //  Se tiene como entrada todo cero
                                        //  Se espera a la salida 32'b00000000000000000000000000000000 o bien en hexadecimal: 000000000
        #5;
        Entrada=13'b1000000000001;      //  La entrada cambia a 1000000000001
                                        //  Se espera a la salida 32'b11111111111111111111000000000001 o bien en hexadecimal: FFFFF001
        #10;
        Entrada=13'b0111011100011;      //  La entrada cambia a 1011011100011
                                        //  Se espera a la salida 32'b00000000000000000000111011100011 o bien en hexadecimal: 00000EE3
        #20;
        Entrada=13'b1010101010101;      //  La entrada cambia a 1010101010101
                                        //  Se espera a la salida 32'b11111111111111111111010101010101 o bien en hexadecimal: FFFFF555
        #40;
        Entrada=13'b0111111000000;      //  La entrada cambia a 1111111000000
                                        //  Se espera a la salida 32'b00000000000000000000111111000000 o bien en hexadecimal: 00000FC0
        #100;
        Entrada=13'b1111111111111;      //  La entrada cambia a 111111111111
                                        //  Se espera a la salida 32'b11111111111111111111111111111111 o bien en hexadecimal: FFFFFFFF
                                        //  Se espera que este valor se mantenga asi hasta el final de la prueba, debido a que no se dan mas cambios
        $finish;
    end
endmodule