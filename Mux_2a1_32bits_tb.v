`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2021 02:21:05
// Design Name: 
// Module Name: Mux_2a1_32bits_tb
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

module Mux_2a1_32bits_tb;
    //Entradas y Salidas
    reg  Control;             //  Controla cual entrada se muestra a la salida
    reg [31:0] Entrada_0;     //  Entrada 0 de 32 bits
    reg [31:0] Entrada_1;    //  Entrada 1 de 32 bits
    wire [31:0] Salida;    //  Salida de 32 bits
    
    Mux_2a1_32bits uut(
    
    .Control(Control),
    .Entrada_0(Entrada_0),
    .Entrada_1(Entrada_1),
    .Salida(Salida)
    );

initial begin
    
    
    Entrada_0 = 32'hFFFFFFFF; //Inicializacion de entrada 0
    Entrada_1 = 32'hABABABAB; //Inicializacion de entrada 1
    #50 //espera
    Control = 1; //Selector en valor 1, se espera que el valor de ABABABAB se refleje en la salida.
    #50//espera
    Control = 0;//Selector en valor 0, se espera que el valor de FFFFFFFF se refleje en la salida.
    #50//espera
    $finish; //fin de prueba
    
    end
 

endmodule
