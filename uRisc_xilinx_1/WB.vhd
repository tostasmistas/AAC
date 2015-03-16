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
		clk, rst 					: in std_logic;
		reg_EXMEM_OUT				: in std_logic_vector(66 downto 0);		-- registo entre andares
		
		-- output
		en_regs						: out std_logic_vector(7 downto 0)
	);
end WB;

architecture Behavioral of WB is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal aux_sel_bit1				: std_logic := '0'; -- bit de selecção 1 do MUX 4:1 do WB
signal aux_sel_bit0				: std_logic := '0'; -- bit de selecção 0 do MUX 4:1 do WB
signal sel_mux_WB					: std_logic_vector(1 downto 0) := (others => '0');
signal out_mux_WB					: std_logic_vector(15 downto 0) := (others => '0');

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

-- decoder para os write-enable dos 8 registos do banco de registos -- TRATAR DISTO!
with reg_EXMEM_OUT(35 downto 33) select
	en_regs <= 	"00000001" when "000",
				"00000010" when "001",
				"00000100" when "010",
				"00001000" when "011",
				"00010000" when "100",
				"00100000" when "101",
				"01000000" when "110",
				"10000000" when "111", 
				"00000000" when others;

end Behavioral;

