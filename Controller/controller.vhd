library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity controller is
    port(
        
        IR_31_to_26 : in std_logic(5 downto 0);
        clk
when => rst    : in std_logic;

        
        PCWriteCond : out  std_logic;
        PCWrite     : out  std_logic;
        IorD        : out  std_logic;
        MemRead     : out  std_logic;
        MemWrite    : out  std_logic;
        MemToReg    : out  std_logic;
        IRWrite     : out  std_logic;
        JumpAndLink : out  std_logic;
        IsSigned    : out  std_logic;
        PCSource    : out  std_logic_vector(1 downto 0);
        ALUOp       : out  std_logic_vector(1 downto 0);
        ALUSrcA     : out  std_logic;
        ALUSrcB     : out  std_logic_vector(1 downto 0);
        RegWrite    : out  std_logic;
        RegDst      : out  std_logic

    );
end controller;


architecture logic of controller is
    
    type state is {fetch_instruction, decode_instruction, memory_address_computation, execution, branch_completion, jump_completion, memory_access_read, memory_access_write, r_type_completion, memory_read_completion};
    
    signal curr_state, next_state : state := fetch_instruction;
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            curr_state <= fetch_instruction;
        elsif (rising_edge(clk)) then
            curr_state <= next_state;
        end if;
    end process;

    process(curr_state)
    begin

        -- set all outputs to 0 by default, then set what is needed
        
        PCWriteCond <= '0';
        PCWrite     <= '0';
        IorD        <= '0';
        MemRead     <= '0';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '0';
        JumpAndLink <= '0';
        IsSigned    <= '0';
        PCSource    <= (others => '0');
        ALUOp       <= (others => '0');
        ALUSrcA     <= '0';
        ALUSrcB     <= (others => '0');
        RegWrite    <= '0';
        RegDst      <= '0';

        case(curr_state) is
            when fetch_instruction =>
                MemRead <= '1';
                IRWrite <= '1';
                ALUSrcB <= "01";
                PCWrite <= '1';

            when decode_instruction =>
                ALUSrcB <= "11";

            when memory_address_computation =>
                ALUSrcA <= '1';
                ALUSrcB <= "10";
    
            when memory_access_read =>
                MemRead <= '1';
                IorD <= '1';

            when memory_access_write =>
                MemWrite <= '1';
                IorD <= '1';
            
            when memory_read_completion =>
                RegDst <= '1';
                RegWrite <= '1';

            when execution =>
                ALUSrcA <= '1';
                ALUOp <= "10";

            when branch_completion =>
                ALUSrcA <= '1';
                ALUOp <= "01";
                PCWriteCond <= '1';
                PCSource <= "01";

            when jump_completion =>
                PCWrite <= '1';
                PCSource <= "10";
            
            when r_type_completion =>
                RegDst <= '1';
                RegWrite <= '1';
            
            when others =>

            end case;



    end process;

end logic ; -- logic
