library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left_2 is
    generic(
        WIDTH : positive := 32
    );
    port(
        input : in std_logic_vector(WIDTH-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
    );
end shift_left_2;

architecture logic of shift_left_2 is
begin 
    output <= std_logic_vector(shift_left(unsigned(input), 2));
end logic;