library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concat is
    port(
        input_lower : in std_logic_vector(27 downto 0);
        input_upper : in std_logic_vector(3 downto 0);
        output     : out std_logic_vector(31 downto 0)
    );
end concat;

architecture logic of concat is 
begin 
    output <= input_upper & input_lower;
end logic;