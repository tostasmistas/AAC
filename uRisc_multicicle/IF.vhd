library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InF is
	port(
		-- input
		clk, rst 				: in std_logic;
		en_if 					: in std_logic;
		rep_pc					: in std_logic;
		reg_pc_IN 				: in std_logic_vector(11 downto 0);		 -- PC realimentado
		out_ROM					: in std_logic_vector(15 downto 0);	

		-- output
		reg_PCMEM_OUT			: out std_logic_vector(11 downto 0);	 -- PC + 1
		rep_pc_out				: out std_logic;
		addr						: out std_logic_vector(11 downto 0);	-- PC + 1
		reg_IfOut_ROM			: out std_logic_vector(15 downto 0);
		reg_IfOut_PC			: out std_logic_vector(11 downto 0)-- registo entre andares		
	);
end InF;

architecture Behavioral of InF is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal aux_pc_add_1	   		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_saida_mux				: std_logic_vector(11 downto 0) := (others => '0');
signal aux_reg_pc 				: std_logic_vector(11 downto 0) := (others => '0');
signal aux_out_ROM 				: std_logic_vector(15 downto 0) := (others => '0');
signal aux_pc_OUT					: std_logic_vector(11 downto 0) := (others => '0');


--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant one				   : std_logic_vector(11 downto 0) := "000000000001";
constant zeros_16				: std_logic_vector(15 downto 0) := (others => '0');
constant zeros_12				: std_logic_vector(11 downto 0) := (others => '0');

begin


aux_saida_mux <= reg_pc_IN ;

								
	
---------------------------------------------------------------------------
----------------------- Registo PC	---------------------------------------
---------------------------------------------------------------------------
--process (clk, rst, rep_pc,reg_pc_IN)
--	begin
--		if clk'event and clk = '1' then
--			if rst = '1' then
--				aux_reg_pc <= zeros_12;
--				else
--				
--			end if;
--		end if;
--end process;		
aux_reg_pc <= aux_saida_mux;

	
aux_pc_add_1 <= aux_reg_pc + one;


---------------------------------------------------------------------------
--------------------- Registo de Instruções (IR) --------------------------
---------------------------------------------------------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_out_ROM <= zeros_16;
				aux_pc_OUT	<= zeros_12;
			elsif en_if = '1' then
				aux_out_ROM <= out_ROM;
				aux_pc_OUT	<= aux_pc_add_1; 					-- carregar a próxima instrução da memória (de programa) e armazenar no IR
			end if;		
		end if;
end process;

--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------
reg_PCMEM_OUT <= aux_reg_pc;
addr		  	  <= aux_reg_pc;
reg_IfOut_ROM <= aux_out_ROM;
reg_IfOut_PC  <= aux_pc_OUT;

end Behavioral;

