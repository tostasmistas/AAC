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
		reg_EXMEM_OUT_PCadd1		: in std_logic_vector(11 downto 0);
		reg_EXMEM_OUT_AddRWC		: in std_logic_vector(2 downto 0);
		reg_EXMEM_OUT_OutALU		: in std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_OutMEM		: in std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_MuxConst		: in std_logic_vector(15 downto 0);
		reg_EXMEM_OUT_ovWE			: in std_logic;
		reg_EXMEM_OUT_SelMuxWB		: in std_logic_vector(1 downto 0);
		
		
		-- output
		ADD_RWC_WB					: out std_logic_vector(2 downto 0);
		ovWE_WB						: out std_logic;
		Forw_WB						: out std_logic_vector(15 downto 0);
		out_mux_WB					: out std_logic_vector(15 downto 0);
		out_saida					: out std_logic_vector(15 downto 0);
		en_regs						: out std_logic_vector(7 downto 0)
	);
end WB;

architecture Behavioral of WB is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal sel_mux_WB				: std_logic_vector(1 downto 0) := (others => '0');
signal aux_out_alu				: std_logic_vector(15 downto 0):= (others => '0');
signal aux_out_const			: std_logic_vector(15 downto 0):= (others => '0');
signal aux_mux_WB			: std_logic_vector(15 downto 0):= (others => '0');
signal aux_out_pcadd1			: std_logic_vector(15 downto 0):= (others => '0');
signal aux_en_WC 				: std_logic_vector(2 downto 0):= (others => '0');


constant zeros				: std_logic_vector(15 downto 0) := (others => '0');
begin


sel_mux_WB <= reg_EXMEM_OUT_SelMuxWB;

aux_out_alu 	<= reg_EXMEM_OUT_OutALU;
aux_out_const 	<= reg_EXMEM_OUT_MuxConst;
aux_out_pcadd1 	<= X"0" & reg_EXMEM_OUT_PCadd1;

aux_mux_WB <=		aux_out_alu								when sel_mux_WB = "00" else    	-- escrever a saida da ALU 		(out_ALU)
					   reg_EXMEM_OUT_OutMEM					when sel_mux_WB = "01" else    	-- escrever saida MEM 			(out_MEM)
					   aux_out_const							when sel_mux_WB = "10" else	 	-- fazer load de uma constante		(out_mux_constantes)
						aux_out_pcadd1;								 										-- guardar em R7 o valor de PC+1 	(save_pc_add_1)

out_mux_WB <= aux_mux_WB;
aux_en_WC <= "111" when (sel_mux_WB(1) and sel_mux_WB(0)) = '1' else reg_EXMEM_OUT_AddRWC;



with aux_en_WC select
		en_regs <= 	"0000000" & reg_EXMEM_OUT_ovWE 			when "000",
					"000000" & reg_EXMEM_OUT_ovWE & '0'		when "001",
					"00000" & reg_EXMEM_OUT_ovWE & "00" 	when "010",
					"0000" & reg_EXMEM_OUT_ovWE & "000" 	when "011",
					"000" & reg_EXMEM_OUT_ovWE & "0000" 	when "100",
					"00" & reg_EXMEM_OUT_ovWE & "00000" 	when "101",
					'0' & reg_EXMEM_OUT_ovWE & "000000" 	when "110",
					reg_EXMEM_OUT_ovWE & "0000000" 		   when "111", 
					"00000000"              when others;


----------------------------------
------------EXIT------------------

ADD_RWC_WB 	<= reg_EXMEM_OUT_AddRWC;
ovWE_WB 	<= reg_EXMEM_OUT_ovWE;

Forw_WB <= aux_mux_WB;

end Behavioral;

