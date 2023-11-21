library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4to1_tb is end entity;

architecture tb of mux4to1_tb is
    signal input1 : std_logic_vector(31 downto 0) := (others => '0');
    signal input2 : std_logic_vector(31 downto 0) := (others => '0');
    signal input3 : std_logic_vector(31 downto 0) := (others => '0');
    signal input4 : std_logic_vector(31 downto 0) := (others => '0');
    signal sel : std_logic_vector(1 downto 0) := "00";
    signal output : std_logic_vector(31 downto 0) := (others => '0');
    
begin
    con : entity work.mux4to1 
    port map(
        input1 => input1,
        input2 => input2,
        input3 => input3,
        input4 => input4,
        sel => sel,
        output => output
    );

    process
    begin
        input1 <= x"11111111";
        input2 <= x"22222222";
        input3 <= x"33333333";
        input4 <= x"44444444";
        sel <= "00";
        wait for 40 ns;
        assert(output = x"11111111") report "Error: Incorrect output" severity warning;

        input1 <= x"11111111";
        input2 <= x"22222222";
        input3 <= x"33333333";
        input4 <= x"44444444";
        sel <= "01";
        wait for 40 ns;
        assert(output = x"22222222") report "Error: Incorrect output" severity warning;

        
        input1 <= x"11111111";
        input2 <= x"22222222";
        input3 <= x"33333333";
        input4 <= x"44444444";
        sel <= "10";
        wait for 40 ns;
        assert(output = x"33333333") report "Error: Incorrect output" severity warning;

        
        input1 <= x"11111111";
        input2 <= x"22222222";
        input3 <= x"33333333";
        input4 <= x"44444444";
        sel <= "11";
        wait for 40 ns;
        assert(output = x"44444444") report "Error: Incorrect output" severity warning;

        wait;
    end process;

end tb;