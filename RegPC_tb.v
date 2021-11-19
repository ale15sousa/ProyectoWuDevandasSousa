`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 03:06:26 AM
// Design Name: 
// Module Name: RegPC_tb
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
//  El objetivo de la prueba para RegPC es ver si por cada ciclo de reloj pasa de instruccion

module RegPC_tb;
    //  Salida
    wire [31:0] Q;
    //  Entrada
    reg [31:0] D;
    reg CLK;
    
    //  La prueba se realizo para el modulo de RegPC
    RegPC uut (
        .Q(Q),
        .D(D),
        .CLK(CLK)
    );
    
    initial begin
        CLK=0;
        D=32'hA;    //  Nueva instruccion
        #10;
        D=32'hB;    //  Nueva instruccion
        #10;
        D=32'hC;    //  Nueva instruccion
        #10;
        D=32'hD;    //  Nueva instruccion
        #10;
        D=32'hE;    //  Nueva instruccion
        #10;
        D=32'hF;    //  Nueva instruccion
        #10;
        D=32'hA;    //  Nueva instruccion
        #10;
        D=32'hB;    //  Nueva instruccion     
    end
    always #5 CLK=~CLK;

endmodule
