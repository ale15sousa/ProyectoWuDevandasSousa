`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:47:47 AM
// Design Name: 
// Module Name: Banco_Registros
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
// El banco de registros contiene a los 16 registros basicos para el funcionamiento de una arquitectura RISCV
//////////////////////////////////////////////////////////////////////////////////

module Banco_Registros(         //  El Banco de Registros contiene a los 16 registros de la arquitectura RISCV
                                //  Tiene la capacidad de leer dos registros en un instante dado y escribir a un unico registro
    input CLK,                  //  Reloj
    input [4:0] rs2,            //  Direccion de lectura del segundo registro
    input [4:0] rs1,            //  Direccion de lectura del primer registro
    input [4:0] rd,             //  Registro destino si se escribe un dato en algun registro
    input [31:0] di,            //  Es el dato que se escribe en el registro destino rd si se da la escritura, data-in
    input wre,                  //  Es un enable que nos permite la escritura, solo se escribe cuando esta en alto
    input Reset,
    output reg [31:0] do2,      //  Dato de salida, data-out, del registro con la direccion especificada en rs2
    output reg [31:0] do1       //  Dato de salida, data-out, del registro con la direccion especificada en rs1
    );
    
    integer i;
    
    reg [31:0] registers[31:0]; //  Tenemos un conjunto de 16 registros, cada uno de 32 bits
    
	always @(posedge CLK)begin     //  En el flanco positivo de reloj se realiza lo siguiente
	   if(Reset)begin              //  Si se da un reset ponemos todos los registros en cero
	       for(i=0; i<32; i=i+1)   //  For loop para poner los registros en 0
               registers[i] <= 0;  //  Asigna el valor de 0 al registro i
	   end
	   if(wre) begin               //  Se revisa si tenemos que escribir en algun registro
		  registers[rd]<=di;      //  Si el enable de la escritura esta en 1, entonces se escribe el data-in al registro de destino
		  end
	   end
	
	always @(*) begin              //  Siempre se actualiza cuando alguna de sus entradas cambia
	   registers[0]<=0;
	   do2 = registers[rs2];       //  Actualiza el valor de salida data-out 2 debido a que rs2 pudo cambiar
	   do1 = registers[rs1];       //  Actualiza el valor de salida data-out 1 debido a que rs1 pudo cambiar
	   end
endmodule
