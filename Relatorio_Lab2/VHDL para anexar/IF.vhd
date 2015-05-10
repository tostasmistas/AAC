library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InF is
port(
	-- input
	clk, rst 							: in std_logic;
	en_if 								: in std_logic;
	reg_pc_IN							: in std_logic_vector(11 downto 0);		-- PC realimentado

	pc_branch							: in std_logic_vector(11 downto 0);		-- acrescentar
	Jump_BTB							: in std_logic_vector(11 downto 0);
	OUT_BTB								: in std_logic_vector(16 downto 0);
	act_BTB								: in std_logic;
	Conflit_DADOS					: in std_logic;
	en_Jump_FII						: in std_logic;
	en_Jump_Incond				: in std_logic;
	count_IN							: in std_logic_vector(15 downto 0);
	Jump_Incon						: in std_logic_vector(11 downto 0);
	out_ROM								: in std_logic_vector(15 downto 0);

	-- output
	addr_BTB_A						: out std_logic_vector(8 downto 0);
	addr_BTB_B						: out std_logic_vector(8 downto 0);
	IN_BTB								: out std_logic_vector(16 downto 0);
	we_BTB								: out std_logic;
	reg_PCMEM_OUT					: out std_logic_vector(11 downto 0);	 -- PC + 1
	reg_pc_OUT 						: out std_logic_vector(11 downto 0);	 -- PC realimentado
	addr									: out std_logic_vector(11 downto 0);	 -- PC + 1
	reg_IfOut_ROM					: out std_logic_vector(15 downto 0);
	reg_IfOut_MUX_BrPred	: out std_logic;
	count_OUT							: out std_logic_vector(15 downto 0);
	reg_IfOut_PC					: out std_logic_vector(11 downto 0)		 -- registo entre andares
	);
end InF;

architecture Behavioral of InF is

	--------------------------------------------------------------------------
	--------------------------- Aux Signals ----------------------------------
	--------------------------------------------------------------------------
	signal aux_pc_add_1	  		: std_logic_vector(11 downto 0) := (others => '0');
	signal aux_count	   			: std_logic_vector(15 downto 0) := (others => '0');
	signal signal_count				: std_logic := '0';
	signal aux_saida_mux			: std_logic_vector(11 downto 0) := (others => '0');
	signal aux_reg_pc 				: std_logic_vector(11 downto 0) := (others => '0');
	signal aux_reg_pc_backup	: std_logic_vector(11 downto 0) := (others => '0');
	signal aux_out_ROM 				: std_logic_vector(15 downto 0) := (others => '0');
	signal Aux_IN_BTB 				: std_logic_vector(16 downto 0) := (others => '0');
	signal aux_pc_OUT					: std_logic_vector(11 downto 0) := (others => '0');
	----Sinais para o BTB
	signal MSB_PC_TAG					: std_logic := '0';
	signal MUX_BrPred					: std_logic := '0';
	signal aux_we_BTB					: std_logic := '0';
	signal Addr_BTB_Act				: std_logic_vector( 8 downto 0) := (others => '0');
	signal MSB_BTB						: std_logic_vector( 2 downto 0) := (others => '0');
	signal PC_BTB							: std_logic_vector( 11 downto 0) := (others => '0');
	signal Jump_From_BTB			: std_logic_vector( 11 downto 0) := (others => '0');
	signal Prediction_Bit			: std_logic := '0';
	signal Validate_Bit				: std_logic := '0';
	signal Clean_BTB					: std_logic := '0';
	signal Insert_BTB					: std_logic := '0';
	signal jump_equal_pc			: std_logic := '0';
	signal MUX_NEXTPC					: std_logic_vector( 1 downto 0) := (others => '0');
	signal aux_erros					: std_logic_vector(11 downto 0) := (others => '0');

--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
	constant one				   	: std_logic_vector(11 downto 0) := "000000000001";
	constant zeros_16				: std_logic_vector(15 downto 0) := (others => '0');
	constant zeros_12				: std_logic_vector(11 downto 0) := (others => '0');

begin

--------------------------------
------     BTB    --------------
--------------------------------

	--Leitura da BTB
	addr_BTB_B			<= aux_pc_add_1(8 downto 0);--confirmar
	MSB_BTB					<= OUT_BTB(16 downto 14);
	Jump_From_BTB		<= OUT_BTB(13 downto 2);
	Prediction_Bit	<= OUT_BTB(1);
	Validate_Bit		<= OUT_BTB(0);


	--Actualizacao da BTB
	addr_BTB_A	<=	pc_branch(8 downto 0);
	IN_BTB			<= pc_branch(11 downto 9)&Jump_BTB&act_BTB&'1';
	we_BTB			<= Insert_BTB or Clean_BTB;

	--Mux Not Taken='0'/ Taken='1'
	MSB_PC_TAG 		<= ((aux_pc_add_1(11) xnor MSB_BTB(2)) and (aux_pc_add_1(10) xnor MSB_BTB(1)) and (aux_pc_add_1(9) xnor MSB_BTB(0))) and Validate_Bit;

	MUX_BrPred  	<= Prediction_Bit when MSB_PC_TAG = '1' else '0';

	PC_BTB				<=	Jump_From_BTB	when MUX_BrPred = '1' else
										reg_pc_IN + one;

	MUX_NEXTPC(1) <=	Conflit_DADOS AND ( (NOT(en_Jump_Incond) AND NOT(jump_equal_pc) AND ((Act_BTB AND NOT(en_Jump_FII)) OR en_Jump_FII)) OR (jump_equal_pc AND NOT(Act_BTB) AND NOT(en_Jump_FII) AND NOT(en_Jump_Incond)) );
	MUX_NEXTPC(0)	<= Conflit_DADOS AND (en_Jump_Incond OR (jump_equal_pc AND NOT(Act_BTB) AND NOT(en_Jump_FII) AND NOT(en_Jump_Incond)));

	aux_saida_mux	<= PC_BTB							when MUX_NEXTPC = "00" else
									 Jump_Incon					when MUX_NEXTPC = "01" else
									 Jump_BTB						when MUX_NEXTPC = "10" else
									 aux_reg_pc_backup;

	--aux_saida_mux <= reg_pc_IN ;

---------------------------------------------------------------------------
----------------------- Registo PC	---------------------------------------
---------------------------------------------------------------------------
	process (clk, rst,MUX_BrPred)
		begin
			if clk'event and clk = '1' then
				if rst = '1' then
					aux_reg_pc <= zeros_12;
				elsif MUX_BrPred = '1' then
					aux_reg_pc_backup	<= reg_pc_IN + one;
					aux_reg_pc 			<= aux_saida_mux;
				else
					aux_reg_pc 			<= aux_saida_mux;
				end if;
			end if;
	end process;

	process (clk, rst,count_IN)
		begin
			if clk'event and clk = '1' then
				if rst = '1' then
					aux_count<= zeros_16;
				elsif signal_count = '0' then
					aux_count <= count_IN + one;
				end if;
			end if;
	end process;

	aux_pc_add_1 <= aux_reg_pc;

	count_OUT <= aux_count;

	--Controlo de saltos em relacao a BTB

	jump_equal_pc	<= Conflit_DADOS when Jump_BTB = aux_pc_add_1 else '0';

	-- CASOS POSSIVEIS
	-- jump_equal_pc = 0 e act_BTB = 1 tem que carregar o salto e actualizar btb
	-- jump_equal_pc = 1 e act_BTB = 0 tem que carregar o pc antigo e limpar btb

	Clean_BTB 	<= jump_equal_pc AND Not(act_BTB) AND NOT(en_Jump_FII) AND NOT(en_Jump_Incond);
	Insert_BTB	<= (NOT(jump_equal_pc) AND act_BTB AND NOT(en_Jump_FII) AND NOT(en_Jump_Incond)) OR (NOT(jump_equal_pc) AND en_Jump_FII AND NOT(en_Jump_Incond));


	signal_count <= '1' when out_ROM = x"2fff" else '0' ;
---------------------------------------------------------------------------
--------------------- Registo de Instrucoes (IR) --------------------------
---------------------------------------------------------------------------
	process (clk, rst)
		begin
			if clk'event and clk = '1' then
				if rst = '1' then
					aux_out_ROM <= zeros_16;
					aux_pc_OUT	<= zeros_12;
				elsif en_if = '1' then
					if (Conflit_DADOS = '1') and(Clean_BTB = '1' or Insert_BTB = '1' or en_Jump_Incond = '1')  then
						aux_out_ROM <= x"0000";
						aux_erros	<= aux_erros + one;
						aux_pc_OUT	<= aux_pc_add_1;
					else
						aux_out_ROM <= out_ROM;
						aux_pc_OUT	<= aux_pc_add_1 + one; 		--Modificado em relacao ao apresentado no Laboratorio, foi acrescentado + one;
					end if;
				end if;
			end if;
	end process;

--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------
	reg_PCMEM_OUT 	<= aux_reg_pc;
	addr		  			<= aux_reg_pc;
	reg_pc_OUT 			<= aux_pc_add_1;
	reg_IfOut_ROM		<= aux_out_ROM;
	reg_IfOut_PC  	<= aux_pc_OUT;

end Behavioral;
