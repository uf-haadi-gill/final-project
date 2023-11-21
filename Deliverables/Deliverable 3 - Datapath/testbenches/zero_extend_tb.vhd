library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zero_extend_tb is end entity;

architecture tb of zero_extend_tb is
    signal input: std_logic_vector(9 downto 0) := (others => '0');
    signal output : std_logic_vector(31 downto 0) := (others => '0');
    
begin
    con : entity work.zero_extend 
    port map(
        input  => input,
        output => output
    );

    process
    begin
        input <= "1111111111";
        wait for 40 ns;
        assert(output = x"000003FF") report "Error: Incorrect output" severity warning;

        input <= "0000000000";
        wait for 40 ns;
        assert(output = x"00000000") report "Error: Incorrect output" severity warning;

        wait;
    end process;

end tb; 