
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


entity Controlo is
	port (
			clk, rst: in std_logic;
			unicicle: in std_logic;
			en_registo : out std_logic);
end Controlo;

architecture Behavioral of Controlo is
		type fsm_states is ( s_initial);
		signal currstate, nextstate: fsm_states;
begin

state_reg: process (clk,rst)
	  begin 
		 if rst = '1' then
			currstate <= s_initial ;
		 elsif clk'event and clk = '1' then
			currstate <= nextstate ;
		 end if ;
end process;

state_comb: process (currstate,unicicle)
  begin  --  process
	 nextstate <= currstate;
	 
    -- Estados e os bits de controlo
    
    case currstate is
      when s_initial =>
			nextstate <= s_initial ;
			if unicicle = '1' then
				en_registo <= '1';
			else
				en_registo <= '0';
			end if;
		
		end case;
  end process;


end Behavioral;