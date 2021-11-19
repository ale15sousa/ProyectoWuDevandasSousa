`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 01:24:05 AM
// Design Name: 
// Module Name: Memoria_Datos_tb
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
//  Esta prueba se realizo para comprobar la capacidad de la memoria de datos de leer y escribir palabras
//  Ademas de realizar las operaciones de store byte, store half word y store word
//  Se estudiaron casos donde se le cae encima a toda una palabra asi como a sus bytes individuales

module Memoria_Datos_tb;
    //  Entradas
    reg [31:0] address;
	reg [31:0] datain;
	reg Reset;
    reg CLK;
	reg [3:0] wme;
	
	//  Salidas
	wire [7:0] do0;
	wire [7:0] do1;
	wire [7:0] do2;
	wire [7:0] do3;
	
	//  Unidad bajo prueba es el modulo Memoria_Datos
	Memoria_Datos uut (   //  Establecimiento de parametros
        .address(address),
        .datain(datain),
        .CLK(CLK),
        .wme(wme),
        .do0(do0),
        .do1(do1),
        .do2(do2),
        .do3(do3)
    );
    
    initial
    begin
        CLK=0;                  //  CLK inicializado
        wme=4'd0;               //  No queremos escribir
        address=32'd0;
        #20;
        address=32'd4;          //  Direccion de memoria 4
        datain=32'hABCDEF24;    //  Esta es la palabra que nos interesa escribir
        #20;
        wme=4'b1111;            //  Escribimos toda la palabra
        #20;                    //  Se espera que las direcciones de memoria 4 (lsb) hasta 7 (msb) contengan a la palabra ABCDEF24
        wme=4'd0;               //  Ya no escribimos
        #20;
        address=32'd8;          //  la direccion de memoria ahora es 8
        wme=4'b0011;            //  queremos escribir media palabra
        #20;                    //  se espera que los bits 8 y 9 contengan los bytes menos significativos de la palabra, es decir
                                //  24 en 8 y EF en 9 en hexadecimal
        wme=4'd0;               //  ya no queremos escribir
        #20;
        address=32'd12;         //  ahora queremos escribir en la direccion de memoria 12
        wme=4'b0001;            //  solo queremos escribir un byte, el menos significativo de la palabra en la direccion de memoria 12
        #20;                    //  se espera que el espacio de memoria 12 tenga el valor de 24 en hexadecimal
        wme=4'd0;               // ya no queremos escribir
        #20;    
        address=32'd17;         //  direccion de memoria es 17
        wme=4'b0001;            //  escribimos un byte, el menos significativo de la palabra en el byte 17
        #20;                    //  se espera que el valor del espacio de memoria 17 sea 24 en hexadecimal
        wme=4'd0;
        #20;
        address=32'd4;          //  Leemos los correspondientes espacios de memoria para corroborar sus valores
        #40;
        address=32'd8;
        #40;
        address=32'd12;
        #40;
        address=32'd16;
        #40;
        #20;
        address=32'd4;          //  direccion de memoria 4
        datain=32'hAAAAAAAA;    //  nueva palabra
        #20;
        wme=4'b1111;            //  queremos escribir una palabra, le va a caer encima al espacio de memoria 4
        #20;                    //  se espera que del espacio de memoria 4 al 7 tenga todo AAAAAAAA
        wme=4'd0;               //  ya no escribimos
        #20;
        datain=32'hBBBBBBBB;    //  nueva palabra
        address=32'd5;          //  direccion de memoria 5
        #5;
        wme=4'b0001;            //  queremos escribir un unico byte entonces el espacio de memoria 5 seria BB en hexadecimal
        #20;
        wme=4'd0;               //  ya no escribimos
        #20;
        address=32'd4;          //  direccion de memoria 4
        #10;
        Reset=1;                //  se realiza un reset
        #20;
        Reset=0;
        $finish;
    end
    always #5 CLK=~CLK;
    
endmodule
