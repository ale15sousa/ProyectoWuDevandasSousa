`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 02:07:07 PM
// Design Name: 
// Module Name: Microprocesador_tb
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


module Microprocesador_tb;
    //  Las unicas entradas son el CLK y el Reset
    reg CLK;
    reg Reset;
    
    //  El modulo bajo prueba es Microprocesador
    Microprocesador uut(
    .CLK(CLK),
    .Reset(Reset)
    );
    
    initial begin
    
        CLK=0;      //  Inicializamos CLK en bajo
        Reset=0;    //  Reset en bajo
        #10;
        Reset=1;    //  Realizamos un reset
        #10;
        Reset=0;    //  Despues del reset el sistema lee las instrucciones y las ejecuta
    
    end
    
    always #5 CLK = ~CLK;   //  Reloj del sistema
endmodule
