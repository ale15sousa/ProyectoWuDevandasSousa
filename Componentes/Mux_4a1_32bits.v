`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:34:39 AM
// Design Name: 
// Module Name: Mux_4a1_32bits
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
// Puede elegir entre lo que se quiere a la salida del bloque Memoria de Datos, permite escoger entre 4 entradas de 32 bits cada una
// pero puede tener solo una salida de 32 bits, a traves de su señal de control seleccionamos cual entrada se ve reflejada a la salida
//////////////////////////////////////////////////////////////////////////////////

module Mux_4a1_32bits(          //  Tiene como fin el poder elegir entre cualquiera de cuatro entradas de 32 bits a su salida
    input [1:0] Control,        //  Controla cual entrada se muestra a la salida
    input [31:0] Entrada_0,     //  Entrada 00 de 32 bits
    input [31:0] Entrada_1,     //  Entrada 01 de 32 bits
    input [31:0] Entrada_10,    //  Entrada 10 de 32 bits
    input [31:0] Entrada_11,    //  Entrada 11 de 32 bits
    output reg [31:0] Salida    //  Salida de 32 bits
    );
    
    always @(*)                             //  Siempre que se de un cambio en sus entradas o en el control se actualiza
		case(Control)                       //  Se revisa el valor del control
			2'b00: Salida <= Entrada_0;     //  Si el control esta en 00, se muestra a la salida la entrada 0
			2'b01: Salida <= Entrada_1;     //  Si el control esta en 01, se muestra a la salida la entrada 1
			2'b10: Salida <= Entrada_10;    //  Si el control esta en 10, se muestra a la salida la entrada 10
			2'b11: Salida <= Entrada_11;    //  Si el control esta en 11, se muestra a la salida la entrada 11
		endcase
endmodule
