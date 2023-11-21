library ieee;
use ieee.std_logic_1164.all;

entity reg is 
    generic(
        WIDTH : positive := 32
    );
    port(
        input            : in  std_logic_vector(WIDTH-1 downto 0);
        clk, rst, enable : in  std_logic;
        output           : out std_logic_vector(WIDTH-1 downto 0)
    );
end reg;


architecture logic of reg is 
begin 
    process(clk, rst)
    begin
        if (rst = '1') then 
            output <= (others => '0');
        elsif (rising_edge(clk) and enable = '1') then
            output <= input;
        end if;
    end process;
end logic;