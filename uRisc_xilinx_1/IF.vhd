library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InF is
	port(
		-- input
		clk, rst 				: in std_logic;
		destino_jump			: in std_logic_vector(11 downto 0);
		destino_cond			: in std_logic_vector(11 downto 0);
		FLAGTEST_MUXPC_IN		: in std_logic;
		JUMP_MUXPC_IN			: in std_logic;
		reg_pc_IN 				: in std_logic_vector(11 downto 0);

		-- output
		reg_PCMEM_OUT			: out std_logic_vector(11 downto 0);
		reg_IF_OUT				: out std_logic_vector(27 downto 0)		-- registo entre andares		
	);
end InF;

architecture Behavioral of InF is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal aux_pc_add_1	   		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_saida_mux		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_reg_pc 			: std_logic_vector(11 downto 0) := (others => '0');
signal save_pc_add_1		: std_logic_vector(11 downto 0) := (others => '0');


--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant one				: std_logic_vector(11 downto 0) :="0000000000001" ;
constant zeros				: std_logic_vector(11 downto 0) := (others => '0');

begin

aux_pc_add_1 <= reg_pc_IN + one 			when FLAGTEST_MUXPC_IN = '0' else
				reg_pc_IN + destino_cond;

	
aux_saida_mux <= aux_pc_add_1 				when JUMP_MUXPC_IN = '0' else
				 destino_jump;
								
	
---------------------------------------------------------------------------
----------------------- Registo PC	---------------------------------------
---------------------------------------------------------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_pc <= zeros;
			else
				aux_reg_pc <= aux_saida_mux;
			end if;		
		end if;
end process;		


	

--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------
reg_PCMEM_OUT <= aux_reg_pc;
save_pc_add_1 <= aux_pc_add_1;

---------------------------------------------------------------------------
--------------------- Registo de Instruções (IR)	------------------------
---------------------------------------------------------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				reg_IF_OUT <= zeros;
			else
				-- substituir "000" pelo que vem da memoria
				reg_IF_OUT <= "000" & save_pc_add_1; 					-- carregar a próxima instrução da memória (de programa) e armazenar no IR
			end if;		
		end if;
end process;

end Behavioral;

