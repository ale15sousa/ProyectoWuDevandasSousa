`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:06:08 PM
// Design Name: 
// Module Name: SignExtend_16_32_tb
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

module SignExtend_16_32_tb;
    //  Entradas
    reg [15:0] Entrada;
    reg Signo;
    //  Salidas
    wire [31:0] Salida;
    //  El modulo objetivo de la prueba es SignExtend_16_32
    SignExtend_16_32 uut (
        .Entrada(Entrada),  //  Se define la entrada
        .Salida(Salida),    //  Se define la salida
        .Signo(Signo)       //  Se define el control de si es una extension con o sin signo
    );
    
    initial                             //  Se ejecuta una unica vez
    begin                               //  Comienzo de la prueba
        Signo=0;                        //  Se comprueban casos sin signo
        Entrada=16'b0000000000000000;   //  Se tiene como entrada todo cero
                                        //  Se espera a la salida 32'b00000000000000000000000000000000 o bien en hexadecimal: 000000000
        #5;
        Entrada=16'b1000000000000001;   //  La entrada cambia a 1000000000000001
                                        //  Se espera a la salida 32'b00000000000000001000000000000001 o bien en hexadecimal: 00008001
        #10;
        Entrada=16'b1011011100011110;   //  La entrada cambia a 1011011100011110
                                        //  Se espera a la salida 32'b00000000000000001011011100011110 o bien en hexadecimal: 0000B71E
        #20;
        Entrada=16'b1010101010101010;   //  La entrada cambia a 1010101010101010
                                        //  Se espera a la salida 32'b00000000000000001010101010101010 o bien en hexadecimal: 0000AAAA
        #40;
        Entrada=16'b1111111100000000;   //  La entrada cambia a 1111111100000000
                                        //  Se espera a la salida 32'b00000000000000001111111100000000 o bien en hexadecimal: 0000FF00
        #100;
        Entrada=16'b1111111111111111;   //  La entrada cambia a 1111111111111111
                                        //  Se espera a la salida 32'b00000000000000001111111111111111 o bien en hexadecimal: 0000FFFF
        #10;
        Signo=1;                        //  Se comprueban casos con signo
        Entrada=16'b0000000000000000;   //  Se tiene como entrada todo cero
                                        //  Se espera a la salida 32'b00000000000000000000000000000000 o bien en hexadecimal: 00000000
        #5;
        Entrada=16'b1000000000000001;   //  La entrada cambia a 1000000000000001
                                        //  Se espera a la salida 32'b11111111111111111000000000000001 o bien en hexadecimal: FFFF8001
        #10;
        Entrada=16'b1011011100011110;   //  La entrada cambia a 1011011100011110
                                        //  Se espera a la salida 32'b11111111111111111011011100011110 o bien en hexadecimal: FFFFB71E
        #20;
        Entrada=16'b1010101010101010;   //  La entrada cambia a 1010101010101010
                                        //  Se espera a la salida 32'b11111111111111111010101010101010 o bien en hexadecimal: FFFFAAAA
        #40;
        Entrada=16'b1111111100000000;   //  La entrada cambia a 1111111100000000
                                        //  Se espera a la salida 32'b11111111111111111111111100000000 o bien en hexadecimal: FFFFFF00
        #100;
        Entrada=16'b1111111111111111;   //  La entrada cambia a 1111111111111111
                                        //  Se espera a la salida 32'b11111111111111111111111111111111 o bien en hexadecimal: FFFFFFFF
                                        //  Se espera que este valor se mantenga asi hasta el final de la prueba, debido a que no se dan mas cambios
        $finish;
    end
endmodule