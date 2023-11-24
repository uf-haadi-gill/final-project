library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity controller is
    port(
        
        IR_31_to_26 : in std_logic(5 downto 0);
        clk
when => rst    : in std_logic;

        
        PCWriteCond : out  std_logic;
        PCWrite     : out  std_logic;
        IorD        : out  std_logic;
        MemRead     : out  std_logic;
        MemWrite    : out  std_logic;
        MemToReg    : out  std_logic;
        IRWrite     : out  std_logic;
        JumpAndLink : out  std_logic;
        IsSigned    : out  std_logic;
        PCSource    : out  std_logic_vector(1 downto 0);
        ALUOp       : out  std_logic_vector(1 downto 0);
        ALUSrcA     : out  std_logic;
        ALUSrcB     : out  std_logic_vector(1 downto 0);
        RegWrite    : out  std_logic;
        RegDst      : out  std_logic

    );
end controller;


architecture logic of controller is
    
    type state is { fetch_1, fetch_2, jump,    decode,  fake -- all take 1 clock cycle
                    load_1,  load_2,  load_3,  load_4,       -- load word is 4
                    store_1, store_2,                        -- all other are 2 clock cycles
                    add_1,   add_2,   addi_1,  addi_2,       -- add, add immediate
                    sub_1,   sub_2,   subi_1,  subi_2,       -- sub, sub immediate
                    mult_1,  mult_2,  multU_1, multU_2,      -- multiply, multiply unsigned
                    and_1,   and_2,   andi_1,  andi_2,       -- and, and immediate
                    or_1,    or_2,    ori_1,   ori_2,        -- or, or immediate
                    xor_1,   xor_2,   xori_1,  xori_2,       -- xor, xor immediate
                    srl_1,   srl_2,   sll_1,   sll_2,        -- shift logical right, shift logical left
                    sra_1,   sra_2,                          -- shift arithmetic right 
                    slt_1,   slt_2,   slti_1,  slti_2,       -- set less than, set less than immediate
                    sltu_1,  sltu_2,  sltui_1, sltui_2,      -- set less than unsigned, set less than unsigned immediate
                    mfhi_1,  mfhi_2,  mflo_1,  mflo_2,       -- move from high, move from low
                    beq_1,   beq_2,   bneq_1,  bneq_2,       -- branch if equal, branch if not equal
                    bltez_1, bltez_2, bgz_1,   bgz_2,        -- branch if less than or equal to zero, branch if greater than zero
                    bltz_1,  bltz_2,  jal_1,   jal_2,        -- branch if less than zero, jump and link
                    jr_1,    jr_2                            -- jump register
                  };
    -- fake, jump, decode
    -- fetch, fetch wait
    -- load word has 4
    -- everything else has 2 s states 
    --make a bunch of constants to map all the instructions
    
    signal curr_state, next_state : state := fetch_instruction;
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            curr_state <= fetch_instruction;
        elsif (rising_edge(clk)) then
            curr_state <= next_state;
        end if;
    end process;

    process(curr_state)
    begin

        -- set all outputs to 0 by default, then set what is needed
        
        PCWriteCond <= '0';
        PCWrite     <= '0';
        IorD        <= '0';
        MemRead     <= '0';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '0';
        JumpAndLink <= '0';
        IsSigned    <= '0';
        PCSource    <= (others => '0');
        ALUOp       <= (others => '0');
        ALUSrcA     <= '0';
        ALUSrcB     <= (others => '0');
        RegWrite    <= '0';
        RegDst      <= '0';

        case(curr_state) is

            when fetch_1 =>
                next_state <= fetch_1;

            when fetch_2 
                next_state <= decode;

            when jump 
                next_state <= fetch_1;

            when decode 
                next_state <= ;

            when fake 
                next_state <= fetch_1;

            when load_1 
                next_state <= load_2;

            when load_2 
                next_state <= load_3;

            when load_3 
                next_state <= load_4;

            when load_4 
                next_state <= fetch_1;

            when store_1 
                next_state <= store_2;

            when store_2 
                next_state <= fetch_1;

            when add_1 
                next_state <= add_2;

            when add_2 
                next_state <= fetch_1;

            when addu_1 
                next_state <= addu_2;

            when addu_2 
                next_state <= fetch_1;

            when sub_1 
                next_state <= sub_2;

            when sub_2 
                next_state <= fetch_1;

            when subu_1 
                next_state <= subu_2;

            when subu_2 
                next_state <= fetch_1;

            when mult_1 
                next_state <= mult_2;

            when mult_2 
                next_state <= fetch_1;

            when multU_1 
                next_state <= multU_2;

            when multU_2  
                next_state <= fetch_1;

            when and_1 
                next_state <= and_2;

            when and_2  
                next_state <= fetch_1;

            when andi_1 
                next_state <= andi_2;

            when andi_2  
                next_state <= fetch_1;

            when or_1 
                next_state <= or_2;

            when or_2  
                next_state <= fetch_1;

            when ori_1 
                next_state <= ori_2;

            when ori_2  
                next_state <= fetch_1;

            when xor_1 
                next_state <= xor_2;

            when xor_2 
                next_state <= fetch_1;

            when xori_1 
                next_state <= xori_2;

            when xori_2 
                next_state <= fetch_1;

            when srl_1 
                next_state <= srl_2;

            when srl_2 
                next_state <= fetch_1;

            when sll_1 
                next_state <= sll_2;

            when sll_2 
                next_state <= fetch_1;

            when sra_1 
                next_state <= sra_2;

            when sra_2 
                next_state <= fetch_1;

            when slt_1 
                next_state <= slt_2;

            when slt_2 
                next_state <= fetch_1;

            when slti_1 
                next_state <= slti_2;

            when slti_2 
                next_state <= fetch_1;

            when sltu_1 
                next_state <= sltu_2;

            when sltu_2 
                next_state <= fetch_1;

            when sltui_1 
                next_state <= sltui_2;

            when sltui_2 
                next_state <= fetch_1;

            when mfhi_1 
                next_state <= mfhi_2;

            when mfhi_2 
                next_state <= fetch_1;

            when mflo_1 
                next_state <= mflo_2;

            when mflo_2 
                next_state <= fetch_1;

            when beq_1 
                next_state <= beq_2;

            when beq_2 
                next_state <= fetch_1;

            when bneq_1 
                next_state <= bneq_2;

            when bneq_2 
                next_state <= fetch_1;

            when bltez_1 
                next_state <= bltez_2;

            when bltez_2 
                next_state <= fetch_1;

            when bgz_1 
                next_state <= bgz_2;

            when bgz_2 
                next_state <= fetch_1;

            when bltz_1 
                next_state <= bltz_2;

            when bltz_2 
                next_state <= fetch_1;

            when jal_1 
                next_state <= jal_2;

            when jal_2 
                next_state <= fetch_1;

            when jr_1 
                next_state <= jr_2;

            when jr_2 
                next_state <= fetch_1;

            when others =>
                next_state <= fetch_1;

            end case;



    end process;

end logic ; -- logic
