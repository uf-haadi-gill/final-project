library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory_TB is
end Memory_TB;

architecture TB of Memory_TB is
    signal done      : std_logic := '0';
    signal clk       : std_logic := '0';
    signal rst       : std_logic := '1';
    signal Baddr   : std_logic_vector(31 downto 0) := (others => '0');
    signal DataOut      : std_logic_vector(31 downto 0) := (others => '0');
    signal DataIn      : std_logic_vector(31 downto 0) := (others => '0');
    signal MemRead   : std_logic := '0';
    signal MemWrite  : std_logic := '0';
    signal InPort0_en : std_logic := '0';
    signal InPort1_en : std_logic := '0';
    signal InPort0, InPort1    : std_logic_vector(31 downto 0) := (others => '0');
    signal OutPort   : std_logic_vector(31 downto 0) := (others => '0');
	 
begin --TB

    -- 50 MHz clk
    clk <= (not clk) and (not done) after 10 ns;

    UUT: entity work.Memory
        port map (
            clk       => clk,
            rst       => rst,
            Baddr   => Baddr,
            DataOut      => DataOut,
            DataIn      => DataIn,
            MemRead   => MemRead,
            MemWrite  => MemWrite,
            InPort1_en => InPort1_en,
            InPort0_en => InPort0_en,
            InPort0_in    => InPort0,
			InPort1_in    => InPort1,
            OutPort   => OutPort
        );

    process
    begin

        done <= '0';
        rst   <= '1';
        wait for 20 ns;
        rst <= '0';


        -- Write 0x0A0A0A0A to byte address 0x00000000
        wait for 20 ns;
        MemWrite <= '1';
        DataIn <= x"0A0A0A0A";
        Baddr <= x"00000000";
        wait for 20 ns;
        MemWrite <= '0';
		  
        report "Write 0x0A0A0A0A to byte address 0x00000000 here." severity note;

        -- Write 0xF0F0F0F0 to byte address 0x00000004
        MemWrite <= '1';
        DataIn <= x"F0F0F0F0";
        Baddr <= x"00000004";
        wait for 20 ns;
        MemWrite <= '0';

        report "Write 0xF0F0F0F0 to byte address 0x00000004 here." severity note;

        --wait until rising_edge(clk);

        -- Read from byte address 0x00000000 (should show 0x0A0A0A0A on read data output)
        MemRead <= '1';
        Baddr <= x"00000000";
        wait for 20 ns;
        MemRead <= '0';
        assert(DataOut = x"0A0A0A0A") report "Read from byte address 0x00000000 incorrect (should show 0x0A0A0A0A)" severity warning;
        report "Read from byte address 0x00000000 here." severity note;

        -- Read from byte address 0x00000001 (should show 0x0A0A0A0A on read data output)
        MemRead <= '1';
        Baddr <= x"00000001";
        wait for 20 ns;
        MemRead <= '0';
        assert(DataOut = x"0A0A0A0A") report "Read from byte address 0x00000001 incorrect (should show 0x0A0A0A0A)" severity warning;
        report "Read from byte address 0x00000001 here." severity note;

        -- Read from byte address 0x00000004 (should show 0xF0F0F0F0 on read data output)
        MemRead <= '1';
        Baddr <= x"00000004";
        wait for 20 ns;
        MemRead <= '0';
        assert(DataOut = x"F0F0F0F0") report "Read from byte address 0x00000004 incorrect (should show 0xF0F0F0F0)" severity warning;
        report "Read from byte address 0x00000004 here." severity note;

        -- Read from byte address 0x00000005 (should show 0xF0F0F0F0 on read data output)
        MemRead <= '1';
        Baddr <= x"00000005";
        wait for 20 ns;
        MemRead <= '0';
        assert(DataOut = x"F0F0F0F0") report "Read from byte address 0x00000005 incorrect (should show 0xF0F0F0F0)" severity warning;
        report "Read from byte address 0x00000005 here." severity note;

        -- Write 0x00001111 to the outport (should see value appear on outport)
        MemWrite <= '1';
        DataIn <= x"00001111";
        Baddr <= x"0000FFFC";
        wait for 20 ns;
        MemWrite <= '0';
        assert(OutPort = x"00001111") report "Write data to outport incorrect (should show 0x00001111)" severity warning;
        report "Write 0x00001111 to the outport here." severity note;

        -- Load 0x00010000 into inport 0
        InPort0 <= x"00010000";
        InPort0_en <= '1';
        wait for 20 ns;
        InPort0_en <= '0';
		  
        report "Load 0x00010000 into inport 0 here." severity note;

        -- Load 0x00000001 into inport 1
        InPort1 <= x"00000001";
        InPort1_en <= '1';
        wait for 20 ns;
        InPort1_en <= '0';
		  
        report "Load 0x00000001 into inport 1 here." severity note;

        -- Read from inport 0 (should show 0x00010000 on read data output)
        wait until rising_edge(clk);
        MemRead <= '1';
        Baddr <= x"0000FFF8";
        wait for 20 ns;
        MemRead <= '0';
        assert(DataOut = x"00010000") report "Read from inport 0 incorrect (should show 0x00010000)" severity warning;
        report "Read from inport 0 happened here." severity note;

        -- Read from inport 1 (should show 0x00000001 on read data output)
        wait until rising_edge(clk);
        MemRead <= '1';
        Baddr <= x"0000FFFC";
        wait for 20 ns;
        MemRead <= '0';
        assert(DataOut = x"00000001") report "Read from inport 1 incorrect (should show 0x00000001)" severity warning;
        report "Read from inport 1 happened here." severity note;

        wait for 15 ns;
        done <= '1';
        report "DONE!!!!!!" severity note;
        wait;
    end process;
end TB;