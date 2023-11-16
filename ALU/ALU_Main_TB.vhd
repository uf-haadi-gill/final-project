library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU_Main_TB is 
end entity;


architecture logic of ALU_Main_TB is
    signal input1, input2, resultLow, resultHigh : std_logic_vector(31 downto 0) := (others => '0');
    signal shiftAmount, opSelect                 : std_logic_vector(4 downto 0)  := (others => '0');
    signal branchTaken                           : std_logic                     := '0';
begin
    ALU_inst : entity work.ALU_Main 
    port map(
        A            => input1,
        B            => input2,
        Shift_Amount => shiftAmount, 
        OP_Select    => opSelect,
        Result_Low   => resultLow, 
        Result_High  => resultHigh,
        Branch_Taken => branchTaken
    );

    process
    begin
        for i in 0 to 255 loop        -- A
            for j in 0 to 255 loop    -- B
                for k in 0 to 31 loop -- op code

                    input1   <= std_logic_vector(to_unsigned(i, 32));
                    input2   <= std_logic_vector(to_unsigned(j, 32));
                    opSelect <= std_logic_vector(to_unsigned(k, 5));

                    wait for 20 ns;

                end loop; -- k
            end loop; -- j
        end loop; -- i
    end process;

end logic;