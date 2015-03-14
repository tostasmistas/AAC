library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EXeMEM is
	port(
		-- input
		clk, rst 					: in std_logic;
		reg_IDOF_OUT				: in std_logic_vector(70 downto 0);			-- registo entre andares
		FLAGS_IN					: in std_logic_vector(3 downto 0);
		TRANS_OP					: in std_logic_vector(1 downto 0);
		TRANS_FI_COND_IN			: in std_logic_vector(3 downto 0);
		FLAGTEST_active_IN			: in std_logic;

		-- output
		reg_EXMEM_OUT				: out std_logic_vector(66 downto 0);	
		REG_WC            			: out std_logic_vector(15 downto 0);
		FLAGS_OUT					: out std_logic_vector(3 downto 0);
		FLAGTEST_MUXPC_OUT			: out std_logic 							-- registo entre andares
	);
end EXeMEM;

architecture Behavioral of EXeMEM is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal out_ALU					: std_logic_vector(15 downto 0) := (others => '0'); -- saída da ALU
signal out_MEM					: std_logic_vector(15 downto 0) := (others => '0'); -- saída da memória
signal aux_FLAGS				: std_logic_vector(3 downto 0) := (others => '0'); 	-- Z,N,C,O
signal aux_act_FLAGS			: std_logic_vector(3 downto 0) := (others => '0'); 	-- Z,N,C,O
signal aux_MSR_FLAGS			: std_logic_vector(3 downto 0) := (others => '0');
signal aux_FLAGTEST				: std_logic := '0';
signal operando_A				: std_logic_vector(15 downto 0) := (others => '0');
signal operando_B				: std_logic_vector(15 downto 0) := (others => '0');
signal oper_ALU					: std_logic_vector(4 downto 0) := (others => '0');
signal p_ALU					: std_logic_vector(15 downto 0) := (others => '0');
signal sel_mux_q				: std_logic_vector(1 downto 0) := (others => '0');
signal q_ALU					: std_logic_vector(15 downto 0) := (others => '0');
signal cIN_ALU					: std_logic := '0';
signal out_ARI					: std_logic_vector(16 downto 0) := (others => '0');
signal out_LOG					: std_logic_vector(15 downto 0) := (others => '0');
signal out_SHIFT					: std_logic_vector(15 downto 0) := (others => '0');
signal sel_mux_LOG				: std_logic_vector(2 downto 0) := (others => '0');
signal sel_mux_ALU				: std_logic_vector(1 downto 0) := (others => '0');
signal aux_sel_mux_ALU_bit0		: std_logic := '0';
signal aux_FLAGMUX 			: std_logic;
signal aux_FLAGTEST_FI : std_logic;
signal aux_FLAGTEST_MUXPC : std_logic;
signal aux_flagtest_rel			: std_logic := '0';

--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant zeros					: std_logic_vector(3 downto 0) := (others => '0');
constant menusum				: std_logic_vector(15 downto 0) :=(others => '1');
constant zeros_ALU				: std_logic_vector(15 downto 0) := (others => '0');

begin

---------------------------------------------------------------------------------------------
---------------------------------- MEMÓRIA --------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
----------------------------------- ALU -----------------------------------------------------
---------------------------------------------------------------------------------------------

operando_A 	<= reg_IDOF_OUT(48 downto 33);
operando_B 	<= reg_IDOF_OUT(32 downto 17);
oper_ALU 	<= reg_IDOF_OUT(70 downto 66);

----------------------------------- aritméticas ---------------------------------------------

p_ALU <= operando_A; 

sel_mux_q <= oper_ALU(2) & oper_ALU(1);

q_ALU <= operando_B			when sel_mux_q = "00" else
		 menusum			when sel_mux_q = "01" else
		 not(operando_B) 	when sel_mux_q = "10" else
		 zeros_ALU;	 

cIN_ALU <= oper_ALU(0);
		
out_ARI <= p_ALU + q_ALU + cIN_ALU;

--------------------------------------- lógicas ---------------------------------------------

sel_mux_LOG <= (oper_ALU(3) xor oper_ALU(0))&(oper_ALU(3) xor oper_ALU(1))&(oper_ALU(3) xor oper_ALU(2));

out_LOG <=  zeros_ALU									when sel_mux_LOG = "000" else
			operando_A and operando_B					when sel_mux_LOG = "001" else
			not(operando_A) and operando_B				when sel_mux_LOG = "010" else
			operando_B									when sel_mux_LOG = "011" else
			not(operando_A) and operando_B				when sel_mux_LOG = "100" else
			operando_A									when sel_mux_LOG = "101" else
			operando_A xor operando_B					when sel_mux_LOG = "110" else
			operando_A or operando_B;		

---------------------------------------- shifts ---------------------------------------------

--out_SHIFT <= operando_A sll 1 when oper_ALU(0) = '0' else
	--		    operando_A sra 1;

---------------------------------- resultado final da ALU -----------------------------------

sel_mux_ALU <= oper_ALU(4) & oper_ALU(3);

out_ALU <=	out_ARI			when sel_mux_ALU = "00" 	else
			out_SHIFT 		when sel_mux_ALU = "01"		else
			out_LOG 		when sel_mux_ALU = "10"		else
			not(out_LOG);

-------------------------------QUAIS FLAGS ATUALIZAM??---------------------------------------

--Sign_FLAG(1) <=  not(ALU_OP(4));

--Sign_FLAG(0) <=  (ALU_OP(2) and (not(ALU_OP(1)) or ALU_OP(2))) or (ALU_OP(4) and (not(ALU_OP(2)) and ((not(ALU_OP(1)) and ALU_OP(0)) or ALU_OP(3)))) or ((ALU_OP(4)) nor ALU_OP(3)) or (not(ALU_OP(0)) and ALU_OP(1));

--aux_act_FLAGS <= "0000"	when Sign_FLAG ="00" else 
	--			"1100" 	when Sign_FLAG ="01" else 
		--		"0111" 	when Sign_FLAG ="10" else 
			--	"1111";

--Actualizar FLAGS
--OVERFLOW
--aux_FLAGS(0) <= FLAGS_IN(0) when (aux_act_FLAGS(0)=0) else
	--			'1' 		when ((p_ALU(15)=q_ALU(15)) and (p_ALU(15)=q_ALU(15))) else 
		--		'0';

--CARRY
--aux_FLAGS(1) <= FLAGS_IN(1) when (aux_act_FLAGS(1)=0) else
	--			'1' 		when (out_ALU(16)=1) else 
		--		'0';

--NEGATIVE
--aux_FLAGS(2) <= FLAGS_IN(2) when (aux_act_FLAGS(2)=2) else
	--			'1' 		when (out_ALU(15)=1) else 
		--		'0';

--ZERO
--aux_FLAGS(2) <= FLAGS_IN(2) when (aux_act_FLAGS(2)=2) else
	--			'1' 		when (out_ALU="00000000000000000") else 
		--		'0';


---------------------------------------------------------------------------------------------
---------------------------------- TESTE FLAGS ----------------------------------------------
---------------------------------------------------------------------------------------------
aux_FLAGMUX	 <= 	FLAGS_IN(0) 						when TRANS_FI_COND_IN = "0101" else
					FLAGS_IN(1)					when TRANS_FI_COND_IN = "0100" else
					FLAGS_IN(2) 					when TRANS_FI_COND_IN = "0110" else
					FLAGS_IN(3) 					when TRANS_FI_COND_IN = "0011" else
					'1' 	 	 					when TRANS_FI_COND_IN = "0000" else
					FLAGS_IN(0) or aux_FLAGS(1) 	when TRANS_FI_COND_IN = "0111" else
					'0';


aux_FLAGTEST_FI <= aux_FLAGMUX xnor TRANS_OP(1);

aux_FLAGTEST    <= (TRANS_OP(1) and not(TRANS_OP(0))) or (aux_FLAGTEST_FI and not(TRANS_OP(1))); 

aux_FLAGTEST_MUXPC <= not(FLAGTEST_active_IN) and aux_FLAGTEST; 

---------------------------------------------------------------------------------------------
----------------------------------- REGISTO FLAGS -------------------------------------------
---------------------------------------------------------------------------------------------

process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_MSR_FLAGS <= zeros;
			else
				aux_MSR_FLAGS <= aux_FLAGS;
			end if;		
		end if;
end process;


FLAGS_OUT <= aux_MSR_FLAGS;
FLAGTEST_MUXPC_OUT <= aux_FLAGTEST_MUXPC;


--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------

--------------- registo de saída do terceiro andar: EX e MEM -------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				reg_EXMEM_OUT <= zeros;
			else
				reg_EXMEM_OUT <= out_MEM & reg_IDOF_OUT(64 downto 53) & reg_IDOF_OUT(52) & reg_IDOF_OUT(51 downto 49) & out_ALU & reg_IDOF_OUT(16 downto 1) & reg_IDOF_OUT(0);
				-- reg_EXMEM_OUT <= out_MEM & save_pc_add_1 & JUMP_MUXWB_OUT & aux_ADD_RWC & out_ALU & out_mux_constantes & ALU_CONS_SEL;
			end if;	
		end if;
end process;

end Behavioral;

