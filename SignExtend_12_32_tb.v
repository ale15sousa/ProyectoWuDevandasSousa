`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:06:08 PM
// Design Name: 
// Module Name: SignExtend_12_32_tb
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

module SignExtend_12_32_tb;
    //  Entradas
    reg [11:0] Entrada;
    //  Salidas
    wire [31:0] Salida;
    //  El modulo objetivo de la prueba es SignExtend_12_32
    SignExtend_12_32 uut (
        .Entrada(Entrada),  //  Se define la entrada
        .Salida(Salida)     //  Se define la salida
    );
    
    initial                             //  Se ejecuta una unica vez
    begin                               //  Comienzo de la prueba
        Entrada=12'b000000000000;       //  Se tiene como entrada todo cero
                                        //  Se espera a la salida 32'b00000000000000000000000000000000 o bien en hexadecimal: 000000000
        #5;
        Entrada=12'b100000000001;       //  La entrada cambia a 100000000001
                                        //  Se espera a la salida 32'b11111111111111111111100000000001 o bien en hexadecimal: FFFFF801
        #10;
        Entrada=12'b011101110001;       //  La entrada cambia a 101101110001
                                        //  Se espera a la salida 32'b00000000000000000000011101110001 o bien en hexadecimal: 00000771
        #20;
        Entrada=12'b101010101010;       //  La entrada cambia a 101010101010
                                        //  Se espera a la salida 32'b11111111111111111111101010101010 o bien en hexadecimal: FFFFFAAA
        #40;
        Entrada=12'b011111000000;       //  La entrada cambia a 1111110000001
                                        //  Se espera a la salida 32'b00000000000000000000011111000000 o bien en hexadecimal: 000007C0
        #100;
        Entrada=12'b111111111111;       //  La entrada cambia a 111111111111
                                        //  Se espera a la salida 32'b11111111111111111111111111111111 o bien en hexadecimal: FFFFFFFF
                                        //  Se espera que este valor se mantenga asi hasta el final de la prueba, debido a que no se dan mas cambios
        $finish;
    end
endmodule