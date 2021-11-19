`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2021 11:23:36
// Design Name: 
// Module Name: Unidad_de_Control_tb
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
//El objetivo de esta prueba es comprobar que la unidad de control genera la salida deseada para instrucciones especificas,
//segun el opcode, funct3 y funct7 que esta reciba de la isntruccion.

//En esta prueba se dara como input a la UC informacion correspondiente a 3 instrucciones de diferente tipo
//separada por intervalos de tiempo, y se analizara en su salida si esta aporta las senales necesarias para que se ejecuten correctamente.

module Unidad_de_Control_tb;
    reg [6:0] opcode; //seccion de la instruccion que indica su tipo (R,I,U,B,J,S)
	reg [6:0] funct7; //esta seccion aporta identidad adicional a operaciones como sub, add, srai, srli.
	reg [2:0] funct3; //sirve como identificador de la operacion dentro de su tipo de instruccion.
	wire wre;    //enable que permite escribir en banco de registros
	wire [1:0] muxsa;    //selector de mux que indica que entra a "A" en la ALU
	wire muxsb;  //selector de mux que indica que entra a "B" en la ALU
	wire muximm; //Selector que elige la seccioon de instruccion a concatenar para forma inmediatos.
	wire [4:0] aluop;    //salida que indica a la ALU que operacion realizar
	wire muxrw;  //selector del mux que selecciona si enviar a registro el resultado de ALU o el data out de memoria
	wire [3:0] wme;  //enable que permite escribir en la memoria de datos
	wire su; //selector que indica a extensores si hacerlo por signo o no
	wire [1:0] muxlm;  //selector del mux que direcciona Loads entre Byte, Half-word y Word
	wire jrj;    //selector del mux que decide el proximo
	wire jrw;    //selector del mux que direcciona a registro un valor a guardar o cierto PC.
	wire [1:0] pcsel; //selector del alu para el valor a sumar al PC
	reg [31:0] instruccion = 0;
	
	Unidad_de_Control uut(
	
	.opcode(opcode),
	.funct7(funct7),
	.funct3(funct3),
	.wre(wre),
	.muxsa(muxsa),
	.muxsb(muxsb),
	.muximm(muximm),
	.aluop(aluop),
	.muxrw(muxrw),
	.wme(wme),
	.su(su),
	.muxlm(muxlm),
	.jrj(jrj),
	.jrw(jrw),
	.pcsel(pcsel)

    );
    
    initial begin
    
    #50
    instruccion = 32'hfe010113; //Instruccion ADDI
    #100
    instruccion = 32'h0000b7b7; //Instruccion LUI
    #100
    instruccion = 32'hfe042023; //Instruccion SW
    #100
    instruccion = 32'hfef710e3; //Instruccion BNE
    #100
    instruccion = 32'h00f707b3; //Instruccion ADD
    #100
    instruccion = 32'h00c0006f; //Pseudoinst J (se extiende a JAL)
    #100
   
    $finish; //fin de prueba
    
    end
    
    always @(instruccion) opcode = instruccion[6:0];
    always @(instruccion) funct7 = instruccion[31:25];
    always @(instruccion) funct3 = instruccion[14:12];
    
endmodule
