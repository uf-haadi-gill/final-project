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
-- follow similar if not same states as controller 
-- immediate and not immediate both have the same code, just treat the input source as different 

-- general notes for the next part: 
--      > load word store word oh my god so much 
--      > start one at a time, with load word or store word are you writing all this?
--      > start with the memory branch of the state amchine from the diagram and set all the values accordingly 
--      > test things in a test bench  
--          ~ how to look at memory: there is a file he sent you look at that 
--      > branch and jump, non sequential
--          ~  branch is conditional, jump you always jump 
--          ~ oopsie poopsie

end logic;