library ieee;
use ieee.std_logic_1164.all;


entity mux2to1 is 
    generic(
        WIDTH : positive := 32;
    );
    port(
        input1 : in std_logic_vector(WIDTH-1 downto 0);
        input2 : in std_logic_vector(WIDTH-1 downto 0);
        sel    : in std_logic;
        output : out std_logic_vector(WIDTH-1 downto 0)
    );
end mux2to1;


architecture logic of mux2to1 is
begin
    output <= input1 when sel = '0' else input2;
end logic;