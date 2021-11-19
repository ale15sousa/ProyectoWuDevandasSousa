`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:21:19 AM
// Design Name: 
// Module Name: SignExtend_8_32
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
// Los extensores de signo funcionan para incrementar el numero de bits de un numero manteniendo el valor del numero original
// En este caso se hace una extension de signo a 32 bits para un valor de 16 bits
// Este extensor toma el valor de 8 bits a partir de do0 que es data-out de la Memoria de Datos y los extiende a 32 bits
//////////////////////////////////////////////////////////////////////////////////

module SignExtend_8_32(         //  Toma un numero binario de 8 bits y lo pone en formato de 32 bits insertando ceros a la izquierda
    input [7:0] Entrada,        //  Entrada de 8 bits
    input Signo,                //  Entrada que selecciona si la extension es con o si signo
    output reg [31:0] Salida    //  Salida de 32 bits
    );
    
    always @(*) begin
        if (Signo==1) begin
            if (Entrada[7]==1) begin                            //  Como es un extensor con signo, debemos ver si es un numero negativo
                Salida[31:8] <= 24'b111111111111111111111111;   //  Si es negativo, extendemos con 1
                Salida[7:0] <= Entrada[7:0];                    //  La salida consiste de la extension de signo a 32 bits de la entrada de 16 bits
            end
            else begin                                          //  Caso donde el numero es positivo
                Salida[31:8] <= 24'b000000000000000000000000;   //  Si es positivo, extendemos con 0
                Salida[7:0] <= Entrada[7:0];                    //  La salida consiste de la extension de signo a 32 bits de la entrada de 16 bits
            end
        end
        else begin
            Salida[31:6] <= 24'b000000000000000000000000;           //  Caso sin signo siempre extendemos con 0
            Salida[7:0] <= Entrada[7:0];                            //  La salida consiste de la extension de signo a 32 bits de la entrada de 16 bits
        end
    end
endmodule
