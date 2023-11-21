library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left_2_tb is end entity;

architecture tb of shift_left_2_tb is
    signal input: std_logic_vector(31 downto 0) := (others => '0');
    signal output : std_logic_vector(31 downto 0) := (others => '0');
    
begin
    con : entity work.shift_left_2 
    port map(
        input  => input,
        output => output
    );

    process
    begin
        input <= x"08080808";
        wait for 40 ns;
        assert(output = x"20202020") report "Error: Incorrect output" severity warning;

        input <= x"11111111";
        wait for 40 ns;
        assert(output = x"44444444") report "Error: Incorrect output" severity warning;

        wait;
    end process;

end tb;