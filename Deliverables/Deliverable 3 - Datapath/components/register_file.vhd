library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
    port(
        clk, rst    : in  std_logic;

        rd_addr0    : in  std_logic_vector(4 downto 0);  -- read register 1
        rd_addr1    : in  std_logic_vector(4 downto 0);  -- read register 2

        wr_addr     : in  std_logic_vector(4 downto 0);  -- write register
        wr_en       : in  std_logic;                     -- write enable
        wr_data     : in  std_logic_vector(31 downto 0); -- data to be written

        JumpAndLink : in  std_logic;                     -- if 1, use link register 31
        PC_4        : in  std_logic_vector(31 downto 0); -- current program counter + 4

        rd_data0    : out std_logic_vector(31 downto 0); -- read data 1?
        rd_data1    : out std_logic_vector(31 downto 0)  -- read data 2?
    );
end register_file;

architecture logic of register_file is
    type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
    signal regs : reg_array;
begin
    process(clk, rst) is
    begin 
        if (rst = '1') then
            for i in regs'range loop                             -- set all register values to 0
                regs(i) <= (others => '0');
            end loop;
        elsif (rising_edge(clk)) then
            if (wr_en = '1') then                                -- if there is something to write
                regs(to_integer(unsigned(wr_addr))) <= wr_data;  -- write the data where it goes
                regs(0) <= (others => '0');                      -- make sure zero register isn't changed
            end if;
            if (JumpAndLink = '1') then 
                regs(31) <= PC_4;                                -- update return register if JumpAndLink
            end if;
            rd_data0 <= regs(to_integer(unsigned(rd_addr0)));    -- output first  register being read
            rd_data1 <= regs(to_integer(unsigned(rd_addr1)));    -- output second register being read
        end if;
    end process;
end logic;