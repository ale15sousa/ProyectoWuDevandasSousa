`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 11:33:41 PM
// Design Name: 
// Module Name: Banco_Registros_tb
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
//  Objetivo de la prueba: comprobar que se puede hacer reset a los registros para su inicializacion, si se puede realizar un reset
//  Comprobar si se puede leer y escribir a registros
//  Comprobar si el valor del registro 0 es inmodificable, siempre se mantiene en 0

module Banco_Registros_tb;
    //  Entradas
    reg CLK;
    reg [4:0] rs2;
    reg [4:0] rs1;
    reg [4:0] rd;
    reg [31:0] di;
    reg wre;
    reg Reset;
    //  Salidas
    wire [31:0] do2;
    wire [31:0] do1;
    //  Unidad bajo prueba es el modulo Banco_Registros
    Banco_Registros uut (   //  Establecimiento de parametros
        .CLK(CLK),
        .rs2(rs2),
        .rs1(rs1),
        .rd(rd),
        .di(di),
        .wre(wre),
        .Reset(Reset),
        .do2(do2),
        .do1(do1)
    );
    
    initial                     //  Se ejecuta una unica vez
    begin                       //  Comienzo de la prueba
        CLK=0;                  //  Se establece el valor inicial del reloj
        Reset=0;                //  Reset en 0
        wre=0;                  //  No escribimos en registro
        #10;
        Reset=1;                //  Realizamos el reset
        #10;        
        Reset=0;                //  Terminamos el reset
        rs1=5'b00001;           //  Pedimos el valor del registro 1
        rs2=5'b00011;           //  Pedimos el valor del registro 3
        #10;
        rd=5'b00001;            //  Establecemos el registro de destino como el 1
        di=32'b10101010101010101010101010101010;    //  Dato a escribir
                                                    //  Aca no se espera que se escriba el dato porque el enable esta desactivado
        #10;    
        rd=5'b00001;                                //  Seguimos con el primer registro como registro de destino
        di=32'b11101010101010101010101010101010;    //  Cambiamos el dato de entreda, se cambio el segundo bit
        wre=1;                                      //  Ahora habilitamos la escritura, de manera que se espera que si se modifique el valor del registro 1
        #10;
        wre=0;                                      //  No escribimos en registro
        #10;
        rd=5'b00000;                                //  Seguimos con el primer registro como registro de destino
        di=32'b11111111111111111111111111111111;    //  Cambiamos el dato de entreda, se cambio el segundo bit
        wre=1;                                      //  Enable activado
                                                    //  Se espera que no se escriba en el registro 0, debido a que siempre tiene un valor de 0
        rs2=5'b00000;                               //  Dato de salida rs2 del registro 0
        #30; 
        rs1=5'b00001;                               //  Pedimos la misma informacion del mismo registro en ambas entradas rs1 y rs2
        rs2=5'b00001;                               //  Se espera tener los mismos datos sin problemas a ambas salidas
        #20;
        rs1=5'b00000;                               //  Se comprueba que efectivamente no se haya escrito en el registro 0
        wre=0;                                      //  No se escribe mas a registro
                                                    //  Se espera que no se haya escrito en registro 0, tiene valor de 0
        #10;
        Reset=1;                                    //  Se realiza un reset, se espera que despues de que baje el reset, todos los
        #10;                                        //  registros tengan un valor de 0
        Reset=0;
        $finish;                                    
    end
    always #5 CLK=~CLK;                             //  Clock baja o sube flanco cada 5 ns
    
endmodule
