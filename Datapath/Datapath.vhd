library ieee;
use ieee.std_logic_1164.all;


entity datapath is
    port(
        -- Top Level Interface
        button0 : in std_logic;
        button1 : in std_logic;
        switches         : in std_logic_vector(9 downto 0);
        LEDs             : out std_logic_vector(9 downto 0);

        -- Controller Interface
        PCWriteCond      : in  std_logic;
        PCWrite          : in  std_logic;
        IorD             : in  std_logic;
        MemRead          : in  std_logic;
        MemWrite         : in  std_logic;
        MemToReg         : in  std_logic;
        IRWrite          : in  std_logic;
        JumpAndLink      : in  std_logic;
        IsSigned         : in  std_logic;
        PCSource         : in  std_logic;
        ALUOp            : in  std_logic;
        ALUSrcA          : in  std_logic;
        ALUSrcB          : in  std_logic;
        RegWrite         : in  std_logic;
        RegDst           : in  std_logic;
        ControllerOpCode : out std_logic_vector(5 downto 0)

    );
end datapath;

architecture logic of datapath is
begin
    
end logic;