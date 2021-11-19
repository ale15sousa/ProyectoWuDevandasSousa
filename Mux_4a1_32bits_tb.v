`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2021 02:56:58
// Design Name: 
// Module Name: Mux_4a1_32bits_tb
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
//Esta prueba busca comprobar que el MUX implementado lleve el valor de entrada correspondiente a su salida, segun el valor de su selector.

module Mux_4a1_32bits_tb;
    //Entradas y Salidas
    reg  [1:0] Control;             //  Controla cual entrada se muestra a la salida
    reg [31:0] Entrada_0;     //  Entrada 0 de 32 bits
    reg [31:0] Entrada_1;    //  Entrada 1 de 32 bits
    reg [31:0] Entrada_10;     //  Entrada 10 de 32 bits
    reg [31:0] Entrada_11;    //  Entrada 11 de 32 bits
    wire [31:0] Salida;    //  Salida de 32 bits
    
    Mux_4a1_32bits uut(
    
    .Control(Control),
    .Entrada_0(Entrada_0),
    .Entrada_1(Entrada_1),
    .Entrada_10(Entrada_10),
    .Entrada_11(Entrada_11),
    .Salida(Salida)
    );

initial begin
    
    
    Entrada_0 = 32'hAAAAAAAA; //Inicializacion de entrada 0
    Entrada_1 = 32'hAAAABBBB; //Inicializacion de entrada 1
    Entrada_10 = 32'hBBBBCCCC; //Inicializacion de entrada 10
    Entrada_11 = 32'hCCCCDDDD; //Inicializacion de entrada 11
    #50 //espera
    Control = 2'b00; //Selector en valor 0, se espera que el valor AAAAAAAA se refleje en la salida.
    #50//espera
    Control = 2'b01;//Selector en valor 1, se espera que el valor AAAABBBB se refleje en la salida.
    #50//espera
    Control = 2'b10;//Selector en valor 10, se espera que el valor BBBBCCCC se refleje en la salida.
    #50//espera
    Control = 2'b11;//Selector en valor 11, se espera que el valor CCCCDDDD se refleje en la salida.
    #50//espera
    $finish; //fin de prueba
    
    end
 

endmodule
