library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_register is
    port(
        clk, rst    : in std_logic;
        input       : in std_logic_vector(31 downto 0);
        out25_to_0  : out std_logic_vector(25 downto 0);
        out31_to_26 : out std_logic_vector(5 downto 0);
        out25_to_21 : out std_logic_vector(4 downto 0);
        out20_to_16 : out std_logic_vector(4 downto 0);
        out15_to_11 : out std_logic_vector(4 downto 0);
        out15_to_0  : out std_logic_vector(15 downto 0);
    );
end instruction_register;

architecture logic of instruction_register is

begin
    process(clk, rst)
    begin
        if (rst = '1') then
            out25_to_0  <= (others => '0');
            out31_to_26 <= (others => '0');
            out25_to_21 <= (others => '0');
            out20_to_16 <= (others => '0');
            out15_to_11 <= (others => '0');
            out15_to_0  <= (others => '0');
        elsif (rising_edge(clk)) then
            out25_to_0   <= input(25 downto 0);
            out31_to_26  <= input(31 downto 26);
            out25_to_21  <= input(25 downto 21);
            out20_to_16  <= input(20 downto 16);
            out15_to_11  <= input(15 downto 11);
            out15_to_0   <= input(15 downto 0);
        end if;
end logic;
