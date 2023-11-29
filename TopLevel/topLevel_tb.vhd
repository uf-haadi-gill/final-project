library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity topLevel_tb is end topLevel_tb;

architecture logic of topLevel_tb is

    signal rst : std_logic := '0';
    signal switch_input : std_logic_vector(9 downto 0) := (others => '0');
    signal output : std_logic_vector(31 downto 0);
    signal buttons : std_logic_vector(1 downto 0) := "00";
    signal clk : std_logic := '0';
    -- signal r7 : std_logic_vector(31 downto 0);
    -- signal stateOut : std_logic_vector(4 downto 0);
    -- signal pc_mux_output : std_logic_vector(31 downto 0);
    -- signal memory_output : std_logic_vector(31 downto 0);
    -- signal op_code : std_logic_vector(5 downto 0);
    -- signal op_select : std_logic_vector(4 downto 0);
    -- signal shift_amount : std_logic_vector(4 downto 0);
    

begin

TL : entity work.topLevel
    port map(
        LEDs => output,
        Switches => switch_input,
        button0 => buttons(0),
        button1 => buttons(1),
        clk => clk,
        rst => rst
    );

    process
    begin
        rst <= '1';

        clk <= '1';

        wait for 40 ns;

        clk <= '0';

        wait for 40 ns;

        rst <= '0';

        for k in 0 to 400 loop
            clk <= '1';

            wait for 40 ns;

            clk <= '0';

            wait for 40 ns;
        end loop;

    end process;

end logic ; -- logic