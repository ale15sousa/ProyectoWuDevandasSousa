`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 12:48:09 PM
// Design Name: 
// Module Name: Memoria_Instrucciones
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


module Memoria_Instrucciones(
    input [31:0] ADDR,
    output reg [31:0] INST
);
    reg [31:0] memoria [2047:0];

    initial begin
        $readmemh("INSTRUCCIONES.mem", memoria, 0, 2047);
   end 

    always @(ADDR) begin

        INST <= memoria[ADDR>>2];

      end

endmodule
