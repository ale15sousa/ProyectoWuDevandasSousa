`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:19:41 AM
// Design Name: 
// Module Name: Mux_2a1_5bits
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
// Se utiliza para escoger el conjunto de bits se que concatenaran por el ConcatenadorImm y luego seran extendidos a 32 bits, esto debido a que
// algunas instrucciones quieren realizar un concatenado y extension de signo pero los bits de interes no se encuentran en la misma posicion
// un ejemplo de esto se puede ver en las instrucciones de tipo I y S, el Mux nos permite seleccionar segun la instruccion que se este ejecutando a
// traves de su Control
//////////////////////////////////////////////////////////////////////////////////

module Mux_2a1_5bits(           //  Tiene como fin el poder elegir entre cualquiera de dos entradas de 5 bits a su salida
    input  Control,             //  Controla cual entrada se muestra a la salida
    input [4:0] Entrada_0,      //  Entrada 0 de 5 bits
    input [4:0] Entrada_1,      //  Entrada 1 de 5 bits
    output reg [4:0] Salida     //  Salida de 5 bits
    );
    
    always @(*)                           //    Siempre que se de un cambio en sus entradas o en el control se actualiza
		case(Control)                     //    Se revisa el valor del control
			1'b0: Salida <= Entrada_0;    //    Si el control esta en 0, se muestra a la salida la entrada 0
			1'b1: Salida <= Entrada_1;    //    Si el control esta en 1, se muestra a la salida la entrada 1
		endcase
endmodule
