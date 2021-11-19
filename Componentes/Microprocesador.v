`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2021 11:27:18 AM
// Design Name: 
// Module Name: Microprocesador
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


module Microprocesador(
    input CLK,
    input Reset
    );
    
    wire JRJ, muximm, Flag, wre, SU, muxsb, muxrw;
    wire [31:0] ADDR, INST, MemHaldWord, MemByte, PCNext, RegPCIn, RegPCOut, BranchPC, JalPC, PCAluIn, Condtomuxalu, PCAluOut, Uout, do1, AluA, AluB, di, Imm32, do2, MainOut, MemWord, MemData, DataOut, Uout;
    wire [1:0] PCSel, muxlm, muxsa;
    wire [19:0] JalIn, UIn;
    wire [12:0] BranchIn;
    wire [11:0] Cin12;
    wire [4:0] ImmB, rs2, rs1, rd, Imm5, aluop;
    wire [7:0] dout0, dout1, dout2, dout3;
    wire [15:0] HalfWord;
    wire [3:0] wme;
    
    
    Memoria_Instrucciones MemInstrucciones(
        .ADDR(ADDR),
        .INST(INST)
    );
    
    Unidad_de_Control UC (
        .opcode(INST[6:0]),
	    .funct7(INST[31:25]),
	    .funct3(INST[14:12]),
	    .wre(wre),
	    .muxsa(muxsa),
	    .muxsb(muxsb),
	    .muximm(muximm),
	    .aluop(aluop),
	    .muxrw(muxrw),
	    .wme(wme),
	    .su(SU),
	    .muxlm(muxlm),
	    .jrj(jrj),
	    .jrw(jrw),
	    .pcsel(pcsel)
    );
    
    
    
    Mux_2a1_32bits MuxJRJ (
        .Control(jrj),
        .Entrada_0(DataOut),
        .Entrada_1(PCAluOut),
        .Salida(RegPCIn)
    );
    
    RegPC RegPC (
        .Q(RegPCOut),
        .D(RegPCIn),
        .CLK(CLK)
    );
    
    Mux_2a1_32bits Condicion (
        .Control(Flag),
        .Entrada_0(32'd4),
        .Entrada_1(BranchPC),
        .Salida(Condtomuxalu)
    );
    
    Mux_4a1_32bits MuxPCALU (
        .Control(pcsel),
        .Entrada_0(32'd4),
        .Entrada_1(Condtomuxalu),
        .Entrada_10(JalPC),
        .Entrada_11(32'd0),
        .Salida(PCAluIn)
    );
    
    assign JalIn = {INST[31],INST[19:12],INST[20],INST[30:21]};
    
    SignExtend_20_32 SignJal (
        .Entrada(JalIn),
        .Salida(JalPC)
    );
    
    assign BranchIn = {INST[31],INST[7],INST[30:25],INST[11:8], 1'b0};
    
    SignExtend_13_32 Branch (
        .Entrada(BranchIn),
        .Salida(BranchPC)
    );
    
    PC_ALU PCAlu (
        .A(RegPCOut),
	    .B(PCAluIn),
	    .ALU_out(PCAluOut)
    );
    
    Banco_Registros BancoRegistros ( ///////////////////
        .CLK(CLK),
        .rs2(INST[24:20]),
        .rs1(INST[19:15]),
        .rd(INST[11:7]),
        .di(di),
        .wre(wre),
        .Reset(Reset),
        .do2(do2),
        .do1(do1)
    );
    
    assign UIn = INST[31:12];
    
    SignExtend_U ExtensorU (
        .Entrada(UIn),
        .Salida(Uout)
    );
    
    Mux_2a1_32bits MainAluB (
        .Control(muxsb),
        .Entrada_0(do1),
        .Entrada_1(Uout),
        .Salida(AluB)
    );
    
    Mux_2a1_32bits MuxJRW (
        .Control(jrw),
        .Entrada_0(PCAluOut),
        .Entrada_1(DataOut),
        .Salida(di)
    );
    
    
    Mux_2a1_5bits MuxInmediato ( ///////////////////
        .Control(muximm),
        .Entrada_0(INST[24:20]),
        .Entrada_1(INST[11:7]),
        .Salida(Imm5)
    );
    
    assign Cin12 = {INST[31:25], Imm5};
    SignExtend_12_32 ExtensorImm (
        .Entrada(Cin12),  
        .Salida(Imm32)   
    );
    
    Mux_4a1_32bits MainAluA (
        .Control(muxsa),
        .Entrada_0(Imm32),
        .Entrada_1(do2),
        .Entrada_10(RegPCOut),
        .Entrada_11(32'd0),
        .Salida(AluA)
    );
    
    Main_ALU MainAlu (
        .Control(aluop),
	    .A(AluA),
	    .B(AluB),
	    .ALU_out(MainOut),
	    .Flag(Flag)
    );
    
    Memoria_Datos MemoriaDatos (
        .address(MainOut),
        .datain(do2),
        .CLK(CLK),
        .wme(wme),
        .do0(dout0),
        .do1(dout1),
        .do2(dout2),
        .do3(dout3)
    );
    
    SignExtend_8_32 ExtensorByte (
        .Entrada(dout0), 
        .Salida(MemByte),    
        .Signo(SU)
    );
    
    assign HalfWord = {dout1, dout0};
    SignExtend_16_32 ExtensorHalfWord (
        .Entrada(HalfWord), 
        .Salida(MemHalfWord),    
        .Signo(SU)
    );
    
    assign MemWord = {dout3, dout2, dout1, dout0};
    Mux_4a1_32bits MuxMemOutput (
        .Control(muxlm),
        .Entrada_0(MemHalfWord),
        .Entrada_1(MemByte),
        .Entrada_10(MemWord),
        .Entrada_11(32'd0),
        .Salida(MemData)
    );
    
    Mux_2a1_32bits MuxWR (
        .Control(muxrw),
        .Entrada_0(MemData),
        .Entrada_1(MainOut),
        .Salida(DataOut)
    );
    
endmodule
