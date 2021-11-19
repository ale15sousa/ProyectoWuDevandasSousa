`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:00:06 AM
// Design Name: 
// Module Name: SignExtend_12_32
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
// En este caso se hace una extension de signo a 32 bits para un valor de 12 bits
// Se extiende el resultado de la concatenacion realizada por ConcatenacionImm
//////////////////////////////////////////////////////////////////////////////////

module SignExtend_12_32(        //  Toma un numero en binario de 12 bits y lo pasa a formato de 32 bits insertando ceros a la izquierda
    input [11:0] Entrada,       //  Entrada de 12 bits
    output reg [31:0] Salida    //  Salida de 32 bits
    );
    
    always @(*) begin                               //  Cada vez que se de un cambio en alguna entrada se actualiza
        if (Entrada[11]==1) begin                       //  Como es un extensor con signo, debemos ver si es un numero negativo
            Salida[31:12] <= 20'b11111111111111111111;   //  Si es negativo, extendemos con 1
            Salida[11:0] <= Entrada[11:0];              //  La salida consiste de la extension de signo a 32 bits de la entrada de 13 bits
        end
        else begin                                      //  Caso donde el numero es positivo
            Salida[31:12] <= 20'b00000000000000000000;   //  Si es positivo, extendemos con 0
            Salida[11:0] <= Entrada[11:0];              //  La salida consiste de la extension de signo a 32 bits de la entrada de 13 bits
        end
    end
endmodule
