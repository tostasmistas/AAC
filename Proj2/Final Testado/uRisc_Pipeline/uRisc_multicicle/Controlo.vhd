
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity Controlo is
	port (
			clk, rst	: in std_logic;
			en_if 	: out std_logic;
			en_if_pc	: out std_logic;
			en_idOF 	: out std_logic;
			en_EX		: out std_logic
			);
end Controlo;


architecture Behavioral of Controlo is
		type fsm_states is ( s_1,s_2,s_3);
		signal currstate, nextstate: fsm_states;
begin

state_reg: process (clk,rst)
	  begin 
		 if rst = '1' then
			currstate <= s_1 ;
		 elsif clk'event and clk = '1' then
			currstate <= nextstate ;
		 end if ;
end process;

state_comb: process (currstate)
  begin  --  process
	 nextstate <= currstate;
	 
    
    case currstate is
      when s_1 =>
			nextstate <= s_2 ;
			en_if			<= '1';
			en_if_pc		<= '0';
			en_idOF		<= '0';
			en_EX			<= '0';
		when s_2 =>
			nextstate <= s_3 ;
			en_if			<= '0';
			en_if_pc		<= '1';
			en_idOF		<= '1';
			en_EX			<= '0';
		when s_3 =>
			nextstate <= s_1 ;
			en_if			<= '0';
			en_if_pc		<= '0';
			en_idOF		<= '0';
			en_EX			<= '1';
				
		end case;
  end process;


end Behavioral;