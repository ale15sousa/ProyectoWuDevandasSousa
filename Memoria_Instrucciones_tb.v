`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 01:59:11 PM
// Design Name: 
// Module Name: Memoria_Instrucciones_tb
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
//  El fin de esta prueba es verificar el correcto funcionamiento de la memoria de instrucciones

module Memoria_Instrucciones_tb;
    
    //  Entradas
    reg [31:0] ADDR;
    
    //  Salidas
    wire [31:0] INST;
    
    //  El modulo bajo prueba es Memoria_Instrucciones
    Memoria_Instrucciones uut (
        .ADDR(ADDR),
        .INST(INST)
    );
    
    //  Comienzo de las pruebas
    initial begin
    ADDR=32'd0; //  Pasamos de instrucciones cada cierto tiempo para ver si en efecto pasa de instruccion al cambiar el addres
    #30;
    ADDR=32'd8; //  Address 8    Pasa a la siguiente instruccion
    #30;
    ADDR=32'd16;//  Address 16   Pasa a la siguiente instruccion
    #30;
    ADDR=32'd24;//  Address 24   Pasa a la siguiente instruccion
    #30;
    ADDR=32'd32;//  Address 32   Pasa a la siguiente instruccion
    #30;
    end
    
endmodule
