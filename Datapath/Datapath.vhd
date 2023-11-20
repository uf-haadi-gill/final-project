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
        ControllerOpCode : out std_logic_vector(5 downto 0),

        -- ALU Outs
        BranchTaken : out std_logic;
        PC_Mux : out std_logic_vector(31 downto 0)

    );
end datapath;

architecture logic of datapath is

    signal PCReg_to_PCMux : std_logic_vector(31 downto 0) := (others => '0');
    signal ALUOut_to_PCMux : std_logic_vector(31 downto 0) := (others => '0');
    signal PCMux_to_Memory : std_logic_vector(31 downto 0) := (others => '0');
    signal ZeroEx_to_Memory : std_logic_vector(31 downto 0) := (others => '0');
    signal Memory_to_Reg : std_logic_vector(31 downto 0) := (others => '0');
    signal MemReg_to_DataMux : std_logic_vector(31 downto 0) := (others => '0');
    signal ALUMux_to_DataMux : std_logic_vector(31 downto 0) := (others => '0');
    signal DataMux_to_RegFile : std_logic_vector(31 downto 0) := (others => '0');
    signal IR_15_to_0 : std_logic_vector(15 downto 0) := (others => '0');
    signal IR_15_to_11 : std_logic_vector(4 downto 0) := (others => '0');
    signal IR_20_to_16 : std_logic_vector(4 downto 0) := (others => '0');
    signal IR_25_to_21 : std_logic_vector(4 downto 0) := (others => '0');
    signal IR_31_to_26 : std_logic_vector(5 downto 0) := (others => '0');
    signal IR_25_to_0 : std_logic_vector(25 downto 0) := (others => '0');
    signal IRMux_to_RegFile : std_logic_vector(4 downto 0) := (others => '0');
    signal Data1_to_RegA : std_logic_vector(31 downto 0) := (others => '0');
    signal Data2_to_RegB : std_logic_vector(31 downto 0) := (others => '0');
    signal SignEx_to_ShiftLeft : std_logic_vector(31 downto 0) := (others => '0');
    signal ShiftLeft_to_BMux : std_logic_vector(31 downto 0) := (others => '0');
    signal RegB_to_BMux : std_logic_vector(31 downto 0) := (others => '0');
    signal 4_to_BMux : std_logic_vector(31 downto 0) := x"00000004";
    signal BMux_to_ALUMain : std_logic_vector(31 downto 0) := (others => '0');
    signal RegA_to_AMux : std_logic_vector(31 downto 0) := (others => '0');
    signal AMux_to_ALUMain : std_logic_vector(31 downto 0) := (others => '0');
    signal ShiftLeft2_to_Concat : std_logic_vector(27 downto 0) := (others => '0');
    signal Concat_to_PCMux : std_logic_vector(31 downto 0) := (others => '0');
    signal ResultLow_to_RegLow : std_logic_vector(31 downto 0) := (others => '0');
    signal ResultHigh_to_RegHigh : std_logic_vector(31 downto 0) := (others => '0');
    signal RegOut_to_ALUMux : std_logic_vector(31 downto 0) := (others => '0');
    signal RegLow_to_ALUMux : std_logic_vector(31 downto 0) := (others => '0');
    signal RegHigh_to_ALUMux : std_logic_vector(31 downto 0) := (others => '0');
    signal PCMux_to_PCReg : std_logic_vector(31 downto 0) := (others => '0');

begin

end logic;