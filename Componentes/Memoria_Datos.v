`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 10:10:28 AM
// Design Name: 
// Module Name: Memoria_Datos
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
//////////////////////////////////////////////////////////////////////////////////

module Memoria_Datos(
    input [31:0] address,   //  Address de entrada, direccion de memoria consiste de 32 bits
	input [31:0] datain,	//  Es el dato de escritura de interes, es de 32 bits
    input CLK,              //  Entrada de reloj
    input Reset,
	input [3:0] wme,        //  Consiste de 4 bits que nos indican cuales bytes queremos escribir
	output reg [7:0] do0,   //  8 bits menos significativos del dato de salida [7:0]
	output reg [7:0] do1,   //  bits [15:8] de la salida
	output reg [7:0] do2,   //  bits [23:16] de la salida
	output reg [7:0] do3    //  8 bits mas significativos del dato de salida [31:24]
	);
	
	reg [7:0] Memoria [0:255];  // 256 words of 8-bit memory
	integer i;              //  Contador para inicializacion de la memoria

//    reg [31:0] address0;    //  Address de entrada
//	reg [31:0] address1;    //  Siguiente espacio de memoria al address
//	reg [31:0] address2;    //  Dos espacios despues del espacio de entrada
//	reg [31:0] address3;    //  Tres espacios de memoria despues de la entrada
//	                        //  Esto representa las 4 direcciones de la palabra de 4 bytes
//    initial begin
//           do0 <= 0;
//	       do1 <= 0;
//	       do2 <= 0;
//	       do3 <= 0;
//           for (i = 0; i < 255; i = i + 1) begin // se le asignan valores iniciales a la memoria
//		      Memoria[i] = 0;
//		   end
//    end
    
	always @(*) begin
	   if (Reset) begin
	       do0 <= 0;
	       do1 <= 0;
	       do2 <= 0;
	       do3 <= 0;
           for (i = 0; i < 255; i = i + 1) begin // se le asignan valores iniciales a la memoria
		      Memoria[i] <= 8'd0;
        end
//	   address0<=address;
//	   address1<=address+32'd1;
//	   address2<=address+32'd2;
//	   address3<=address+32'd3;
	
	   case (wme)
	       4'b0001:
	       begin
	           Memoria[address]=datain[7:0];
	       end
	       4'b0011:
	       begin
	           Memoria[address]=datain[7:0];
	           Memoria[address + 1]=datain[15:8];
	       end
	       4'b1111:
	       begin
	           Memoria[address]=datain[7:0];
	           Memoria[address + 1]=datain[15:8];
	           Memoria[address + 2]=datain[23:16];
	           Memoria[address + 3]=datain[31:24];
	       end
	       default:
	       begin
	           
	       end
	   endcase
	   
	    do0 <= Memoria[address];
		do1 <= Memoria[address + 1];
		do2 <= Memoria[address + 2];
		do3 <= Memoria[address + 3];
	       
	end
	end
	
endmodule
