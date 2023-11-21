library ieee;
use ieee.std_logic_1164.all;


entity datapath is
    port(
        -- Top Level Interface
        button0          : in std_logic;
        button1          : in std_logic;
        switches         : in std_logic_vector(9 downto 0);
        LEDs             : out std_logic_vector(31 downto 0);

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
        PCSource         : in  std_logic_vector(1 downto 0);
        ALUOp            : in  std_logic_vector(1 downto 0);
        ALUSrcA          : in  std_logic;
        ALUSrcB          : in  std_logic_vector(1 downto 0);
        RegWrite         : in  std_logic;
        RegDst           : in  std_logic;
        ControllerOpCode : out std_logic_vector(5 downto 0);

        -- ALU Outs
        BranchTaken      : buffer std_logic;
        --PC_Mux : out std_logic_vector(31 downto 0);

        -- General Inputs
        clk, rst        : in std_logic

    );
end datapath;

architecture logic of datapath is

    signal PCReg_to_CodeMux      : std_logic_vector(31 downto 0) := (others => '0');
    signal ALUOut_to_CodeMux     : std_logic_vector(31 downto 0) := (others => '0');
    signal CodeMux_to_Memory     : std_logic_vector(31 downto 0) := (others => '0');
    signal ZeroEx_to_Memory      : std_logic_vector(31 downto 0) := (others => '0');
    signal Memory_to_Reg         : std_logic_vector(31 downto 0) := (others => '0');
    signal MemReg_to_DataMux     : std_logic_vector(31 downto 0) := (others => '0');
    signal ALUMux_to_DataMux     : std_logic_vector(31 downto 0) := (others => '0');
    signal DataMux_to_RegFile    : std_logic_vector(31 downto 0) := (others => '0');
    signal IR_15_to_0            : std_logic_vector(15 downto 0) := (others => '0');
    signal IR_15_to_11           : std_logic_vector(4  downto 0) := (others => '0');
    signal IR_20_to_16           : std_logic_vector(4  downto 0) := (others => '0');
    signal IR_25_to_21           : std_logic_vector(4  downto 0) := (others => '0');
    signal IR_31_to_26           : std_logic_vector(5  downto 0) := (others => '0');
    signal IR_25_to_0            : std_logic_vector(25 downto 0) := (others => '0');
    signal IRMux1_to_RFReg       : std_logic_vector(4  downto 0) := (others => '0');
    signal IRMux2_to_RFData      : std_logic_vector(31 downto 0) := (others => '0');
    signal Data1_to_RegA         : std_logic_vector(31 downto 0) := (others => '0');
    signal Data2_to_RegB         : std_logic_vector(31 downto 0) := (others => '0');
    signal SignEx_to_ShiftLeft   : std_logic_vector(31 downto 0) := (others => '0');
    signal ShiftLeft_to_BMux     : std_logic_vector(31 downto 0) := (others => '0');
    signal RegB_to_BMux          : std_logic_vector(31 downto 0) := (others => '0');
    signal four_to_BMux             : std_logic_vector(31 downto 0) := x"00000004";
    signal BMux_to_ALUMain       : std_logic_vector(31 downto 0) := (others => '0');
    signal RegA_to_AMux          : std_logic_vector(31 downto 0) := (others => '0');
    signal AMux_to_ALUMain       : std_logic_vector(31 downto 0) := (others => '0');
    signal ShiftLeft2_to_Concat  : std_logic_vector(27 downto 0) := (others => '0');
    signal Concat_to_PCMux       : std_logic_vector(31 downto 0) := (others => '0');
    signal ResultLow_to_RegLow   : std_logic_vector(31 downto 0) := (others => '0');
    signal ResultHigh_to_RegHigh : std_logic_vector(31 downto 0) := (others => '0');
    signal RegOut_to_ALUMux      : std_logic_vector(31 downto 0) := (others => '0');
    signal RegLow_to_ALUMux      : std_logic_vector(31 downto 0) := (others => '0');
    signal RegHigh_to_ALUMux     : std_logic_vector(31 downto 0) := (others => '0');
    signal PCMux_to_PCReg        : std_logic_vector(31 downto 0) := (others => '0');
    signal ALUCtrl_to_ALUMain    : std_logic_vector(4  downto 0) := (others => '0');

    signal RegLow_en : std_logic := '0';
    signal RegHigh_en : std_logic := '0';
    signal ALU_Low_High : std_logic_vector(1 downto 0) := (others => '0');

    

begin
    ---------------------------------------------------------------------
    --
    --                     Registers
    --
    ---------------------------------------------------------------------
    PCReg : entity work.reg
    port map(
        input  => PCMux_to_PCReg,
        clk    => clk, 
        rst    => rst, 
        enable => PCWrite or (BranchTaken and PCWriteCond),
        output => PCReg_to_CodeMux
    );

    MemDataReg : entity work.reg
    port map(
        input => Memory_to_Reg,
        clk    => clk,
        rst    => rst,
        enable => '1',
        output => MemReg_to_DataMux
    );

    RegA : entity work.reg
    port map(
        input  => Data1_to_RegA,
        clk    => clk,
        rst    => rst,
        enable => '1',
        output => RegA_to_AMux
    );

    RegB : entity work.reg
    port map(
        input  => Data2_to_RegB,
        clk    => clk,
        rst    => rst,
        enable => '1',
        output => RegB_to_BMux
    );

    ALUOut : entity work.reg
    port map(
        input  => ResultLow_to_RegLow,
        clk    => clk,
        rst    => rst,
        enable => '1',
        output => ALUOut_to_CodeMux
    );

    RegLow : entity work.reg
    port map(
        input  => ResultLow_to_RegLow,
        clk    => clk,
        rst    => rst,
        enable => RegLow_en,
        output => RegLow_to_ALUMux
    );

    RegHigh : entity work.reg
    port map(
        input  => ResultHigh_to_RegHigh ,
        clk    => clk,
        rst    => rst,
        enable => RegHigh_en,
        output => RegHigh_to_ALUMux
    );

    ---------------------------------------------------------
    --
    --                Multiplexors
    --
    ---------------------------------------------------------
    
    ------------------------ 2 to 1 ----------------------------
    
    CodeMux : entity work.mux2to1
    port map(
        input1 => PCReg_to_CodeMux,
        input2 => ALUOut_to_CodeMux,
        sel    => IorD,
        output => CodeMux_to_Memory
    );

    RegDstMux : entity work.mux2to1
    generic map(
        WIDTH => 5
    )
    port map(
        input1 => IR_20_to_16,
        input2 => IR_15_to_11,
        sel    => RegDst,
        output => IRMux1_to_RFReg
    );

    MemtoRegMux : entity work.mux2to1
    port map(
      input1 => MemReg_to_DataMux,
      input2 => ALUMux_to_DataMux,
      sel    => MemToReg,
      output => IRMux2_to_RFData  
    );

    RegAMux : entity work.mux2to1
    port map(
        input1 => PCReg_to_CodeMux,
        input2 => RegA_to_AMux,
        sel    => ALUSrcA,
        output => AMux_to_ALUMain
    );


    ------------------------ 3 to 1 ---------------------------
    PCSourceMux : entity work.mux3to1
    port map(
        input1 => ResultLow_to_RegLow,
        input2 => ALUOut_to_CodeMux,
        input3 => Concat_to_PCMux,
        sel    => PCSource,
        output => PCMux_to_PCReg
    );

    ALUMux : entity work.mux3to1
    port map(
        input1 => ALUOut_to_CodeMux,
        input2 => RegLow_to_ALUMux,
        input3 => RegHigh_to_ALUMux,
        sel    => ALU_Low_High,
        output => ALUMux_to_DataMux
    );


    ------------------------ 4 to 1 ---------------------------
    RegBMux : entity work.mux4to1
    port map(
        input1 => RegB_to_BMux,
        input2 => four_to_BMux,
        input3 => SignEx_to_ShiftLeft,
        input4 => ShiftLeft_to_BMux,
        sel    => ALUSrcB,
        output => BMux_to_ALUMain
    );

    ----------------------------------------------------------------------
    --
    --                   Extends, Shifts, and Concats
    --
    ----------------------------------------------------------------------
    ZeroExtend : entity work.zero_extend
    port map(
        input  => switches,
        output => ZeroEx_to_Memory
    );

    SignExtend : entity work.sign_extend
    port map(
        input  => IR_15_to_0,
        output => SignEx_to_ShiftLeft
    );

    ShiftLeftBMux : entity work.shift_left_2
    port map(
        input  => SignEx_to_ShiftLeft,
        output => ShiftLeft_to_BMux
    );

    ShiftLeftPCMux : entity work.shift_left_2
    generic map(
        WIDTH => 28
    )
    port map(
        input  => "00" & IR_25_to_0,
        output => ShiftLeft2_to_Concat
    );

    PCConcat : entity work.concat
    port map(
        input_lower => ShiftLeft2_to_Concat,
        input_upper => PCReg_to_CodeMux(31 downto 28),
        output      => Concat_to_PCMux
    );


    ---------------------------------------------------------------------
    --
    --                   Central Components
    -- 
    ---------------------------------------------------------------------
    Mem : entity work.Memory
    port map(
        baddr      => CodeMux_to_Memory,
        dataIn     => RegB_to_BMux,
        InPort0_in => ZeroEx_to_Memory,
        InPort1_in => ZeroEx_to_Memory,
        memRead    => MemRead,
        memWrite   => MemWrite,
        InPort0_en => not button0,
        InPort1_en => not button1,
        clk        => clk,
        rst        => rst,
        dataOut    => Memory_to_Reg,
        OutPort    => LEDs
    );

InstReg : entity work.Instruction_register
    port map(
        clk         => clk, 
        rst         => rst, 
        input       => Memory_to_Reg,
        out25_to_0  => IR_25_to_0, 
        out31_to_26 => IR_31_to_26,
        out25_to_21 => IR_25_to_21,
        out20_to_16 => IR_20_to_16,
        out15_to_11 => IR_15_to_11,
        out15_to_0  => IR_15_to_0
    );
    
    RegFile : entity work.register_file
    port map(
        clk         => clk, 
        rst         => rst,
        rd_addr0    => IR_25_to_21,
        rd_addr1    => IR_20_to_16,
        wr_addr     => IRMux1_to_RFReg,
        wr_en       => RegWrite,
        wr_data     => IRMux2_to_RFData,
        JumpAndLink => JumpAndLink,
        PC_4        => ALUOut_to_CodeMux,
        rd_data0    => Data1_to_RegA,
        rd_data1    => Data2_to_RegB
    );

    ALUCtrl : entity work.ALU_Control
    port map(
        HI_en     => RegHigh_en,
        LO_en     => RegLow_en,
        ALU_LO_HI => ALU_Low_High,
        IR_5to0   => IR_15_to_0(5 downto 0),
        IR_31to26  => IR_31_to_26,
        ALU_OP    => ALUOp,
        OPSelect  => ALUCtrl_to_ALUMain
    );

    ALU : entity work.ALU_Main
    port map(
        A => AMux_to_ALUMain,
        B => BMux_to_ALUMain,
        Shift_Amount => IR_15_to_0(10 downto 6), 
        OP_Select => ALUCtrl_to_ALUMain,
        Result_Low => ResultLow_to_RegLow, 
        Result_High => ResultHigh_to_RegHigh,
        Branch_Taken => BranchTaken
    );

    
end logic;