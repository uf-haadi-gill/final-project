-------------------------------------------------------
--  File: ALU_Main.vhd
--
--  To Do:
--      > Rename the input and output values 
--      > Make the architecture
--
--  Inputs:
--      > A            (32 bit vector)
--      > B            (32 bit vector)
--      > Shift_Amount (IR[10-6], 5 bit vector)
--      > OP_Select    (5 bit vector)
--
--  Outputs:
--      > Result_Low       (32 bit vector)
--      > Result_High      (32 bit vector)
--      > Branch_Taken     (1 bit logic)
--
--
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all;


entity ALU_Main is
    port(
        A, B      : in std_logic_vector(31 downto 0);
        Shift_Amount, OP_Select : in std_logic_vector(4 downto 0);

        Result_Low, Result_High : out std_logic_vector(31 downto 0);
        Branch_Taken            : out std_logic
    );
end ALU_Main;

architecture logic of ALU_Main is
    ----------------------------------------------------------------
    --
    --              OP Code Constant Declaration
    --
    ----------------------------------------------------------------
    -- Directly output the value of A
    constant OutputA      : std_logic_vector(4 downto 0) := "00000";
    -- Directly output the value of B
    constant OutputB      : std_logic_vector(4 downto 0) := "00001";
    -- Add A and B, treat as unsigned numbers
    constant AddUnsigned  : std_logic_vector(4 downto 0) := "00010";
    -- Add A and B, treat as signed numbers
    constant AddSigned    : std_logic_vector(4 downto 0) := "00011";
    -- Subtract B from A, i.e., A - B
    constant SubtractAB   : std_logic_vector(4 downto 0) := "00100";
    -- Subtract A from B, i.e., B - A
    constant ALTBSigned   : std_logic_vector(4 downto 0) := "00101";
    -- Logical Shift Left, A
    constant LSLA         : std_logic_vector(4 downto 0) := "00110";
    -- Logical Shift Right, A
    constant LSRA         : std_logic_vector(4 downto 0) := "00111";
    -- Logical Shift Left, B
    constant LSLB         : std_logic_vector(4 downto 0) := "01000";
    -- Logical Shift Right, B
    constant LSRB         : std_logic_vector(4 downto 0) := "01001";
    -- Arithmetic Shift Left, A
    constant ASLA         : std_logic_vector(4 downto 0) := "01010";
    -- Arithmetic Shift Right, A
    constant ASRA         : std_logic_vector(4 downto 0) := "01011";
    -- Arithmetic Shift Left, B
    constant ASLB         : std_logic_vector(4 downto 0) := "01100";
    -- Arithmetic Shift Right, B
    constant ASRB         : std_logic_vector(4 downto 0) := "01101";
    -- Check if A is less than B, i.e., A < B
    constant ALTB         : std_logic_vector(4 downto 0) := "01110";
    -- Check if B is less than A, i.e., B < A
    constant BLTA         : std_logic_vector(4 downto 0) := "01111";
    -- Check if A is equal to B, i.e., A = B
    constant AEQB         : std_logic_vector(4 downto 0) := "10000";
    -- One's Complement, A
    constant OneCompA     : std_logic_vector(4 downto 0) := "10001";
    -- One's Complement, B
    constant OneCompB     : std_logic_vector(4 downto 0) := "10010";
    -- Two's Complement, A
    constant TwoCompA     : std_logic_vector(4 downto 0) := "10011";
    -- Two's Complement, B
    constant AlwaysBranch     : std_logic_vector(4 downto 0) := "10100";
    -- Multiply A and B, treat as unsigned
    constant MultUnsigned : std_logic_vector(4 downto 0) := "10101";
    -- Multiply A and B, tread as signed
    constant MultSigned   : std_logic_vector(4 downto 0) := "10110";
    -- Bitwise AND operation of A and B
    constant AANDB        : std_logic_vector(4 downto 0) := "10111";
    -- Bitwise OR operation of A and B
    constant AORB         : std_logic_vector(4 downto 0) := "11000";
    -- Bitwise XOR operation of A and B
    constant AXORB        : std_logic_vector(4 downto 0) := "11001";
    -- Bitwise NOR operation of A and B
    constant BEQ        : std_logic_vector(4 downto 0) := "11010";
    -- Bitwise XNOR operation of A and B
    constant BNEQ       : std_logic_vector(4 downto 0) := "11011";
    -- Set branch taken if A is less than or equal to B
    constant BGEZ         : std_logic_vector(4 downto 0) := "11100";
    -- Set branch taken if A is less than or equal to 0
    constant BLEZ         : std_logic_vector(4 downto 0) := "11101";
    -- Set branch taken if A is greater than B
    constant BLTZ         : std_logic_vector(4 downto 0) := "11110";
    -- Set branch taken if A is greater than 0
    constant BGZ         : std_logic_vector(4 downto 0) := "11111";


    signal SIG_Result_Low, SIG_Result_High : std_logic_vector(31 downto 0);-- := (others => '0');
    signal SIG_Branch : std_logic;-- := '0'; 
    
    begin
        -- always assign outputs to signal values
        Result_Low   <= SIG_Result_Low;
        Result_High  <= SIG_Result_High;
        Branch_Taken <= SIG_branch;
        
        -- process statement to run when any inputs change
    process (A, B, Shift_Amount, OP_Select)
    variable VAR_Mult_Result                 : std_logic_vector(63 downto 0) := (others => '0');
    begin
        -- Reset all signal values, only overwrite if needed 
        SIG_Result_Low  <= (others => '0');
        SIG_Result_High <= (others => '0');
        SIG_Branch      <= '0';

        -- case statement based on OP
        -- OP Code Table provided above

        case (OP_Select) is
            when OutputA      =>
                -- STATUS: FUNCTIONAL
                SIG_Result_Low <= A;

            when OutputB      =>
                -- STATUS: FUNCTIONAL
                SIG_Result_Low <= B;

            when AddUnsigned  =>
                -- STATUS: FUNCTIONAL
                SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));

            when AddSigned    =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= std_logic_vector(signed(A) + signed(B));

            when SubtractAB   =>
                -- STATUS : FUNCTIONAL
                SIG_Result_Low <= std_logic_vector(unsigned(A) - unsigned(B));

            when ALTBSigned   =>
                if signed(A) < signed(B) then 
                    SIG_Result_Low <= x"00000001";
                else 
                    SIG_Result_Low <= x"00000000";
                end if;

            when LSRA         =>
                -- STATUS : UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_RIGHT(unsigned(B), to_integer(unsigned(Shift_Amount))));

            when LSLA         =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_LEFT(unsigned(B), to_integer(unsigned(Shift_Amount))));

            when LSRB         =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_RIGHT(unsigned(B), to_integer(unsigned(Shift_Amount))));

            when LSLB         =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_LEFT(unsigned(B), to_integer(unsigned(Shift_Amount))));

            when ASLA         =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_LEFT(signed(B), to_integer(unsigned(Shift_Amount))));

            when ASRA         =>
                -- STATUS : UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_RIGHT(signed(B), to_integer(unsigned(Shift_Amount))));

            when ASLB         =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_LEFT(signed(B), to_integer(unsigned(Shift_Amount))));

            when ASRB         =>
                -- STATUS : UNTESTED
                SIG_Result_Low <= std_logic_vector(SHIFT_RIGHT(signed(B), to_integer(unsigned(Shift_Amount))));

            when ALTB         =>
                -- STATUS: UNTESTED
                if A < B then 
                    SIG_Result_Low <= x"00000001";
                else 
                    SIG_Result_Low <= x"00000000";
                end if;

            when BLTA         =>
                -- STATUS: UNTESTED
                if B < A then 
                    SIG_Result_Low <= x"00000001";
                else 
                    SIG_Result_Low <= x"00000000";
                end if;

            when AEQB         =>
                -- STATUS: UNTESTED
                if A = B then 
                    SIG_Result_Low <= x"00000001";
                else 
                    SIG_Result_Low <= x"00000000";
                end if;

            when OneCompA     =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= not A;

            when OneCompB     =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= not B;

            when TwoCompA     =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= (not A) + 1;

            when AlwaysBranch     =>
                -- STATUS : UNTESTED
                SIG_Branch <= '1';
                -- SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));

            when MultUnsigned =>
                -- STATUS: UNTESTED
                VAR_Mult_Result := std_logic_vector(unsigned(A) * unsigned(B));
                SIG_Result_High <= VAR_Mult_Result(63 downto 32);
                SIG_Result_Low  <= VAR_Mult_Result(31 downto 0);

            when MultSigned   =>
                -- STATUS: UNTESTED
                VAR_Mult_Result := std_logic_vector(signed(A) * signed(B));
                SIG_Result_High <= VAR_Mult_Result(63 downto 32);
                SIG_Result_Low  <= VAR_Mult_Result(31 downto 0);

            when AANDB        =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= A and B;

            when AORB         =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= A or B;

            when AXORB        =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= A xor B;

            when BEQ        =>
            -- STATUS: UNTESTED
            if A = B then 
                SIG_Branch <= '1';
            else 
                SIG_Branch <= '0';
            end if;
            -- SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));

            when BNEQ       =>
            -- STATUS: UNTESTED
            if A = B then 
                SIG_Branch <= '0';
            else 
                SIG_Branch <= '1';
            end if;
            -- SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));

            when BGEZ =>
                -- STATUS: UNTESTED
                if signed(A) > 0 or signed(A) = 0 then 
                    SIG_Branch <= '1';
                else 
                    SIG_Branch <= '0';
                end if;
                -- SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));

            when BLEZ =>
                -- STATUS: UNTESTED
                if signed(A) < 0 or signed(A) = 0 then 
                    SIG_Branch <= '1';
                else 
                    SIG_Branch <= '0';
                end if;
                -- SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));

            when BLTZ =>
                -- STATUS: UNTESTED
                if signed(A) < 0 then 
                    SIG_Branch <= '1';
                else 
                    SIG_Branch <= '0';
                end if;
                -- SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));

            when BGZ =>
                -- STATUS: UNTESTED
                if signed(A) > 0 then
                    SIG_Branch <= '1';
                else 
                    SIG_Branch <= '0';
                end if;
                -- SIG_Result_Low <= std_logic_vector(unsigned(A) + unsigned(B));
            
            when others       =>
                -- STATUS: UNTESTED
                SIG_Result_Low <= (others => '0');


        end case;

    end process;

end logic;