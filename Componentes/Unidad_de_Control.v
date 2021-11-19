`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2021 09:01:03
// Design Name: 
// Module Name: Unidad de Control
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


module Unidad_de_Control(
    
    input [6:0] opcode, //seccion de la instruccion que indica su tipo (R,I,U,B,J,S)
	input [6:0] funct7, //esta seccion aporta identidad adicional a operaciones como sub, add, srai, srli.
	input [2:0] funct3, //sirve como identificador de la operacion dentro de su tipo de instruccion.
	output reg wre,    //enable que permite escribir en banco de registros
	output reg [1:0] muxsa,    //selector de mux que indica que entra a "A" en la ALU
	output reg muxsb,  //selector de mux que indica que entra a "B" en la ALU
	output reg muximm, //Selector que elige la seccioon de instruccion a concatenar para forma inmediatos.
	output reg [4:0] aluop,    //salida que indica a la ALU que operacion realizar
	output reg muxrw,  //selector del mux que selecciona si enviar a registro el resultado de ALU o el data out de memoria
	output reg [3:0] wme,  //enable que permite escribir en la memoria de datos
	output reg su, //selector que indica a extensores si hacerlo por signo o no
	output reg [1:0] muxlm,  //selector del mux que direcciona Loads entre Byte, Half-word y Word
	output reg jrj,    //selector del mux que decide el proximo
	output reg jrw,    //selector del mux que direcciona a registro un valor a guardar o cierto PC.
	output reg [1:0] pcsel //selector del alu para el valor a sumar al PC
    );
    
    
    always @(*) begin
    case (opcode)
    
        7'b0000011: //Instrucciones tipo I para carga de memoria a registro.
        begin
        
        wre = 1'b1;
        muxsa = 2'b00;
        muxsb = 1'b0;
        muximm = 1'b0;
        aluop = 5'b00000;
        muxrw = 1'b0;
        wme = 4'b0000;
        jrj = 1'b0;
        jrw = 1'b0;
        pcsel = 2'b00;
        
            case (funct3)   //funct3 define el tipo de carga a realizar, esto determina si el valor sera extendido en signo
                            // ademas de cuantos bytes del valor se cargaran. 
                3'b000: begin //Load Byte
                    su = 1'b1;
                    muxlm = 2'b01;
                end
                
                3'b001: begin //Load half-word
                    su = 1'b1;
                    muxlm = 2'b00;
                end
                
                3'b010: begin //Load word
                    su = 1'b1;
                    muxlm = 2'b10;
                end
                
                3'b100: begin //Load unsigned byte
                    su = 1'b0;
                    muxlm = 2'b01;
                end
                
                3'b101: begin //Load unsigned half-word
                    su = 1'b0;
                    muxlm = 2'b00;
                end
                
                default: begin
                    su = 1'b0;
                    muxlm = 2'b0;
                end
            
            endcase 
              
        end
        
        7'b0010011: //Instrucciones tipo I para operaciones registro-inmediato.
        begin
        
        wre = 1'b1;
        muxsa = 2'b00;
        muxsb = 1'b0;
        muximm = 1'b1;
        muxrw = 1'b1;
        wme = 4'b0000;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b1;
        jrw = 1'b1;
        pcsel = 2'b00;
        
            case (funct3)   //funct3  define la operacion a realizar, por consiguiente la se;al que se enviar[a a la ALU.
            
                3'b000: begin //ADDI
                    aluop = 5'b00000;
                end
                
                3'b001: begin //SLLI
                    aluop = 5'b00010;
                end
                
                3'b010: begin //SLTI
                    aluop = 5'b00011;
                end
                
                3'b011: begin //SLTIU
                    aluop = 5'b00100;
                end
                
                3'b100: begin //XORI
                    aluop = 5'b00101;
                end
                
                3'b101: begin //SRLI, SRAI    En ambos casos al compartir funct3, funct7 se utiliza para diferenciarlas.
                    if (funct7 == 7'b0100000) begin //SRAI
                        aluop = 5'b00111;
                    end
                    
                    else if (funct7 == 7'b0000000) begin //SRLI
                        aluop = 5'b00110;
                    end
                end
                
                3'b110: begin //ORI
                    aluop = 5'b01000;
                end
                
                3'b111: begin //ANDI
                    aluop = 5'b01001;
                end
                
                default: begin
                    aluop = 5'b00000;
                end
                
            endcase 
        
        end
        
        7'b0100011: //Instrucciones tipo S para guardado en memoria de datos.
        begin
        
        wre = 1'b0;
        muxsa = 2'b00;
        muxsb = 1'b0;
        muximm = 1'b1;
        aluop = 5'b00000;
        muxrw = 1'b1;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b1;
        jrw = 1'b1;
        pcsel = 2'b00; 
        
            case (funct3)   //funct3 determina la cantidad de bytes del dato de entrada a guardar en memoria.
            
                3'b000: begin   //STORE BYTE
                    wme = 4'b0001;
                end
                
                3'b001: begin  //STORE HALF-WORD 
                    wme = 4'b0011;
                end
                
                3'b010: begin   //STORE WORD
                    wme = 4'b1111;
                end
            
            endcase
        
        end
        
        7'b0110011: //Instrucciones tipo R para operaciones registro-registro.
        begin
        
        wre = 1'b1;
        muxsa = 2'b01;
        muxsb = 1'b0;
        muximm = 1'b0;
        muxrw = 1'b1;
        wme = 4'b0000;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b1;
        jrw = 1'b1;
        pcsel = 2'b00;
            
            case (funct3)      //Como en el caso anterior funct3 define el tipo de operacion.
                               //Y en ciertos casos, se recurre a utilizar funct7 para diferenciar.
                3'b000: begin   //SUMA Y RESTA
                    if (funct7 == 7'b0000000) begin //ADD
                        aluop = 5'b00000;
                    end
                    
                    else if (funct7 == 7'b0100000) begin //SUB
                        aluop = 5'b00001;
                    end
                end
                
                3'b001: begin  //SLL
                    aluop = 5'b00010;
                end
                
                3'b010: begin   //SLT
                    aluop = 5'b00011;
                end
                
                3'b011: begin   //SLTU
                    aluop = 5'b00100;
                end
                
                3'b100: begin  //XOR
                    aluop = 5'b00101;
                end
                
                3'b101: begin   //Operaciones Shift Right
                    if (funct7 == 7'b0000000) begin //SRL
                        aluop = 5'b00110;
                    end
                    
                    else if (funct7 == 7'b0100000) begin //SRA
                        aluop = 5'b00111;
                    end
                end
                
                3'b110: begin   //STORE BYTE
                    aluop = 5'b01000;
                end
                
                3'b111: begin  //STORE HALF-WORD 
                    aluop = 5'b01001;
                end
            
            endcase
        
        end
        
        7'b1100011: //Instrucciones tipo B para operaciones de branch condicional.
        begin
        
        wre = 1'b0;
        muxsa = 2'b01;
        muxsb = 1'b0;
        muximm = 1'b0;
        muxrw = 1'b1;
        wme = 4'b0000;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b1;
        jrw = 1'b1;
        pcsel = 2'b01;
            
            case (funct3)       //Se utilizo funct3 para determinar el tipo de comparacion que realiza la ALU entre registros
                                //Para determinar si se realiza o no el branch
                3'b000: begin   //SUMA Y RESTA
                    aluop = 5'b01011;
                end
                
                3'b001: begin  //SLL
                    aluop = 5'b01100;
                end
                
                3'b100: begin   //SLT
                    aluop = 5'b01101;
                end
                
                3'b101: begin   //SLTU
                    aluop = 5'b01110;
                end
                
                3'b110: begin  //XOR
                    aluop = 5'b01111;
                end
                
                3'b111: begin   //Operaciones Shift Right
                    aluop = 5'b10000;
                end
            
            endcase
        
        end
        
        //INSTRUCCIONES TIPO U
        
        7'b0010111: //Instruccion AUIPC.
        begin
        
        wre = 1'b1;
        muxsa = 2'b10;
        muxsb = 1'b1;
        muximm = 1'b0;
        aluop = 5'b00000;
        muxrw = 1'b1;
        wme = 4'b0000;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b1;
        jrw = 1'b1;
        pcsel = 2'b00;
        
        end
        
        7'b0110111: //Instruccion LUI.
        begin
        
        wre = 1'b1;
        muxsa = 2'b01;
        muxsb = 1'b1;
        muximm = 1'b0;
        aluop = 5'b01010;
        muxrw = 1'b1;
        wme = 4'b0000;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b1;
        jrw = 1'b1;
        pcsel = 2'b00;
        
        end
        
        //INSTRUCCIONES TIPO I
        
        7'b1100111: //Instruccion JALR.
        begin
        
        wre = 1'b1;
        muxsa = 2'b00;
        muxsb = 1'b0;
        muximm = 1'b0;
        aluop = 5'b00000;
        muxrw = 1'b1;
        wme = 4'b0000;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b0;
        jrw = 1'b0;
        pcsel = 2'b00;
        
        end
        
        //INSTRUCCIONES TIPO J
        
        7'b1101111: //Instruccion JAL.
        begin
        
        wre = 1'b1;
        muxsa = 2'b01;
        muxsb = 1'b0;
        muximm = 1'b0;
        aluop = 5'b00000;
        muxrw = 1'b1;
        wme = 4'b0000;
        su = 1'b1;
        muxlm = 2'b10;
        jrj = 1'b1;
        jrw = 1'b0;
        pcsel = 2'b10;
        
        end
        
        default: //Default setting para evitar incertidumbre de registros.
        begin
        
        wre = 1'b0;
        muxsa = 2'b00;
        muxsb = 1'b0;
        muximm = 1'b0;
        aluop = 5'b00000;
        muxrw = 1'b0;
        wme = 4'b0000;
        su = 1'b0;
        muxlm = 2'b00;
        jrj = 1'b0;
        jrw = 1'b0;
        pcsel = 2'b00; 
              
        end
        
    endcase
    end
    
endmodule
