library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity toppiestLevel_tb is end toppiestLevel_tb;

architecture logic of toppiestLevel_tb is

    signal rst : std_logic := '0';
    signal switch_input : std_logic_vector(9 downto 0) := (others => '0');
    signal SSG0, SSG1, SSG2 : std_logic_vector(6 downto 0);

    signal buttons : std_logic_vector(1 downto 0) := "11";
    signal clk : std_logic := '0';
    -- signal r7 : std_logic_vector(31 downto 0);
    -- signal stateOut : std_logic_vector(4 downto 0);
    -- signal pc_mux_output : std_logic_vector(31 downto 0);
    -- signal memory_output : std_logic_vector(31 downto 0);
    -- signal op_code : std_logic_vector(5 downto 0);
    -- signal op_select : std_logic_vector(4 downto 0);
    -- signal shift_amount : std_logic_vector(4 downto 0);
    

begin

TL : entity work.toppiestLevel
    port map(
        SSG0 => SSG0, 
        SSG1 => SSG1, 
        SSG2 => SSG2,
        input => switch_input,
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

        -- set inport 0 value
        switch_input <= "0110000000";
        buttons <= "10";

        clk <= '1';
        
        wait for 40 ns;

        clk <= '0';

        wait for 40 ns;
        

        switch_input <= "0000011000";
        buttons <= "01";
        
        clk <= '1';
        
        wait for 40 ns;

        clk <= '0';

        wait for 40 ns;

        switch_input <= "0000000000";
        buttons <= "11";
        
        clk <= '1';
        
        wait for 40 ns;

        clk <= '0';

        wait for 40 ns;

        for k in 0 to 1000 loop
            clk <= '1';

            wait for 40 ns;

            clk <= '0';

            wait for 40 ns;
        end loop;

    end process;

end logic ; -- logic