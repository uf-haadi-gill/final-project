library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_tb is end entity;

architecture tb of reg_tb is
    signal input1: std_logic_vector(31 downto 0) := (others => '0');
    signal clk, rst, enable : std_logic := '0';
    signal output : std_logic_vector(31 downto 0) := (others => '0');
    
begin
    con : entity work.reg 
    port map(
        input => input1,
        clk => clk,
        rst => rst, 
        enable => enable,
        output => output
    );

    
    clk <= (not clk) after 10 ns;


    process
    begin
        rst <= '1';
        wait for 40 ns;
        assert(output = x"00000000") report "Error: Incorrect output" severity warning;

        rst <= '0';
        input1 <= x"11111111";
        wait for 40 ns;
        assert(output = x"00000000") report "Error: Incorrect output" severity warning;

        enable <= '1';
        wait for 40 ns;
        assert(output = x"11111111") report "Error: Incorrect output" severity warning;


        input1 <= x"12345678";
        wait for 40 ns;
        assert(output = x"12345678") report "Error: Incorrect output" severity warning;

        wait;
    end process;

end tb;
