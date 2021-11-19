`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:06:08 PM
// Design Name: 
// Module Name: SignExtend_8_32_tb
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

module SignExtend_8_32_tb;
    //  Entradas
    reg [7:0] Entrada;
    reg Signo;
    //  Salidas
    wire [31:0] Salida;
    //  El modulo objetivo de la prueba es SignExtend_8_32
    SignExtend_8_32 uut (
        .Entrada(Entrada),  //  Se define la entrada
        .Salida(Salida),    //  Se define la salida
        .Signo(Signo)       //  Control de si se da la respuesta con o sin signo
    );
    
    initial                     //  Se ejecuta una unica vez
    begin                       //  Comienzo de la prueba
        Signo=1;                //  Pruebas con signo
        Entrada=8'b00000000;    //  Se tiene como entrada todo cero
                                //  Se espera a la salida 32'b00000000000000000000000000000000 o bien en hexadecimal: 00000000
        #5;
        Entrada=8'b00011000;    //  La entrada cambia a 00011000
                                //  Se espera a la salida 32'b00000000000000000000000000011000 o bien en hexadecimal: 00000018
        #10;
        Entrada=8'b10000001;    //  La entrada cambia a 10000001
                                //  Se espera a la salida 32'b11111111111111111111111110000001 o bien en hexadecimal: FFFFFF81
        #20;
        Entrada=8'b11000001;    //  La entrada cambia a 11000001
                                //  Se espera a la salida 32'b11111111111111111111111111000001 o bien en hexadecimal: FFFFFFC1
        #40;
        Entrada=8'b01011001;    //  La entrada cambia a 11011001
                                //  Se espera a la salida 32'b00000000000000000000000001011001 o bien en hexadecimal: 0000059 
        #100;
        Entrada=8'b11111111;    //  La entrada cambia a 11111111
                                //  Se espera a la salida 32'b11111111111111111111111111111111 o bien en hexadecimal: FFFFFFFF
                                //  Se espera que este valor se mantenga asi hasta el final de la prueba, debido a que no se dan mas cambios
        #10;
        Signo=0;                //  Pruebas sin signo
        Entrada=8'b00000000;    //  Se tiene como entrada todo cero
                                //  Se espera a la salida 32'b00000000000000000000000000000000 o bien en hexadecimal: 00000000
        #5;
        Entrada=8'b00011000;    //  La entrada cambia a 00011000
                                //  Se espera a la salida 32'b00000000000000000000000000011000 o bien en hexadecimal: 00000018
        #10;
        Entrada=8'b10000001;    //  La entrada cambia a 10000001
                                //  Se espera a la salida 32'b00000000000000000000000010000001 o bien en hexadecimal: 00000081
        #20;
        Entrada=8'b11000001;    //  La entrada cambia a 11000001
                                //  Se espera a la salida 32'b00000000000000000000000011000001 o bien en hexadecimal: 000000C1
        #40;
        Entrada=8'b01011001;    //  La entrada cambia a 11011001
                                //  Se espera a la salida 32'b00000000000000000000000001011001 o bien en hexadecimal: 00000059
        #100;
        Entrada=8'b11111111;    //  La entrada cambia a 11111111
                                //  Se espera a la salida 32'b00000000000000000000000011111111 o bien en hexadecimal: 000000FF
                                //  Se espera que este valor se mantenga asi hasta el final de la prueba, debido a que no se dan mas cambios
        $finish;
    end
endmodule
