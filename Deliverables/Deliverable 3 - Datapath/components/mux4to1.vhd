library ieee;
use ieee.std_logic_1164.all;


entity mux4to1 is 
    generic(
        WIDTH : positive := 32
    );
    port(
        input1 : in std_logic_vector(WIDTH-1 downto 0);
        input2 : in std_logic_vector(WIDTH-1 downto 0);
        input3 : in std_logic_vector(WIDTH-1 downto 0);
        input4 : in std_logic_vector(WIDTH-1 downto 0);
        sel    : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
    );
end mux4to1;


architecture logic of mux4to1 is
begin
    output <= input1 when sel = "00" else 
              input2 when sel = "01" else
              input3 when sel = "10" else
              input4;
end logic;