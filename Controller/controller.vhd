library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity controller is
    port(
        
        IR_31_to_26 : in std_logic_vector(5 downto 0);
        clk, rst    : in std_logic;

        
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
    
    type state is ( fetch_1, fetch_2, jump, decode, branch,       -- all take 1 clock cycle
                    load_1,  load_2,  load_3, load_4,            -- load word is 4
                    store_1, store_2, rtype_1, rtype_2,          -- everything else is 2, all rtype grouped together
                    addi_1,  addi_2, subi_1, subi_2,             -- all immediate values need separate states
                    andi_1,  andi_2, ori_1, ori_2,
                    xori_1,  xori_2, slti_1, slti_2,
                    sltui_1, sltui_2, jal_1, jal_2
    );
                  
    signal curr_state, next_state : state := fetch_1;
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            curr_state <= fetch_1;
        elsif (rising_edge(clk)) then
            curr_state <= next_state;
        end if;
    end process;

    process(curr_state, IR_31_to_26)
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
        PCSource    <= "00";
        ALUOp       <= "00";
        ALUSrcA     <= '0';
        ALUSrcB     <= "00";
        RegWrite    <= '0';
        RegDst      <= '0';

        case(curr_state) is

            when fetch_1 =>
                next_state <= fetch_2;
                MemRead <= '1';
                ALUSrcB <= "01";
                PCWrite <= '1';
                
            when fetch_2 =>
                IRWrite <= '1';
                next_state <= decode;

            when jump =>
                PCWrite <= '1';
                PCSource <= "10";
                ALUOp <= "11";
                next_state <= fetch_1;

            when decode =>
                case(IR_31_to_26) is
                    when "000000" =>
                        next_state <= rtype_1;
                    
                    when "001001" =>
                        next_state <= addi_1;

                    when "010000" =>
                        next_state <= subi_1; 

                    when "001100" =>
                        next_state <= andi_1;

                    when "001101" =>
                        next_state <= ori_1;

                    when "001110" =>
                        next_state <= xori_1;

                    when "001010" =>
                        next_state <= slti_1;

                    when "001011" =>
                        next_state <= sltui_1;

                    when "101011" =>
                        next_state <= store_1; 

                    when "100011" =>
                        next_state <= load_1;

                    when "000100" =>
                        next_state <= branch;

                    when "000101" =>
                        next_state <= branch;

                    when "000110" =>
                        next_state <= branch;

                    when "000111" =>
                        next_state <= branch;

                    when "000010" =>
                        next_state <= jump;

                    when "000011" =>
                        next_state <= jal_1;

                    when others =>
                        next_state <= fetch_1;
                    
                end case;

                ALUSrcB <= "11";

            when load_1 =>
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                IorD <= '1';
                next_state <= load_2;
                
            when load_2 =>
                MemRead <= '1';
                next_state <= load_3;

            when load_3 =>
                MemtoReg <= '1';
                RegWrite <= '1';
                next_state <= load_4;

            when load_4 =>
                next_state <= fetch_1;

            when store_1 =>
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                IorD <= '1';
                next_state <= store_2;

            when store_2 =>
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                MemWrite <= '1';
                IorD <= '1';
                next_state <= fetch_1;

            when rtype_1 =>
                ALUOp <= "10";
                ALUSrcA <= '1';
                next_state <= rtype_2;
            
            when rtype_2 =>
                ALUOp <= "10";
                RegWrite <= '1';
                ALUSrcA <= '1';
                RegDst <= '1';
                next_state <= fetch_1;

            when branch =>
                PCWriteCond <= '1';
                PCSource <= "01";
                ALUOp <= "11";
                ALUSrcA <= '1';
                next_state <= fetch_1;

            when andi_1 =>
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                next_state <= andi_2;

            when andi_2 => 
                ALUOp <= "11";
                ALUSrcA <= '1';
                RegWrite <= '1';
                ALUSrcB <= "10";
                next_state <= fetch_1;

            when ori_1 =>
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                next_state <= ori_2;

            when ori_2 => 
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                RegWrite <= '1';
                next_state <= fetch_1;
           
            when xori_1 =>
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                next_state <= xori_2;

            when xori_2 =>
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                RegWrite <= '1';
                next_state <= fetch_1;

            when slti_1 =>
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                IsSigned <= '1';
                next_state <= slti_2;

            when slti_2 =>
                ALUOp <= "11";
                ALUSrcB <= "10";
                RegWrite <= '1';
                ALUSrcA <= '1';
                next_state <= fetch_1;

            when sltui_1 =>
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                next_state <= sltui_2;

            when sltui_2 =>
                ALUOp <= "11";
                ALUSrcA <= '1';
                ALUSrcB <= "10";
                RegWrite <= '1';
                next_state <= fetch_1;

            when jal_1 =>
                PCSource <= "10";
                ALUSrcB <= "01";
                next_state <= jal_2;

            when jal_2 =>
                PCWrite <= '1';
                PCSource <= "10";
                JumpAndLink <= '1';
                ALUOp <= "11";
                next_state <= fetch_1;

            when others =>
                next_state <= fetch_1;

            end case;



    end process;

end logic ; -- logic
