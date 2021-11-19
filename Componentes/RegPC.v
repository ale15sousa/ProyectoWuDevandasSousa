`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:41:44 AM
// Design Name: 
// Module Name: RegPC
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
// Este modulo es esencial para el manejo de las instrucciones que se van a ejecutar, se encarga de cargar la siguiente instruccion una vez se termina
// el ciclo actual de reloj.
//////////////////////////////////////////////////////////////////////////////////

module RegPC(              //  Registro PC, se encarga de cargar la siguiente instruccion por cada ciclo de reloj
    output reg [31:0] Q,   //  Salida es la instruccion que se ejecuta en ese ciclo de reloj especifico
    input [31:0] D,        //  La entrada es la siguiente instruccion
    input CLK              //  Reloj
    );
always @(posedge CLK)      //  Se da el cambio a la siguiente instruccion en el flanco positivo del reloj
begin
	Q <= D;                //  Asigna el valor en su entrada, a la salida del RegPC
end
endmodule
