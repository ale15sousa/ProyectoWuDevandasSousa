`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2021 08:46:05 AM
// Design Name: 
// Module Name: Main_ALU
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
//  Esta ALU como su nombre indica realiza todas las operaciones principales de calculo, por ejemplo la suma o resta para registros o inmediatos
//  Es capaz de realizar operaciones aritmetico-logicas, ademas es capaz de realizar operaciones de comparacion e indicar si se cumple o no
//  estas operaciones mediante un Flag

module Main_ALU(
    input [4:0] Control,           //  Selector de la operacion a realizar de 5 bits
	input [31:0] A,                //  Entrada A de 32 bits
	input [31:0] B,                //  Entrada B de 32 bits
	output reg [31:0] ALU_out,     //  Salida de la operacion
	output reg Flag                //  Salida del flag de comparaciones
    );
    
    //  00000 add       -   suma
    //  00001 sub       -   resta
    //  00010 sll       -   shift logical left
    //  00011 slt       -   set less than signed
    //  00100 sltu      -   set less than unsigned
    //  00101 xor       -   operacion xor a nivel de bit
    //  00110 srl       -   shift right logical
    //  00111 sra       -   shift right arithmetic
    //  01000 or        -   operacion or a nivel de bit
    //  01001 and       -   operacion and a nivel de bit
    //  01010 Pass B    -   B pasa directo como salida
    //  01011 EQ        -   Equal, Si se cumple A=B, Flag en alto
    //  01100 NE        -   Not Equal, Si se cumpla A!=B, Flag en alto
    //  01101 LT        -   Less than, Si se cumple A<B signed, Flag en alto
    //  01110 GE        -   Greater than, Si se cumple A>B signed, Flag en alto
    //  01111 LTU       -   Less than unsigned, Si se cumple A<B unsigned, Flag en alto
    //  10000 GEU       -   Greater than unsigned, Si se cumple A>B unsigned, Flag en alto
    
    always @(*) begin
		case (Control)  //   Se analiza el valor de Control para ver cual caso u operacion debemos realizar
			  5'b00000: //   Suma signed
			  begin
			     ALU_out=$signed(A)+$signed(B);
			  end
			  5'b00001: //  Resta signed
			  begin
			     ALU_out=$signed(A)-$signed(B);
			  end
			  5'b00010: //  Shift left logical
			  begin
			     ALU_out=A<<B;
			  end
			  5'b00011: //  Set less than signed
			  begin
                if ($signed(A)<$signed(B)) begin
                    ALU_out=32'd1;
                end
                else begin
                    ALU_out=32'd0;
                end
			  end
			  5'b00100: //  Set less than unsigned
			  begin
			     if (A<B) begin
                    ALU_out=32'd1;
                 end
                 else begin
                    ALU_out=32'd0;
                 end
			  end
			  5'b00101: //  bitwise xor
			  begin
			     ALU_out=A^B;
			  end
			  5'b00110: //  shift right logical
			  begin
			     ALU_out=A>>B;
			  end
			  5'b00111: //  shift right arithmetic
			  begin
			     ALU_out=$signed(A)>>>B;
			  end
			  5'b01000: //  bitwise or
			  begin
			     ALU_out=A|B;
			  end
	          5'b01001: //  bitwise and
	          begin
	             ALU_out=A&B;
	          end
		      5'b01010: //  pass B
		      begin
		          ALU_out=B;
		      end
		      5'b01011: //  Equal
		      begin
		          if (A==B) begin
		              ALU_out=32'd1;
		              Flag=1;
		          end
		          else begin
		              ALU_out=32'd0;
		              Flag=0;
		          end
		      end
		      5'b01100: //  Not equal
		      begin
		          if (A!=B) begin
		              ALU_out=32'd1;
		              Flag=1;
		          end
		          else begin
		              ALU_out=32'd0;
		              Flag=0;
		          end
		      end
		      5'b01101: //  less than signed
		      begin
		          if ($signed(A)<$signed(B)) begin
		              ALU_out=32'd1;
		              Flag=1;
		          end
		          else begin
		              ALU_out=32'd0;
		              Flag=0;
		          end
		      end
		      5'b01110: //  greater than signed
		      begin
		          if ($signed(A)>$signed(B)) begin
		              ALU_out=32'd1;
		              Flag=1;
		          end
		          else begin
		              ALU_out=32'd0;
		              Flag=0;
		          end
		      end
		      5'b01111: //  less than unsigned
		      begin
		          if (A<B) begin
		              ALU_out=32'd1;
		              Flag=1;
		          end
		          else begin
		              ALU_out=32'd0;
		              Flag=0;
		          end
		      end
		      5'b10000: //  greater than unsigned
		      begin
			     if (A>B) begin
			          ALU_out=32'd1;
		              Flag=1;
		          end
		          else begin
		              ALU_out=32'd0;
		              Flag=0;
		          end
		      end
		      endcase
		end
		
		initial begin
           Flag=0;
        end
		
endmodule
