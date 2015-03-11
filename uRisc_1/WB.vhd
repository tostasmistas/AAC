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

end WB

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

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal aux_sel_bit1				: std_logic_vector(15 downto 0) := (others => '0'); -- bit de selecção 1 do MUX 4:1 do WB
signal aux_sel_bit0				: std_logic_vector(15 downto 0) := (others => '0'); -- bit de selecção 0 do MUX 4:1 do WB

begin

aux_sel_bit1 <= reg_EXMEM_OUT(36) or reg_EXMEM_OUT(0);
				-- JUMP_MUXWB_OUT or inst_IN(14)

aux_sel_bit0 <= reg_EXMEM_OUT(36) or (not(reg_EXMEM_OUT(0)) and reg_EXMEM_OUT(50)) ;
				-- JUMP_MUXWB_OUT or (inst_IN(14) and ALU_vs_MEM)

sel_mux_WB <= aux_sel_bit1 & aux_sel_bit0;

out_mux_WB <=	reg_EXMEM_OUT(32 downto 17)		when sel_mux_WB = "00" else  -- escrever a saída da ALU 		(out_ALU)
				reg_EXMEM_OUT(66 downto 51)		when sel_mux_WB = "01" else  -- escrever saída da MEM 			(out_MEM)
				reg_EXMEM_OUT(16 downto 1)		when sel_mux_WB = "10" else	 -- fazer load de uma constante		(out_mux_constantes)
				reg_EXMEM_OUT(49 downto 37);								 -- guardar em R7 o valor de PC+1 	(save_pc_add_1)
				

-- decoder para os write-enable dos 8 registos do banco de registos 
case reg_EXMEM_OUT(35 downto 33) is -- aux_ADD_RWC (vem do ID)
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

