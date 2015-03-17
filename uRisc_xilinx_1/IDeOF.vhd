library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IDeOF is
	port(
		-- input
		clk, rst 				: in std_logic;
		reg_IF_OUT 				: in std_logic_vector(27 downto 0);		-- registo entre andares
		R0 						: in std_logic_vector(15 downto 0);
		R1 						: in std_logic_vector(15 downto 0);
	    R2 						: in std_logic_vector(15 downto 0);
		R3 						: in std_logic_vector(15 downto 0);
		R4 						: in std_logic_vector(15 downto 0);
		R5 						: in std_logic_vector(15 downto 0);
		R6 						: in std_logic_vector(15 downto 0);
		R7 						: in std_logic_vector(15 downto 0);
		
		-- output					
		JUMP_MUXPC_OUT			: out std_logic;						-- vai para o IF
		destino_jump			: out std_logic_vector(11 downto 0);
		destino_cond			: out std_logic_vector(11 downto 0);
		reg_IDOF_OUT			: out std_logic_vector(71 downto 0) 	-- registo entre andares
	);
end IDeOF;

architecture Behavioral of IDeOF is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal inst_IN 				: std_logic_vector(15 downto 0) := (others => '0');
signal aux_ADD_RWC			: std_logic_vector(2 downto 0) := (others => '0');
signal aux_ADD_RA			: std_logic_vector(2 downto 0) := (others => '0');
signal aux_ADD_RB			: std_logic_vector(2 downto 0) := (others => '0');
signal aux_ADD_RA_C			: std_logic_vector(2 downto 0) := (others => '0');
signal aux_ALU_OPER			: std_logic_vector(4 downto 0) := (others => '0');
signal aux_CONS_FI_11B		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_CONS_FII_R		: std_logic := '0';
signal aux_CONS_FII_8B		: std_logic_vector(7 downto 0) := (others => '0');
signal aux_CONS_FI_RWC		: std_logic_vector(2 downto 0) := (others => '0');
signal aux_active_FLAGTEST	: std_logic := '0';
signal aux_TRANS_OP			: std_logic_vector(1 downto 0) := (others => '0');
signal aux_TRANS_FI_COND	: std_logic_vector(2 downto 0) := (others => '0');
signal aux_TRANS_FI_DES 	: std_logic_vector(7 downto 0) := (others => '0');
signal aux_TRANS_FII_DES	: std_logic_vector(11 downto 0) := (others => '0');
signal aux_TRANS_DES			: std_logic_vector(11 downto 0) := (others => '0');
signal aux_TRANS_FIII_R	  	: std_logic := '0';
signal aux_JUMPS_active		: std_logic := '0';
signal aux_JUMPS_MUX_WB		: std_logic := '0';
signal JUMP_MUXWB_OUT		: std_logic := '0';
signal ALU_vs_MEM			: std_logic := '0';
signal RA_C 				: std_logic_vector(15 downto 0) := (others => '0');
signal RB 					: std_logic_vector(15 downto 0) := (others => '0');
signal oper_A				: std_logic_vector(15 downto 0);	-- operando A para a ALU
signal oper_B				: std_logic_vector(15 downto 0);	-- operando B para a ALU
signal const11				: std_logic_vector(15 downto 0);	-- operando B para a ALU
signal lcl 					: std_logic_vector(15 downto 0);	-- operando B para a ALU
signal lch 					: std_logic_vector(15 downto 0);	-- operando B para a ALU
signal select_mux_constantes: std_logic_vector(1 downto 0);
signal out_mux_constantes	: std_logic_vector(15 downto 0);	-- operando para carregamento de constantes		
signal ALU_CONS_SEL			: std_logic := '0'; 				-- sinal de selecção para MUX entre operação da ALU e operação de carregamento de constantes
signal aux_IDOF_bit15		: std_logic := '0';
signal WE_RAM					: std_logic := '0';


--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant one				: std_logic_vector(12 downto 0) :="0000000000001" ;
constant zeros				: std_logic_vector(12 downto 0) := (others => '0');

begin

inst_IN <= reg_IF_OUT(27 downto 12);

aux_ADD_RWC <= inst_IN(13 downto 11);
aux_ADD_RA  <= inst_IN(5 downto 3);
aux_ADD_RB  <= inst_IN(2 downto 0);

aux_ADD_RA_C <= aux_ADD_RWC when (inst_IN(15) and inst_IN(14)) = '1' else
				aux_ADD_RA;

--------------------------------------------------------------------------
------ Conjuntos de instrucções ------------------------------------------
------ Inst_IN(15:14)           ------------------------------------------
------ 0 0 => Transferencia de Controlo    -------------------------------
------ 0 1 => Constantes Formato I		    -------------------------------
------ 1 0 => Instrucoes para ALU/Memoria  -------------------------------
------ 1 1 => Constante Formato II		    -------------------------------
--------------------------------------------------------------------------

aux_active_FLAGTEST <= inst_IN(15) or inst_IN(14); --- Activa a FLAGTESTE
--------------------------------------------------------------------------
-------- 0 0 -> Transferência de Controlo --------------------------------
-------- exitsem 3 formatos ----------------------------------------------
--------------------------------------------------------------------------
aux_TRANS_OP 		<= inst_IN(13 downto 12);

-------- 0 0/ 0 1 -> Formato I condicional -------------------------------
aux_TRANS_FI_COND 	<= inst_IN(12 downto 8);
aux_TRANS_FI_DES 	<= (11 downto 8 => inst_IN(7)) & inst_IN(7 downto 0);

-------- 1 0 -> Formato II incondicional ---------------------------------
aux_TRANS_FII_DES	<= inst_IN(11 downto 0);

-------- 1 1 -> Formato III jumps ----------------------------------------
aux_JUMPS_active 	<= not(aux_active_FLAGTEST) and inst_IN(13) and inst_IN(12); ----- TESTE de activação do FIII, escolhe o mux2:1
aux_JUMPS_MUX_WB 	<= not(inst_IN(11)) and aux_JUMPS_active;

-------------Escolha da constante do destino-----------------------------
 
aux_TRANS_DES <= aux_TRANS_FI_DES when aux_TRANS_OP(1) = '0'  else
				 aux_TRANS_FII_DES;


--------------------------------------------------------------------------
-------- 0 1 -> Constantes	Formato I   -----------------------------------
--------------------------------------------------------------------------

ALU_CONS_SEL		<=  inst_IN(14);
aux_CONS_FI_RWC 	<= 	inst_IN(13 downto 11);
aux_CONS_FI_11B 	<= 	inst_IN(10 downto 0 );


--------------------------------------------------------------------------
-------- 1 0 -> Instrucções para a ALU/Memoria ----------------------------
--------------------------------------------------------------------------

aux_ALU_OPER		<=	inst_IN(10 downto 6);

--------------------------------------------------------------------------
-------- 1 1 -> Constantes	Formato II  -----------------------------------
--------------------------------------------------------------------------
aux_CONS_FII_R		<=	inst_IN(10);
aux_CONS_FII_8B		<=	inst_IN(7 downto 0);


--------------------------------------------------------------------------
-------------------------- Operand Fetch  --------------------------------
--------------------------------------------------------------------------
RA_C <= R0 when aux_ADD_RA_C = "000" else 
		R1 when aux_ADD_RA_C = "001" else
		R2 when aux_ADD_RA_C = "010" else
		R3 when aux_ADD_RA_C = "011" else
		R4 when aux_ADD_RA_C = "100" else
		R5 when aux_ADD_RA_C = "101" else
		R6 when aux_ADD_RA_C = "110" else
		R7;
			 
RB <= 	R0 when aux_ADD_RB = "000" else 	
		R1 when aux_ADD_RB = "001" else
		R2 when aux_ADD_RB = "010" else
		R3 when aux_ADD_RB = "011" else
		R4 when aux_ADD_RB = "100" else
		R5 when aux_ADD_RB = "101" else
		R6 when aux_ADD_RB = "110" else
		R7;

oper_A <=	RA_C; 	-- operando A da ALU
oper_B <=	RB;		-- operando B da ALU

const11 <= (15 downto 11 => aux_CONS_FI_11B(11)) & aux_CONS_FI_11B;	-- loadlit c
lcl <=	RA_C(15 downto 8) & aux_CONS_FII_8B;					-- lcl c
lch <=	aux_CONS_FII_8B & RA_C(7 downto 0);						-- lch c

select_mux_constantes <= inst_IN(15) & inst_IN(10);

out_mux_constantes <=	const11		when select_mux_constantes = "00" else
						const11		when select_mux_constantes = "01" else
						lcl 		when select_mux_constantes = "10" else
						lch;

ALU_vs_MEM <= aux_ALU_OPER(1) and not(aux_ALU_OPER(2)) and aux_ALU_OPER(3) and not(aux_ALU_OPER(0));

WE_RAM <= (inst_IN(15) and not(inst_IN(14))) and ALU_vs_MEM and inst_IN(6);

JUMP_MUXPC_OUT <= aux_JUMPS_active;
JUMP_MUXWB_OUT <= aux_JUMPS_MUX_WB;
destino_cond   <= aux_TRANS_DES;
destino_jump   <= oper_B(11 downto 0);

aux_IDOF_bit15 <= inst_IN(15);

--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------

--------------- registo de saída do segundo andar: ID e OF ---------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				reg_IDOF_OUT <= zeros;
			else
				reg_IDOF_OUT <= aux_IDOF_bit15 & WE_RAM & aux_active_FLAGTEST & aux_ALU_OPER & ALU_vs_MEM & reg_IF_OUT(11 downto 0) & JUMP_MUXWB_OUT & aux_ADD_RWC & 
								oper_A & oper_B & out_mux_constantes & ALU_CONS_SEL;
				-- reg_IDOF_OUT <= aux_IDOF_bit15 & WE_RAM & FLAGTEST_active_OUT & aux_ALU_OPER & ALU_vs_MEM & save_pc_add_1 & JUMP_MUXWB_OUT & aux_ADD_RWC & 
				--                 oper_A & oper_B & out_mux_constantes & ALU_CONS_SEL;
			end if;	
		end if;
end process;
			 
end Behavioral;