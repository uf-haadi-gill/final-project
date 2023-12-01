library ieee;
use ieee.std_logic_1164.all;

entity decoder7seg is
    port (
        input  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(6 downto 0));
end decoder7seg;

architecture BHV of decoder7seg is
	signal waiter : std_logic_vector(6 downto 0);
begin
			
	waiter <=   "1111110" when input = "0000" else
				"0110000" when input = "0001" else
				"1101101" when input = "0010" else
				"1111001" when input = "0011" else
				"0110011" when input = "0100" else
				"1011011" when input = "0101" else
				"1011111" when input = "0110" else
				"1110000" when input = "0111" else
				"1111111" when input = "1000" else
				"1111011" when input = "1001" else
				"1110111" when input = "1010" else
				"0011111" when input = "1011" else
				"1001110" when input = "1100" else
				"0111101" when input = "1101" else
				"1001111" when input = "1110" else
				"1000111" when input = "1111" else
				"0000000";
	
	output(6) <= not waiter(0);
	output(5) <= not waiter(1);
	output(4) <= not waiter(2);
	output(3) <= not waiter(3);
	output(2) <= not waiter(4);
	output(1) <= not waiter(5);
	output(0) <= not waiter(6);
end BHV;
