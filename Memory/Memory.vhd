----------------------------------------------------------------------------------------------------------------
--
--      IMPORTANT INFORMATION
--      > Reading from RAM takes 1 extra clock cycle (1 edge to read, result displayed by next falling edge)
--      > Data to OutPort will be sent on next rising edge after being set (registered output)
--
----------------------------------------------------------------------------------------------------------------





library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Memory is 
    port(
        baddr, dataIn, InPort0_in, InPort1_in                : in std_logic_vector(31 downto 0);
        memRead, memWrite, InPort0_en, InPort1_en, clk, rst  : in std_logic;
        dataOut, OutPort                                     : out std_logic_vector(31 downto 0)
    );
end Memory;

architecture logic of Memory is 

    signal SIG_data_out   : std_logic_vector(31 downto 0);-- := (others => '0');
    signal SIG_ram_out    : std_logic_vector(31 downto 0);-- := (others => '0');
    signal SIG_inPort_0   : std_logic_vector(31 downto 0);-- := (others => '0');
    signal SIG_inPort_1   : std_logic_vector(31 downto 0);-- := (others => '0');
    signal SIG_outPort_en : std_logic;-- := '0';
    signal SIG_ram_en     : std_logic;-- := '0';
    signal SIG_baddr_delay : std_logic_vector(31 downto 0);

begin
    Storage : entity work.RAM
    port map(
        address =>baddr(9 downto 2),-- 8 bit vector
        clock => clk,
        data => dataIn,
        wren => SIG_ram_en,
        q => SIG_ram_out
    );


    InputPort0 : entity work.reg
    port map(
        input => InPort0_in,
        clk => clk,
        rst => '0',
        enable => InPort0_en,
        output => SIG_inPort_0
    );

    
    InputPort1 : entity work.reg
    port map(
        input => InPort1_in,
        clk => clk,
        rst => '0',
        enable => InPort1_en,
        output => SIG_inPort_1
    );

    
    OutputPort : entity work.reg
    port map(
        input => dataIn,
        clk => clk,
        rst => '0',
        enable => SIG_outPort_en,
        output => OutPort
    );

    BaddrDelay : entity work.reg
    port map(
        input => baddr,
        clk => clk,
        rst => rst,
        enable => '1',
        output => SIG_baddr_delay
    );

    --SIG_ram_en <= '1' when ((memWrite = '1') and (not baddr = x"0000FFF8") and (not baddr = x"0000FFFC")) else
    --             '0';

    process( baddr, dataIn, memRead, memWrite, SIG_ram_out)--, rst)
    begin 

            dataOut <= (others => '0');
        -- if (rst = '1') then
        --     SIG_data_out <= (others => '0');
        --     SIG_outPort_en <= '0';
        --     SIG_ram_en <= '0';
            
        -- else--elsif (rising_edge(clk)) then
            -- reset enable signals 
            SIG_outPort_en <= '0';
            SIG_ram_en <= '0';

            -- check if one of the three ports 
            if (SIG_baddr_delay = x"0000FFF8") then
                dataOut <= SIG_inPort_0;

            elsif (SIG_baddr_delay = x"0000FFFC" and memRead = '1') then
                dataOut <= SIG_inPort_1;
                
            elsif (baddr = x"0000FFFC" and memWrite = '1') then 
                SIG_outPort_en <= '1';

            
            --     -- check if outport or inport 1
            --     if (memWrite = '1') then
            --         SIG_outPort_en <= '1';
            --     elsif (memRead = '1') then
            --         SIG_data_out <= SIG_inPort_1;
            --     end if;
            -- -- if none of the other cases, then update ram signals
            else  
                -------------------------------------------------------
                --
                --          Line below might cause delay....
                -- 
                --------------------------------------------------------
                dataOut <= SIG_ram_out;
                SIG_ram_en <= memWrite;
            end if;
        
        -- end if;
    end process;
    
    -- dataOut <= SIG_data_out;
            

end logic;
