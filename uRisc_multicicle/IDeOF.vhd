library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IDeOF is
	port(
		-- input
		clk, rst 				: in std_logic;
		reg_IfOut_PC 			: in std_logic_vector(11 downto 0);		-- registo entre andares
		reg_IfOut_ROM 			: in std_logic_vector(15 downto 0);	
		FLAGS_IN				: in std_logic_vector(3 downto 0);
		ADD_RWC_EXMEM			: in std_logic_vector(2 downto 0);
		ADD_RWC_WB				: in std_logic_vector(2 downto 0);
		ovWE_EXMEM				: in std_logic;
		ovWE_WB					: in std_logic;
		en_idOF	 				: in std_logic;
		R0 						: in std_logic_vector(15 downto 0);
		R1 						: in std_logic_vector(15 downto 0);
	    R2 						: in std_logic_vector(15 downto 0);
		R3 						: in std_logic_vector(15 downto 0);
		R4 						: in std_logic_vector(15 downto 0);
		R5 						: in std_logic_vector(15 downto 0);
		R6 						: in std_logic_vector(15 downto 0);
		R7 						: in std_logic_vector(15 downto 0);
		Conflit_OFF				: in std_logic;
		
		-- output
		Conflit_ON				: out std_logic;					
		pc_add_jump				: out std_logic_vector(11 downto 0);
		reg_IDOF_OUT_WERAM		: out std_logic;
		reg_IDOF_OUT_ALUOPER	: out std_logic_vector(4 downto 0);
		reg_IDOF_OUT_bit15		: out std_logic;
		reg_IDOF_OUT_bit14		: out std_logic;
		reg_IDOF_OUT_OperA		: out std_logic_vector(15 downto 0);
		reg_IDOF_OUT_OperB		: out std_logic_vector(15 downto 0);
		reg_IDOF_OUT_ALUvsMEM	: out std_logic;
		reg_IDOF_OUT_ovWE	: out std_logic;
		reg_IDOF_OUT_AddRWC		: out std_logic_vector(2 downto 0);
		reg_IDOF_OUT_PCadd1		: out std_logic_vector(11 downto 0);
		reg_IDOF_OUT_SelMuxWB	: out std_logic_vector(1 downto 0);
		reg_IDOF_OUT_MuxConst	: out std_logic_vector(15 downto 0)
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
signal aux_CONS_FI_11B		: std_logic_vector(10 downto 0) := (others => '0');
signal aux_CONS_FII_8B		: std_logic_vector(7 downto 0) := (others => '0');
signal aux_active_FLAGTEST	: std_logic := '0';
signal aux_FLAGMUX 			: std_logic := '0';
signal aux_TRANS_OP			: std_logic_vector(1 downto 0) := (others => '0');
signal aux_TRANS_FI_DES 	: std_logic_vector(11 downto 0) := (others => '0');
signal aux_TRANS_FII_DES	: std_logic_vector(11 downto 0) := (others => '0');
signal aux_TRANS_DES		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_TRANS_FIII_R	  	: std_logic := '0';
signal aux_JUMPS_active		: std_logic := '0';
signal aux_JUMPS_MUX_WB		: std_logic := '0';
signal aux_TEST_NOP			: std_logic := '0';
signal aux_FLAGTEST 		: std_logic := '0';
signal aux_FLAGTEST_MUXPC 	: std_logic := '0';
signal JUMP_MUXWB_OUT		: std_logic := '0';
signal ALU_vs_MEM			: std_logic := '0';
signal RA_C 				: std_logic_vector(15 downto 0) := (others => '0');
signal RB 					: std_logic_vector(15 downto 0) := (others => '0');
signal oper_A				: std_logic_vector(15 downto 0):= (others => '0');	-- operando A para a ALU
signal oper_B				: std_logic_vector(15 downto 0):= (others => '0');	-- operando B para a ALU
signal const11				: std_logic_vector(15 downto 0):= (others => '0');	-- operando B para a ALU
signal lcl 					: std_logic_vector(15 downto 0):= (others => '0');	-- operando B para a ALU
signal lch 					: std_logic_vector(15 downto 0):= (others => '0');	-- operando B para a ALU
signal select_mux_constantes: std_logic_vector(1 downto 0):= (others => '0');
signal out_mux_constantes	: std_logic_vector(15 downto 0):= (others => '0');	-- operando para carregamento de constantes		
signal bit14				: std_logic := '0'; 				-- sinal de selecção para MUX entre operação da ALU e operação de carregamento de constantes
signal bit15				: std_logic := '0';
signal WE_RAM				: std_logic := '0';
signal TRANS_FI_COND_IN		: std_logic_vector(3 downto 0) := (others => '0');
signal pc_add1				: std_logic_vector(11 downto 0):= (others => '0');
signal mux_jump_cond		: std_logic_vector(1 downto 0) := (others => '0');
signal aux_saida_mux		: std_logic_vector(11 downto 0):= (others => '0');
signal ALU_e_MEM			: std_logic := '0';
signal soMEM				: std_logic := '0';
signal soALU				: std_logic := '0';
signal loadMEM				: std_logic := '0';
signal controlo				: std_logic := '0';
signal controloJump			: std_logic := '0';
signal ovWE						: std_logic := '0';
signal aux_sel_bit1			: std_logic := '0';
signal aux_sel_bit0			: std_logic := '0';
signal sel_mux_WB				: std_logic_vector(1 downto 0) := (others => '0');
signal aux_reg_IDOF_OUT_WERAM		: std_logic := '0' ;
signal aux_reg_IDOF_OUT_ALUOPER		: std_logic_vector(4 downto 0) := (others => '0');
signal aux_reg_IDOF_OUT_bit15		: std_logic :='0';
signal aux_reg_IDOF_OUT_bit14		: std_logic :='0';
signal aux_reg_IDOF_OUT_OperA		: std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_IDOF_OUT_OperB		: std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_IDOF_OUT_ALUvsMEM	: std_logic :='0';
signal aux_reg_IDOF_OUT_ovWE		: std_logic :='0';
signal aux_reg_IDOF_OUT_AddRWC		: std_logic_vector(2 downto 0) := (others => '0');
signal aux_reg_IDOF_OUT_PCadd1		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_reg_IDOF_OUT_SelMuxWB	: std_logic_vector(1 downto 0) := (others => '0');
signal aux_reg_IDOF_OUT_MuxConst	: std_logic_vector(15 downto 0) := (others => '0');
--Conflito
signal RA_EXMEM_CONFLITO : std_logic :='0';
signal RA_WB_CONFLITO : std_logic :='0';
signal RB_EXMEM_CONFLITO : std_logic :='0';
signal RB_WB_CONFLITO : std_logic :='0';
signal aux_Conflit_ON : std_logic :='0';


--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant one					: std_logic_vector(12 downto 0) :="0000000000001" ;
constant zero_12				: std_logic_vector(11 downto 0) := (others => '0');
constant zero_16				: std_logic_vector(15 downto 0) := (others => '0');

begin

inst_IN  <=  reg_IfOut_ROM;
pc_add1  <=  reg_IfOut_PC;

aux_ADD_RWC <= inst_IN(13 downto 11);
aux_ADD_RA  <= inst_IN(5 downto 3);
aux_ADD_RB  <= inst_IN(2 downto 0);

aux_ADD_RA_C <= aux_ADD_RWC when (inst_IN(15) and inst_IN(14)) = '1' else
				aux_ADD_RA;

--------------------------------------------------------------------------
------------------------ Id conflito -------------------------------------
--------------------------------------------------------------------------

RA_EXMEM_CONFLITO	<=	((ADD_RWC_EXMEM(2) XNOR aux_ADD_RA(2)) XNOR (ADD_RWC_EXMEM(1) XNOR aux_ADD_RA(1)) XNOR (ADD_RWC_EXMEM(0) XNOR aux_ADD_RA(0)))  and ovWE_EXMEM;
RA_WB_CONFLITO	   	<=	((ADD_RWC_WB(2) XNOR aux_ADD_RA(2)) XNOR (ADD_RWC_WB(1) XNOR aux_ADD_RA(1)) XNOR (ADD_RWC_WB(0) XNOR aux_ADD_RA(0)))  and ovWE_WB;

RB_EXMEM_CONFLITO	<=	((ADD_RWC_EXMEM(2) XNOR aux_ADD_RB(2)) XNOR (ADD_RWC_EXMEM(1) XNOR aux_ADD_RB(1)) XNOR (ADD_RWC_EXMEM(0) XNOR aux_ADD_RB(0)))  and ovWE_EXMEM;
RB_WB_CONFLITO	   	<=	((ADD_RWC_WB(2) XNOR aux_ADD_RB(2)) XNOR (ADD_RWC_WB(1) XNOR aux_ADD_RB(1)) XNOR (ADD_RWC_WB(0) XNOR aux_ADD_RB(0)))  and ovWE_WB;

aux_Conflit_ON 		<= 	RA_WB_CONFLITO OR  RA_EXMEM_CONFLITO OR RB_WB_CONFLITO OR RB_EXMEM_CONFLITO;
--------------------------------------------------------------------------
------ Conjuntos de instrucções ------------------------------------------
------ Inst_IN(15:14)           ------------------------------------------
------ 0 0 => Transferencia de Controlo    -------------------------------
------ 0 1 => Constantes Formato I		    -------------------------------
------ 1 0 => Instrucoes para ALU/Memoria  -------------------------------
------ 1 1 => Constante Formato II		    -------------------------------
--------------------------------------------------------------------------

aux_active_FLAGTEST <= inst_IN(15) or inst_IN(14); --- Activa a FLAGTESTE
aux_TEST_NOP <= inst_IN(15) or inst_IN(14) or inst_IN(13) or inst_IN(12) or
							inst_IN(11) or inst_IN(10) or inst_IN(9) or inst_IN(8) or
							inst_IN(7) or inst_IN(6) or inst_IN(5) or inst_IN(4) or
							inst_IN(3) or inst_IN(2) or inst_IN(1) or inst_IN(0);
--------------------------------------------------------------------------
-------- 0 0 -> Transferência de Controlo --------------------------------
-------- exitsem 3 formatos ----------------------------------------------
--------------------------------------------------------------------------
aux_TRANS_OP 		<= inst_IN(13 downto 12);

-------- 0 0/ 0 1 -> Formato I condicional -------------------------------

aux_TRANS_FI_DES 	<= (11 downto 8 => inst_IN(7)) & inst_IN(7 downto 0);
TRANS_FI_COND_IN 	<= inst_IN(11 downto 8 );

-------- 1 0 -> Formato II incondicional ---------------------------------
aux_TRANS_FII_DES	<= inst_IN(11 downto 0);

-------- 1 1 -> Formato III jumps ----------------------------------------
aux_JUMPS_active 	<= not(aux_active_FLAGTEST) and inst_IN(13) and inst_IN(12); ----- TESTE de activação do FIII, escolhe o mux2:1
aux_JUMPS_MUX_WB 	<= not(inst_IN(11)) and aux_JUMPS_active;

-------------Escolha da constante do destino-----------------------------
 
aux_TRANS_DES <= aux_TRANS_FI_DES  + pc_add1 when aux_TRANS_OP(1) = '0'  else
				     aux_TRANS_FII_DES + pc_add1;


--------------------------------------------------------------------------
-------- 0 1 -> Constantes	Formato I   -----------------------------------
--------------------------------------------------------------------------

aux_CONS_FI_11B 	<= 	inst_IN(10 downto 0 );


--------------------------------------------------------------------------
-------- 1 0 -> Instrucções para a ALU/Memoria ----------------------------
--------------------------------------------------------------------------

aux_ALU_OPER		<=	inst_IN(10 downto 6);

--------------------------------------------------------------------------
-------- 1 1 -> Constantes	Formato II  -----------------------------------
--------------------------------------------------------------------------
aux_CONS_FII_8B	<=	inst_IN(7 downto 0);


---------------------------------------------------------------------------------------------
---------------------------------- TESTE FLAGS ----------------------------------------------
---------------------------------------------------------------------------------------------
aux_FLAGMUX	 <=FLAGS_IN(3) 					when TRANS_FI_COND_IN = "0101" else
					FLAGS_IN(2)						when TRANS_FI_COND_IN = "0100" else
					FLAGS_IN(1) 					when TRANS_FI_COND_IN = "0110" else
					FLAGS_IN(0) 					when TRANS_FI_COND_IN = "0011" else
					'1' 	 	 					   when TRANS_FI_COND_IN = "0000" else
					FLAGS_IN(3) or FLAGS_IN(2) when TRANS_FI_COND_IN = "0111" else
					'0';

aux_FLAGTEST    <= (not(aux_TRANS_OP(1)) and aux_TRANS_OP(0) and aux_FLAGMUX) or (not(aux_TRANS_OP(0))and not(aux_FLAGMUX) ) or (aux_TRANS_OP(1) and not(aux_TRANS_OP(0))); 

aux_FLAGTEST_MUXPC <=  not(aux_active_FLAGTEST) and aux_FLAGTEST and aux_TEST_NOP; 

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

const11 <= (15 downto 11 => aux_CONS_FI_11B(10)) & aux_CONS_FI_11B;	-- loadlit c
lcl <=	RA_C(15 downto 8) & aux_CONS_FII_8B;					-- lcl c
lch <=	aux_CONS_FII_8B & RA_C(7 downto 0);						-- lch c

select_mux_constantes <= inst_IN(15) & inst_IN(10);

out_mux_constantes <=			const11		when select_mux_constantes = "00" else
										const11		when select_mux_constantes = "01" else
											lcl 		when select_mux_constantes = "10" else
										lch;

ALU_vs_MEM <= (aux_ALU_OPER(1) and not(aux_ALU_OPER(2))) and (aux_ALU_OPER(3) and not(aux_ALU_OPER(4)));

WE_RAM <= (inst_IN(15) and not(inst_IN(14))) and (ALU_vs_MEM and inst_IN(6));



bit15 <= inst_IN(15);
bit14 <=  inst_IN(14);

-------------------------------------------------------------------------
--------------Saltos Condicionais e incodicionais------------------------
-------------------------------------------------------------------------

mux_jump_cond	<= aux_FLAGTEST_MUXPC&aux_JUMPS_active;				
	
aux_saida_mux <= oper_B(11 downto 0) when mux_jump_cond	= "01" else
					  aux_TRANS_DES 		 when mux_jump_cond	= "10" else
					  pc_add1;

--------------------------------------------------------------------------
-------------------Andar WB-- Wirte enable do registo de saida-------------
-------------------------------------------------------------------------- 

ALU_e_MEM <= (inst_IN(15) and (not(inst_IN(14))));

soMEM <= ALU_e_MEM and ALU_vs_MEM;

soALU <= ALU_e_MEM and not(ALU_vs_MEM);

loadMEM <= soMEM and not(inst_IN(6));

controlo <= inst_IN(14) nor inst_IN(15);

controloJump <= controlo and JUMP_MUXWB_OUT;

ovWE <= (soALU or loadMEM) or (controloJump or inst_IN(14));


aux_sel_bit1 <= JUMP_MUXWB_OUT or inst_IN(14);
				-- JUMP_MUXWB_OUT or inst_IN(14)

aux_sel_bit0 <= JUMP_MUXWB_OUT or (not(Inst_IN(14)) and ALU_vs_MEM) ;
				-- JUMP_MUXWB_OUT or (not(inst_IN(14)) and ALU_vs_MEM)

sel_mux_WB <= aux_sel_bit1&aux_sel_bit0;
--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------

JUMP_MUXWB_OUT 		<= aux_JUMPS_MUX_WB;
pc_add_jump			<= aux_saida_mux;
--------------- registo de saída do segundo andar: ID e OF ---------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1'  then
				aux_reg_IDOF_OUT_bit15 		<= '0'; --need
				aux_reg_IDOF_OUT_bit14 		<= '0';
				aux_reg_IDOF_OUT_WERAM 		<= '0';-- need
				aux_reg_IDOF_OUT_ALUOPER	<= "00000"; --need
				aux_reg_IDOF_OUT_ALUvsMEM	<= '0';--need
				aux_reg_IDOF_OUT_PCadd1 	<= zero_12;--need
				aux_reg_IDOF_OUT_SelMuxWB 	<= "00"; --add 
				aux_reg_IDOF_OUT_AddRWC 	<= "000"; -- need
				aux_reg_IDOF_OUT_OperA 		<=	zero_16; --need
				aux_reg_IDOF_OUT_OperB 		<= zero_16; --need
				aux_reg_IDOF_OUT_MuxConst	<= zero_16;
				aux_reg_IDOF_OUT_ovWE       <= '0';
			elsif en_idOF = '1' then
				if  NOT(Conflit_OFF) = '1' then
					aux_reg_IDOF_OUT_bit15 		<= '0'; --need
					aux_reg_IDOF_OUT_bit14 		<= '0';
					aux_reg_IDOF_OUT_WERAM 		<= '0';-- need
					aux_reg_IDOF_OUT_ALUOPER	<= "00000"; --need
					aux_reg_IDOF_OUT_ALUvsMEM	<= '0';--need
					aux_reg_IDOF_OUT_PCadd1 	<= zero_12;--need
					aux_reg_IDOF_OUT_SelMuxWB 	<= "00"; --add 
					aux_reg_IDOF_OUT_AddRWC 	<= "000"; -- need
					aux_reg_IDOF_OUT_OperA 		<= zero_16; --need
					aux_reg_IDOF_OUT_OperB 		<= zero_16; --need
					aux_reg_IDOF_OUT_MuxConst	<= zero_16;
					aux_reg_IDOF_OUT_ovWE       <= '0';
				else
					aux_reg_IDOF_OUT_bit15 		<= bit15; --need
					aux_reg_IDOF_OUT_bit14 		<= bit14;
					aux_reg_IDOF_OUT_WERAM 		<= WE_RAM;-- need
					aux_reg_IDOF_OUT_ALUOPER	<= aux_ALU_OPER; --need
					aux_reg_IDOF_OUT_ALUvsMEM	<= ALU_vs_MEM;--need
					aux_reg_IDOF_OUT_PCadd1 	<= pc_add1;--need
					aux_reg_IDOF_OUT_SelMuxWB 	<= sel_mux_WB; --add 
					aux_reg_IDOF_OUT_AddRWC 	<= aux_ADD_RWC; -- need
					aux_reg_IDOF_OUT_OperA 		<=	oper_A; --need
					aux_reg_IDOF_OUT_OperB 		<= oper_B; --need
					aux_reg_IDOF_OUT_MuxConst	<= out_mux_constantes;
					aux_reg_IDOF_OUT_ovWE       <= ovWE;
				end if;
			end if;	
		end if;
end process;

reg_IDOF_OUT_bit15 		<= aux_reg_IDOF_OUT_bit15; --need
reg_IDOF_OUT_bit14 		<= aux_reg_IDOF_OUT_bit14;
reg_IDOF_OUT_WERAM 		<= aux_reg_IDOF_OUT_WERAM;-- need
reg_IDOF_OUT_ALUOPER		<= aux_reg_IDOF_OUT_ALUOPER; --need
reg_IDOF_OUT_ALUvsMEM	<= aux_reg_IDOF_OUT_ALUvsMEM;--need
reg_IDOF_OUT_PCadd1 		<= aux_reg_IDOF_OUT_PCadd1;--need
reg_IDOF_OUT_SelMuxWB 	<= aux_reg_IDOF_OUT_SelMuxWB; --add 
reg_IDOF_OUT_AddRWC 		<= aux_reg_IDOF_OUT_AddRWC; -- need
reg_IDOF_OUT_OperA 		<= aux_reg_IDOF_OUT_OperA; --need
reg_IDOF_OUT_OperB 		<= aux_reg_IDOF_OUT_OperB; --need
reg_IDOF_OUT_MuxConst	<= aux_reg_IDOF_OUT_MuxConst;
reg_IDOF_OUT_ovWE			<= aux_reg_IDOF_OUT_ovWE;
Conflit_ON					<= aux_Conflit_ON;
			 
end Behavioral;