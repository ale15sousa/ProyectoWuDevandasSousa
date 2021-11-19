`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:02:29 AM
// Design Name: 
// Module Name: Mux_2a1_32bits
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
// El Mux 2 a 1 se utiliza con frecuencia en la implementacion de la arquitectura de RISCV implementada en la toma de decisiones para
// decidir el uso de uno u otro dato para guardar, cargar, concatenar o utilizar en una operacion de ALU, tiene dos entradas pero una unica salida
// podemos decidir cual de las entradas queremos que se refleje a la salida del Mux, tanto sus entradas como su salida son de 32 bits
//////////////////////////////////////////////////////////////////////////////////

module Mux_2a1_32bits(          //  Tiene como fin el poder elegir entre cualquiera de dos entradas de 32 bits a su salida
    input  Control,             //  Controla cual entrada se muestra a la salida
    input [31:0] Entrada_0,     //  Entrada 0 de 32 bits
    input [31:0] Entrada_1,     //  Entrada 1 de 32 bits
    output reg [31:0] Salida    //  Salida de 32 bits
    );
    
    always @(*)                             //  Siempre que se de un cambio en sus entradas o en el control se actualiza
		case(Control)                       //  Se revisa el valor del control
			1'b0: Salida <= Entrada_0;      //  Si el control esta en 0, se muestra a la salida la entrada 0
			1'b1: Salida <= Entrada_1;      //  Si el control esta en 1, se muestra a la salida la entrada 1
		endcase
endmodule
