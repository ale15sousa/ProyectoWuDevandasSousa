`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:06:08 PM
// Design Name: 
// Module Name: SignExtend_20_32_tb
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

module SignExtend_20_32_tb;
    //  Entradas
    reg [19:0] Entrada;
    //  Salidas
    wire [31:0] Salida;
    //  El modulo objetivo de la prueba es SignExtend_20_32
    SignExtend_20_32 uut (
        .Entrada(Entrada),  //  Se define la entrada
        .Salida(Salida)     //  Se define la salida
    );
    
    initial                                 //  Se ejecuta una unica vez
    begin                                   //  Comienzo de la prueba
        Entrada=20'b00000000000000000000;   //  Se tiene como entrada todo cero
                                            //  Se espera a la salida 32'b00000000000000000000000000000000 o bien en hexadecimal: 000000000
        #5;
        Entrada=20'b10000000000000000001;   //  La entrada cambia a 10000000000000000001
                                            //  Se espera a la salida 32'b11111111111110000000000000000001 o bien en hexadecimal: FFF80001
        #10;
        Entrada=20'b01110011100011110000;   //  La entrada cambia a 0111011100011110
                                            //  Se espera a la salida 32'b00000000000001110011100011110000 o bien en hexadecimal: 000738F0
        #20;
        Entrada=20'b10101010101010101010;   //  La entrada cambia a 1010101010101010
                                            //  Se espera a la salida 32'b11111111111110101010101010101010 o bien en hexadecimal: FFFAAAAA
        #40;
        Entrada=20'b11111111110000000000;   //  La entrada cambia a 11111111110000000000
                                            //  Se espera a la salida 32'b11111111111111111111110000000000 o bien en hexadecimal: FFFFFC00
        #100;
        Entrada=20'b0111111111111111111;    //  La entrada cambia a 0111111111111111
                                            //  Se espera a la salida 32'b00000000000000111111111111111111 o bien en hexadecimal: 0003FFFF
                                            //  Se espera que este valor se mantenga asi hasta el final de la prueba, debido a que no se dan mas cambios
        $finish;
    end
endmodule