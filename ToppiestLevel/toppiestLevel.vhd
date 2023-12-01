library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity toppiestLevel is 
    port(
        clk, button0, button1 : in std_logic;
        input : in std_logic_vector(9 downto 0);
        SSG0, SSG1, SSG2 : out std_logic_vector(6 downto 0)
    );
end toppiestLevel;

architecture logic of toppiestLevel is
    signal num0, num1, num2 : std_logic_vector(3 downto 0);
    signal LEDOut : std_logic_vector(31 downto 0);
    signal rst : std_logic;
begin

    rst <= input(9);

    num0 <= LEDOut(3 downto 0);
    num1 <= LEDOut(7 downto 4);
    num2 <= LEDOut(11 downto 8);

    tL : entity work.topLevel
    port map(
        LEDs => LEDOut,
        Switches => input,
        button0 => button0, 
        button1 => button1, 
        clk => clk, 
        rst => rst
    );

    dC0 : entity work.decoder7seg
    port map (
        input => num0,
        output => SSG0
    );
    
    dC1 : entity work.decoder7seg
    port map (
        input => num1,
        output => SSG1
    );
    
    dC2 : entity work.decoder7seg
    port map (
        input => num2,
        output => SSG2
    );

end logic;