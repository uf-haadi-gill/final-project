library ieee;
use ieee.std_logic_1164.all;


entity ALU_Control is 
    port(
        ALU_OP             : in std_logic_vector(1 downto 0);
        IR_5to0, IR_31to26 : in std_logic_vector(5 downto 0);
        HI_en, LO_en       : out std_logic;
        ALU_LO_HI          : out std_logic_vector(1 downto 0); 
        OPSelect           : out std_logic_vector(4 downto 0)
    );
end ALU_Control;

architecture logic of ALU_Control is
begin 
    process(ALU_OP, IR_5to0, IR_31to26)
    begin

        HI_en <= '0';
        LO_en <= '0';
        ALU_LO_HI <= "00";
        OPSelect <= "00000";

        case (ALU_OP) is
            when "00" =>
                OPSelect <= "00010";
            when "10" =>
                case (IR_5to0) is 
                when "100001" =>    -- add unsigned
                    OPSelect <= "00010";

                when "100011" =>    -- sub unsigned
                    OPSelect <= "00100";

                when "011000" =>    -- multiply
                    OPSelect <= "10110";

                when "011001" =>    -- multiply unsigned
                    OPSelect <= "10101";

                when "100100" =>    -- and
                    OPSelect <= "10111";

                when "100101" =>    -- or
                    OPSelect <= "11000";

                when "100110" =>    -- xor
                    OPSelect <= "11001";

                when "000000" =>    -- shift left logical
                    OPSelect <= "00110";

                when "000010" =>    -- shift right logical
                    OPSelect <= "00111";

                when "000011" =>    -- shift right arithmetic
                    OPSelect <= "01011";

                when "101010" =>    -- set less than signed
                    OPSelect <= "01110";

                when "101011" =>    -- set less than unsigned
                    OPSelect <= "00101";

                when "010000" =>    -- move from HI
                    OPSelect <= "00000";
                    HI_en <= '1';
                    ALU_LO_HI <= "10";

                when "010010" =>    -- move from LO
                    OPSelect <= "00000";
                    LO_en <= '1';
                    ALU_LO_HI <= "01";

                when "001000" =>    -- jump register
                    OPSelect <= "00000";

                when others =>
                    OPSelect <= "00000";

                end case;
            when others =>
                case(IR_31to26) is
                    when "001001" => -- add immediate
                        OPSelect <= "00010";

                    when "010000" => -- sub immediate
                        OPSelect <= "00100";

                    when "001100" => -- and immediate
                        OPSelect <= "10111";

                    when "001101" => -- or immediate
                        OPSelect <= "11000";

                    when "001110" => -- xor immediate
                        OPSelect <= "11001";

                    when "001010" => -- set if less than immediate
                        OPSelect <= "00101";
                    
                    when "001011" => -- set if less than unsigned immediate
                        OPSelect <= "01110";

                    when "000100" => -- branch if equal
                        OPSelect <= "11010";
                        
                    when "000101" => -- branch if not equal
                        OPSelect <= "11011";
                        
                    when "000110" => -- branch if less than or equal to zero
                        OPSelect <= "11101";
                        
                    when "000111" => -- branch if greater than zero
                        OPSelect <= "11111";
                        
                    when "000001" => -- branch if less than zero
                        OPSelect <= "11110";
                        
                    when "111111" => --branch if greater than or equal to zero
                        OPSelect <= "11100";

                    when others =>
                        OPSelect <= "00000";

                end case;
        end case;

    end process;

end logic;