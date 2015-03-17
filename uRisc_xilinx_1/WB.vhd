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
		out_mux_WB					: out std_logic_vector(15 downto 0);
		en_regs						: out std_logic_vector(7 downto 0)
	);
end WB;

architecture Behavioral of WB is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal bit14					: std_logic := '0';
signal bit15 					: std_logic := '0';
signal bit6 					: std_logic := '0';
signal isJump 					: std_logic := '0';
signal ALU_ou_MEM 				: std_logic := '0';
signal aux_sel_bit1				: std_logic := '0'; -- bit de selecção 1 do MUX 4:1 do WB
signal aux_sel_bit0				: std_logic := '0'; -- bit de selecção 0 do MUX 4:1 do WB
signal sel_mux_WB				: std_logic_vector(1 downto 0) := (others => '0');
signal out_mux_WB				: std_logic_vector(15 downto 0) := (others => '0');
signal ALU_e_MEM				: std_logic := '0';
signal soMEM 					: std_logic := '0';
signal soALU 					: std_logic := '0';
signal loadMEM					: std_logic := '0';
signal controlo					: std_logic := '0';
signal controloJump				: std_logic := '0';
signal ovWE 					: std_logic := '0';

begin

bit14 <= reg_EXMEM_OUT(0);

bit15 <= reg_EXMEM_OUT(67);

bit6 <= reg_EXMEM_OUT(68);

isJump <= reg_EXMEM_OUT(36); -- JUMP_MUXWB_OUT	

ALU_ou_MEM <= reg_EXMEM_OUT(50);

aux_sel_bit1 <= is_jump or bit14;
				-- JUMP_MUXWB_OUT or inst_IN(14)

aux_sel_bit0 <= is_jump or (not(bit14) and ALU_ou_MEM) ;
				-- JUMP_MUXWB_OUT or (not(inst_IN(14)) and ALU_vs_MEM)

sel_mux_WB <= aux_sel_bit1 & aux_sel_bit0;

out_mux_WB <=	reg_EXMEM_OUT(32 downto 17)		when sel_mux_WB = "00" else  -- escrever a saída da ALU 		(out_ALU)
				reg_EXMEM_OUT(66 downto 51)		when sel_mux_WB = "01" else  -- escrever saída da MEM 			(out_MEM)
				reg_EXMEM_OUT(16 downto 1)		when sel_mux_WB = "10" else	 -- fazer load de uma constante		(out_mux_constantes)
				reg_EXMEM_OUT(49 downto 37);								 -- guardar em R7 o valor de PC+1 	(save_pc_add_1)


ALU_e_MEM <= (bit15 and (not(bit14)));

soMEM <= ALU_e_MEM and ALU_ou_MEM;

soALU <= ALU_e_MEM and not(ALU_ou_MEM);

loadMEM <= soMEM and not(bit6);

controlo <= bit14 nor bit15;

controloJump <= controlo and isJump

ovWE <= (soALU or loadMEM) or (controloJump or bit14);

-- decoder para os write-enable dos 8 registos do banco de registos -- TRATAR DISTO!
with reg_EXMEM_OUT(35 downto 33) select
	en_regs <= 	"0000000" & ovWE 		when "000",
				"000000" & ovWE & '0'	when "001",
				"00000" & ovWE & "00" 	when "010",
				"0000" & ovWE & "000" 	when "011",
				"000" & ovWE & "0000" 	when "100",
				"00" & ovWE & "00000" 	when "101",
				'0' & ovWE & "000000" 	when "110",
				ovWE & "0000000" 		when "111", 
				"00000000" when others;

end Behavioral;

