library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concat_tb is end entity;

architecture tb of concat_tb is
    signal input_lower : std_logic_vector(27 downto 0) := (others => '0');
    signal input_upper : std_logic_vector(3 downto 0) := (others => '0');
    signal output : std_logic_vector(31 downto 0) := (others => '0');
    
begin
    con : entity work.concat 
    port map(
        input_lower => input_lower,
        input_upper => input_upper,
        output => output
    );

    process
    begin
        input_lower <= x"ABCDEF0";
        input_upper <= x"9";
        wait for 40 ns;
        assert(output = x"9ABCDEF0") report "Error: Incorrect output" severity warning;

        input_lower <= x"2345678";
        input_upper <= x"1";
        wait for 40 ns;
        assert(output = x"12345678") report "Error: Incorrect output" severity warning;

        wait;
    end process;

end tb;