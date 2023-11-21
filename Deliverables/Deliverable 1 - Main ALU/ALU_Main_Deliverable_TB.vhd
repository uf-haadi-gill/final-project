library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU_Main_Deliverable_TB is
end ALU_Main_Deliverable_TB;

architecture TB of ALU_Main_Deliverable_TB is
	signal A   : std_logic_vector(31 downto 0) := (others=>'0');
    signal B   : std_logic_vector(31 downto 0) := (others=>'0');
    signal OP_Select : std_logic_vector(4 downto 0) := (others=>'0');
    signal Shift_Amount : std_logic_vector(4 downto 0) := (others=>'0');
    signal Result_Low   : std_logic_vector(31 downto 0);
    signal Result_High : std_logic_vector(31 downto 0);
    signal Branch_Taken   : std_logic := '0';
	 
begin --TB
	UUT: entity work.ALU_Main
        port map (
			A   => A,
			B   => B,
			Shift_Amount => Shift_Amount,
			OP_Select => OP_Select,
			Result_Low   => Result_Low,
			Result_High => Result_High,
			Branch_Taken   => Branch_Taken
		);
    process
    begin --process
        
		  --ADD
		  OP_Select <= "00010"; 
        A <= conv_std_logic_vector(10, A'length);
        B <= conv_std_logic_vector(15, B'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(25, Result_Low'length)) report "Error: ADD Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in ADD" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in ADD" severity warning;
		  
		  --SUB
		  OP_Select <= "00100"; 
        A <= conv_std_logic_vector(25, A'length);
        B <= conv_std_logic_vector(10, B'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(15, Result_Low'length)) report "Error: SUB Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in SUB" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in SUB" severity warning;
		  
		  --MULT (signed)
		  OP_Select <= "10110"; 
        A <= conv_std_logic_vector(10, A'length);
        B <= conv_std_logic_vector(-4, B'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(-40, Result_Low'length)) report "Error: MULT (signed) Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(-1, Result_High'length)) report "Error: Result_High Wrong in MULT (signed)" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in MULT (signed)" severity warning;
		  
		  --MULT (unsigned)
		  OP_Select <= "10101"; 
        A <= conv_std_logic_vector(65536, A'length);
        B <= conv_std_logic_vector(131072, B'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(0, Result_Low'length)) report "Error: MULT (unsigned) Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(2, Result_High'length)) report "Error: Result_High Wrong in MULT (unsigned)" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in MULT (unsigned)" severity warning;
		  
		  --AND
		  OP_Select    <= "10111"; 
        A <= conv_std_logic_vector(65535, A'length);
        B <= "11111111111111110001001000110100";
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(4660, Result_Low'length)) report "Error: AND Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in AND" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in AND" severity warning;
		  
		  --right logical
		  OP_Select    <= "00111";  
        A <= conv_std_logic_vector(15, A'length);
		  Shift_Amount<=conv_std_logic_vector(4, Shift_Amount'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(0, Result_Low'length)) report "Error: right logical Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in right logical" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in right logical" severity warning;
		  
		  --right arithmetic
		  OP_Select    <= "01011"; 
        A <= "11110000000000000000000000001000";
		  Shift_Amount<=conv_std_logic_vector(1, Shift_Amount'length);
        wait for 20 ns;
        assert(Result_Low = "11111000000000000000000000000100") report "Error: right arithmetic Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in right arithmetic" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in right arithmetic"severity warning;
		  
		  --right arithmetic
		  OP_Select    <= "01011"; 
        A <= conv_std_logic_vector(8, A'length);
		  Shift_Amount<=conv_std_logic_vector(1, Shift_Amount'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(4, Result_Low'length)) report "Error: right arithmetic Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in right arithmetic" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in right arithmetic"severity warning;
		  
		  --set on less than
		  OP_Select    <= "01110"; 
        A <= conv_std_logic_vector(10, A'length);
        B <= conv_std_logic_vector(15, B'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(1, Result_Low'length)) report "Error: set on less than Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in set on less than" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in set on less than"severity warning;
		  
		  --set on less than
		  OP_Select    <= "01110"; 
        A <= conv_std_logic_vector(15, A'length);
        B <= conv_std_logic_vector(10, B'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(0, Result_Low'length)) report "Error: set on less than Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in set on less than" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in set on less than"severity warning;
		  
		  --branch if less than or equal to 0
		  OP_Select    <= "11101"; 
        A <= conv_std_logic_vector(5, A'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(0, Result_Low'length)) report "Error: branch if less than or equal to 0 Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in branch if less than or equal to 0" severity warning;
		  assert(Branch_Taken = '0') report "Error: Branch Taken wrong in branch if less than or equal to 0"severity warning;
		  
		  --branch if greather than 0
		  OP_Select    <= "11111"; 
        A <= conv_std_logic_vector(5, A'length);
        wait for 20 ns;
        assert(Result_Low = conv_std_logic_vector(0, Result_Low'length)) report "Error: branch if greather than 0 Result_Low Wrong" severity warning;
        assert(Result_High = conv_std_logic_vector(0, Result_High'length)) report "Error: Result_High Wrong in branch if greather than 0" severity warning;
		  assert(Branch_Taken = '1') report "Error: Branch Taken wrong in branch if greather than 0"severity warning;
		  
        report "DONE!!!!!!" severity note;
        wait;
    end process;

end TB;