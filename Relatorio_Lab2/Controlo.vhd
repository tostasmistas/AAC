
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity Controlo is
	port (
			clk, rst	: in std_logic;
			en_if 		: out std_logic;
			en_idOF 	: out std_logic;
			en_EX		: out std_logic
			);
end Controlo;


architecture Behavioral of Controlo is
		type fsm_states is (s_inicial,s_inicial2,s_inicial3,s_cont);
		signal currstate, nextstate: fsm_states;
begin

state_reg: process (clk,rst)
	  begin 
		 if rst = '1' then
			currstate <= s_inicial ;
		 elsif clk'event and clk = '1' then
			currstate <= nextstate ;
		 end if ;
end process;

state_comb: process (currstate )
  begin  --  process
	 nextstate <= currstate;
	 
    
    case currstate is
		when s_inicial	=>	
			nextstate <= s_inicial2;
			en_if			<= '1';
			en_idOF		<= '1';
			en_EX			<= '1';
		when s_inicial2	=>	
			nextstate <= s_inicial3;
			en_if			<= '1';
			en_idOF		<= '1';
			en_EX			<= '1';
		when s_inicial3	=>	
			nextstate <= s_cont;
			en_if			<= '1';
			en_idOF		<= '1';
			en_EX			<= '1';
			
      when s_cont => 
      	nextstate <= s_cont ;
      		en_if			<= '1';
				en_idOF		<= '1';
				en_EX			<= '1';
				
		end case;
  end process;


end Behavioral;