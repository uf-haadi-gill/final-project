library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend_tb is end entity;

architecture tb of sign_extend_tb is
    signal input: std_logic_vector(15 downto 0) := (others => '0');
    signal output : std_logic_vector(31 downto 0) := (others => '0');
    
begin
    con : entity work.sign_extend 
    port map(
        input  => input,
        output => output
    );

    process
    begin
        input <= x"1111";
        wait for 40 ns;
        assert(output = x"00001111") report "Error: Incorrect output" severity warning;

        input <= x"8888";
        wait for 40 ns;
        assert(output = x"FFFF8888") report "Error: Incorrect output" severity warning;

        wait;
    end process;

end tb; 