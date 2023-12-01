library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity topLevel is 
    port(
        LEDs : out std_logic_vector(31 downto 0);
        
        Switches : in std_logic_vector(9 downto 0);
        button0, button1, clk, rst : in std_logic
    );
end topLevel;

architecture logic of topLevel is 
    signal PCWrite, PCWriteCond, IorD, MemRead, MemWrite, MemToReg, IRWrite, JumpAndLink, IsSigned, ALUSrcA, RegWrite, RegDst : std_logic;
    signal ALUSrcB, PCSource, ALUOp : std_logic_vector(1 downto 0);
    signal IR_31_to_26 : std_logic_vector(5 downto 0);
begin
    
    Control : entity work.controller
    port map(
        IR_31_to_26 => IR_31_to_26, 
        clk => clk,
        rst => rst,
        PCWriteCond => PCWriteCond,
        PCWrite => PCWrite,
        IorD => IorD, 
        MemRead => MemRead,
        MemWrite => MemWrite,
        MemToReg => MemToReg,
        IRWrite => IRWrite,
        JumpAndLink => JumpAndLink,
        IsSigned => IsSigned,
        PCSource => PCSource,
        ALUOp => ALUOp,
        ALUSrcA => ALUSrcA,
        ALUSrcB => ALUSrcB,
        RegWrite => RegWrite,
        RegDst => RegDst
    );

    Data : entity work.datapath
    port map(
        button0 => button0,
        button1 => button1,
        switches => switches,
        LEDs => LEDs,
        clk => clk,
        rst => rst,
        PCWriteCond => PCWriteCond,
        PCWrite => PCWrite,
        IorD => IorD, 
        MemRead => MemRead,
        MemWrite => MemWrite,
        MemToReg => MemToReg,
        IRWrite => IRWrite,
        JumpAndLink => JumpAndLink,
        IsSigned => IsSigned,
        PCSource => PCSource,
        ALUOp => ALUOp,
        ALUSrcA => ALUSrcA,
        ALUSrcB => ALUSrcB,
        RegWrite => RegWrite,
        RegDst => RegDst,
        ControllerOpCode => IR_31_to_26
    );

end logic;
