library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WB is
	port(
	-- input
	clk, rst 				: in std_logic;
	reg_EXMEM_OUT			: in std_logic_vector();

	-- output
	en_r0					: out std_logic;
	en_r1					: out std_logic;
	en_r2					: out std_logic;
	en_r3					: out std_logic;
	en_r4					: out std_logic;
	en_r5					: out std_logic;
	en_r6					: out std_logic;
	en_r7					: out std_logic;	
	);
end WB;

architecture Behavioral of WB is

begin


out_mux_WB <=	reg_EXMEM_OUT(32 downto 17)		when reg_EXMEM_OUT(0) = '0' else  -- escrever a saída da ALU
				reg_EXMEM_OUT(16 downto 1);										  -- fazer load de uma constante	

-- decoder para os write-enable dos 8 registos do banco de registos 
case reg_EXMEM_OUT(48 downto 33) is -- aux_ADD_RWC (vem do ID)
	when "000" => -- en_r0
    	en_r0 <= '1';
  	when "001" => -- en_r1
    	en_r1 <= '1';
  	when "010" => -- en_r2
     	en_r2 <= '1';
  	when "011" => -- en_r3
     	en_r3 <= '1';
  	when "100" => -- en_r4
     	en_r4 <= '1';
  	when "101" => -- en_r5
     	en_r5 <= '1';
	when "110" => -- en_r6
     	en_r6 <= '1';
 	when "111" => -- en_r7
 		en_r7 <= '1';
end case;

end Behavioral;

