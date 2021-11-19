`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 04:16:56 PM
// Design Name: 
// Module Name: SignExtend_20_32
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
// En este caso se hace una extension de signo a 32 bits para un valor de 20 bits
// Este extemsor de signo extiende los 20 bits generados por Concatenador_J_PC_ALU y su salida es de 32 bits que va a un Mux que decide que se hace
// con el PC actual
//////////////////////////////////////////////////////////////////////////////////

module SignExtend_20_32(        //  Toma un numero binario de 20 bits y lo pone en formato de 32 bits insertando ceros a la izquierda
    input [19:0] Entrada,       //  Entrada de 20 bits
    output reg [31:0] Salida    //  Salida de 32 bits
    );
    
    always @(*) begin                               //  Cada vez que se de un cambio en las entradas se da una actualizacion
        if (Entrada[19]==1) begin                   //  Como es un extensor con signo, debemos ver si es un numero negativo
            Salida[31:20] <= 12'b111111111111;      //  Si es negativo, extendemos con 1
            Salida[19:0] <= Entrada[19:0];          //  La salida consiste de la extension de signo a 32 bits de la entrada de 20 bits
        end
        else begin                                  //  Caso donde el numero es positivo
            Salida[31:20] <= 12'b00000000000;       //  Si es positivo, extendemos con 0
            Salida[19:0] <= Entrada[19:0];          //  La salida consiste de la extension de signo a 32 bits de la entrada de 20 bits
        end
    end
endmodule
