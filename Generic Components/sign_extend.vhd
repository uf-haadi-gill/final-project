library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
    port(
        input        : in std_logic_vector(15 downto 0);
        check_signed : in std_logic;
        output       : out std_logic_vector(31 downto 0)
    );
end sign_extend;

architecture logic of sign_extend is
begin
    output <= "1111111111111111" & input when input(15) = '1' and check_signed = '1' else
              "0000000000000000" & input;
end logic;