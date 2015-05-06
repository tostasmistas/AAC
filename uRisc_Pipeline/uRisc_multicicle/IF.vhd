library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InF is
	port(
		-- input
		clk, rst 				: in std_logic;
		destino_jump			: in std_logic_vector(11 downto 0);		 -- vem da ALU	
		en_if 					: in std_logic;
		en_if_pc					: in std_logic;
		rep_pc					: in std_logic;
		destino_cond			: in std_logic_vector(11 downto 0);     -- vem da ALU
		FLAGTEST_MUXPC_IN		: in std_logic;							    -- vem da ALU
		JUMP_MUXPC_IN			: in std_logic;							    -- vem do IDeOF
		reg_pc_IN 				: in std_logic_vector(11 downto 0);		 -- PC realimentado
		out_ROM					: in std_logic_vector(15 downto 0);	

		-- output
		reg_PCMEM_OUT			: out std_logic_vector(11 downto 0);	 -- PC + 1
		reg_OUT					: out std_logic_vector(11 downto 0);
		rep_pc_out				: out std_logic;
		addr						: out std_logic_vector(11 downto 0);	-- PC + 1
		reg_IF_OUT				: out std_logic_vector(27 downto 0)		 -- registo entre andares		
	);
end InF;

architecture Behavioral of InF is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal aux_pc_add_1	   		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_saida_mux				: std_logic_vector(11 downto 0) := (others => '0');
signal aux_reg_pc 				: std_logic_vector(11 downto 0) := (others => '0');
signal aux_reg_IF_OUT 			: std_logic_vector(27 downto 0) := (others => '0');
signal mux_jump_cond				: std_logic_vector(2 downto 0) := (others => '0');


--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant one				   : std_logic_vector(11 downto 0) := "000000000001";
constant zeros_28				: std_logic_vector(27 downto 0) := (others => '0');
constant zeros_12				: std_logic_vector(11 downto 0) := (others => '0');

begin


aux_pc_add_1 <= reg_pc_IN + one ;
mux_jump_cond	<= JUMP_MUXPC_IN&FLAGTEST_MUXPC_IN&en_if_pc ;					
	
aux_saida_mux <= destino_jump when mux_jump_cond	= "101" else
					  destino_cond when mux_jump_cond	= "011" else
					  aux_pc_add_1;
								
	
---------------------------------------------------------------------------
----------------------- Registo PC	---------------------------------------
---------------------------------------------------------------------------
process (clk, rst, rep_pc,reg_pc_IN)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_pc <= zeros_12;
				rep_pc_out <= '0';
			elsif en_if = '1' or ((JUMP_MUXPC_IN xor FLAGTEST_MUXPC_IN) and en_if_pc )= '1' then
				aux_reg_pc <= aux_saida_mux;
			end if;
		end if;
end process;		


	



---------------------------------------------------------------------------
--------------------- Registo de Instruções (IR) --------------------------
---------------------------------------------------------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_IF_OUT <= zeros_28;
			elsif en_if = '1' then
				aux_reg_IF_OUT <= out_ROM & aux_pc_add_1; 					-- carregar a próxima instrução da memória (de programa) e armazenar no IR
			end if;		
		end if;
end process;

--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------
reg_PCMEM_OUT <= aux_reg_pc;
addr			  <= aux_reg_pc;
reg_OUT		  <= aux_reg_pc;
reg_IF_OUT	  <= aux_reg_IF_OUT;

end Behavioral;

