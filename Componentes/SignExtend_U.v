`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 03:18:27 AM
// Design Name: 
// Module Name: SignExtend_U
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


module SignExtend_U(
    input [19:0] Entrada,       //  Entrada de 20 bits
    output reg [31:0] Salida    //  Salida de 32 bits
    );
    
    reg [19:0] temporal;
    
    always @(*) begin           //  Cada vez que se de un cambio en las entradas se da una actualizacion
        temporal=Entrada<<12;   //  Se hace un shift logico
        if (temporal[19]==1) begin                  //  Como es un extensor con signo, debemos ver si es un numero negativo
            Salida[31:20] <= 12'b111111111111;      //  Si es negativo, extendemos con 1
            Salida[19:0] <= temporal[19:0];         //  La salida consiste de la extension de signo a 32 bits de la entrada de 20 bits
        end
        else begin                                  //  Caso donde el numero es positivo
            Salida[31:20] <= 12'b00000000000;       //  Si es positivo, extendemos con 0
            Salida[19:0] <= temporal[19:0];         //  La salida consiste de la extension de signo a 32 bits de la entrada de 20 bits
        end
    end
endmodule
