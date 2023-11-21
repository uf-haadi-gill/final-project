library ieee;
use ieee.std_logic_1164.all;


entity ALU_Control is 
    port(
        HI_en, LO_en : in std_logic;
        ALU_LO_HI, ALU_OP : in std_logic_vector(1 downto 0);
        IR_5to0, IR_31to26: in std_logic_vector(5 downto 0);
        OPSelect   : out std_logic_vector(4 downto 0)
    );
end ALU_Control;

architecture logic of ALU_Control is
begin 

end logic;