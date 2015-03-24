library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EXeMEM is
	port(
		-- input
		clk, rst 					: in std_logic;
		reg_IDOF_OUT				: in std_logic_vector(73 downto 0);			-- registo entre andares
		FLAGS_IN					: in std_logic_vector(3 downto 0);
		out_RAM						: in std_logic_vector(15 downto 0);
		en_registo 					: in std_logic;
		
		-- output
		reg_EXMEM_OUT				: out std_logic_vector(67 downto 0);		-- registo entre andares
		out_ADD_MEM					: out std_logic_vector(11 downto 0);		-- para endereçar a RAM
		out_WE_MEM					: out std_logic;							-- para controlar o WE da RAM 
		FLAGS_OUT					: out std_logic_vector(3 downto 0);
		FLAGSTEST_OUT				: out std_logic_vector(3 downto 0);
		in_RAM						: out std_logic_vector(15 downto 0)
								
	);
end EXeMEM;

architecture Behavioral of EXeMEM is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal out_ALU					: std_logic_vector(15 downto 0) := (others => '0'); -- saída da ALU
signal out_MEM					: std_logic_vector(15 downto 0) := (others => '0'); -- saída da memória
signal aux_FLAGS_ARI			: std_logic_vector(3 downto 0) := (others => '0'); 	-- Z,N,C,O
signal aux_FLAGS_SHIFT			: std_logic_vector(2 downto 0) := (others => '0'); 	-- Z,N,C
signal aux_FLAGS_LOG			: std_logic_vector(1 downto 0) := (others => '0'); 	-- Z,N
signal aux_FLAGS				: std_logic_vector(3 downto 0) := (others => '0'); 	-- Z,N,C,O
signal aux_MSR_FLAGS			: std_logic_vector(3 downto 0) := (others => '0');
signal operando_A				: std_logic_vector(15 downto 0) := (others => '0');
signal operando_B				: std_logic_vector(15 downto 0) := (others => '0');
signal oper_ALU					: std_logic_vector(4 downto 0) := (others => '0');
signal p_ALU					: std_logic_vector(15 downto 0) := (others => '0');
signal sel_mux_q				: std_logic_vector(1 downto 0) := (others => '0');
signal q_ALU					: std_logic_vector(15 downto 0) := (others => '0');
signal cIN_ALU					: std_logic := '0';
signal out_ARI					: std_logic_vector(16 downto 0) := (others => '0');
signal out_LOG					: std_logic_vector(15 downto 0) := (others => '0');
signal out_SHIFT				: std_logic_vector(16 downto 0) := (others => '0');
signal sel_mux_LOG				: std_logic_vector(2 downto 0) := (others => '0');
signal sel_mux_ALU				: std_logic_vector(1 downto 0) := (others => '0');
signal aux_sel_mux_ALU_bit0		: std_logic := '0';
signal aux_FLAGMUX 				: std_logic := '0';
signal aux_flagtest_rel			: std_logic := '0';
signal TRANS_OP					: std_logic_vector(1 downto 0) := (others => '0');
signal TRANS_FI_COND_IN			: std_logic_vector(3 downto 0) := (others => '0');
signal FLAGTEST_active_IN	    : std_logic := '0';		
signal aux_EXMEM_bit6			: std_logic := '0';
signal aux_EXMEM_bit15 			: std_logic := '0';
signal Sign_FLAG					: std_logic_vector(1 downto 0) := (others => '0');
signal aux_Sign_FLAG					: std_logic_vector(1 downto 0) := (others => '0');
signal out_ADD_MEM_aux			: std_logic_vector(11 downto 0) := (others => '0');
signal out_WE_MEM_aux			: std_logic := '0';
signal aux_reg_EXMEM_OUT		: std_logic_vector(67 downto 0) := (others => '0');

--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant zeros					: std_logic_vector(67 downto 0) := (others => '0');
constant zeros_4				: std_logic_vector(3 downto 0) :=(others => '0');
constant menusum				: std_logic_vector(15 downto 0) :=(others => '1');
constant zeros_ALU				: std_logic_vector(15 downto 0) := (others => '0');

begin

operando_A 				<= reg_IDOF_OUT(48 downto 33);
operando_B 				<= reg_IDOF_OUT(32 downto 17);
oper_ALU 				<= reg_IDOF_OUT(70 downto 66);
aux_EXMEM_bit6 		<= reg_IDOF_OUT(66);
aux_EXMEM_bit15		<= reg_IDOF_OUT(73);

---------------------------------------------------------------------------------------------
---------------------------------- MEMÓRIA --------------------------------------------------
---------------------------------------------------------------------------------------------

out_ADD_MEM_aux <= operando_A(11 downto 0); -- para endereçar leitura e escrita da RAM

out_ADD_MEM <= out_ADD_MEM_aux;

out_WE_MEM <= out_WE_MEM_aux; -- write-enable da RAM
out_WE_MEM_aux <= reg_IDOF_OUT(72);
out_MEM <= out_RAM; -- armazenar depois em RC o valor contido na posição de memória endereçada por A

in_RAM <= operando_B; -- armazenar na posição de memória endereçada por A o valor contido em B

---------------------------------------------------------------------------------------------
----------------------------------- ALU -----------------------------------------------------
---------------------------------------------------------------------------------------------

----------------------------------- aritméticas ---------------------------------------------

p_ALU <= operando_A; 

sel_mux_q <= oper_ALU(2) & oper_ALU(1);

q_ALU <= operando_B			when sel_mux_q = "00" else
		 zeros_ALU			when sel_mux_q = "01" else
		 not(operando_B) 	when sel_mux_q = "10" else
		 menusum;	 

cIN_ALU <= oper_ALU(0);

out_ARI <= (p_ALU(15) & p_ALU) + (q_ALU(15) & q_ALU) + cIN_ALU;

--------------------------------------- lógicas ---------------------------------------------

sel_mux_LOG <= (oper_ALU(3) xor oper_ALU(2)) & (oper_ALU(3) xor oper_ALU(1)) & (oper_ALU(3) xor oper_ALU(0));

out_LOG <=  zeros_ALU									when sel_mux_LOG = "000" else
			operando_A and operando_B					when sel_mux_LOG = "001" else
			not(operando_A) and operando_B				when sel_mux_LOG = "010" else
			operando_B									when sel_mux_LOG = "011" else
			operando_A and not(operando_B)				when sel_mux_LOG = "100" else
			operando_A									when sel_mux_LOG = "101" else
			operando_A xor operando_B					when sel_mux_LOG = "110" else
			operando_A or operando_B;		

---------------------------------------- shifts ---------------------------------------------

out_SHIFT <= (operando_A(15 downto 0) & '0') when oper_ALU(0) = '0' else  -- SLL
			 (operando_A(15) & operando_A(15) & operando_A(15 downto 1)); -- SRA

---------------------------------- resultado final da ALU -----------------------------------

sel_mux_ALU <= oper_ALU(4) & oper_ALU(3);

out_ALU <=	out_ARI(15 downto 0)			when sel_mux_ALU = "00" 	else
				out_SHIFT(15 downto 0) 		when sel_mux_ALU = "01"		else
			   out_LOG 		               when sel_mux_ALU = "10"		else
			   not(out_LOG);

---------------------------------------------------------------------------------------------
----------------------------------- FLAGS ---------------------------------------------------
---------------------------------------------------------------------------------------------

-------------------------------QUAIS FLAGS ATUALIZAM??---------------------------------------

aux_Sign_FLAG(1) <=  not(oper_ALU(4));

aux_Sign_FLAG(0) <=  (oper_ALU(2) and (not(oper_ALU(1)) or oper_ALU(2))) or (oper_ALU(4) and (not(oper_ALU(2)) and ((not(oper_ALU(1)) and oper_ALU(0)) or oper_ALU(3)))) or ((oper_ALU(4)) nor oper_ALU(3)) or (not(oper_ALU(0)) and oper_ALU(1));

Sign_FLAG	<=  aux_Sign_FLAG when (aux_EXMEM_bit15 and NOT(reg_IDOF_OUT(0)) and NOT(reg_IDOF_OUT(65))) = '1' else
					 "00";
--Actualizar FLAGS

---------------------------FLAGS DA ARI-----------------------------


--OVERFLOW
aux_FLAGS_ARI(0) <=  (q_ALU(15) xnor p_ALU(15)) and (q_ALU(15) xor out_ALU(15));

--CARRY
aux_FLAGS_ARI(1) <=  out_ARI(16);

--NEGATIVE
aux_FLAGS_ARI(2) <=  out_ARI(15);

--ZERO
aux_FLAGS_ARI(3) <= not(out_ARI(15) or out_ARI(14) or out_ARI(13) or out_ARI(12)or out_ARI(11) 
				 or out_ARI(10) or out_ARI(9) or out_ARI(8) or out_ARI(7) or out_ARI(6) 
				 or out_ARI(5) or out_ARI(4) or out_ARI(3) or out_ARI(2) or out_ARI(1)
				 or out_ARI(0));

------------------------FLAGS LOGICA-------------------------------
--NEGATIVE
aux_FLAGS_LOG(0) <= out_LOG(15);
--ZERO
aux_FLAGS_LOG(1) <= not(out_LOG(15) or out_LOG(14) or out_LOG(13) or out_LOG(12)or out_LOG(11) 
				 or out_LOG(10) or out_LOG(9) or out_LOG(8) or out_LOG(7) or out_LOG(6) 
				 or out_LOG(5) or out_LOG(4) or out_LOG(3) or out_LOG(2) or out_LOG(1)
				 or out_LOG(0));


------------------------FLAGS SHIFT-------------------------------
--CARRY
aux_FLAGS_SHIFT(0) <= out_SHIFT(16);

--NEGATIVE
aux_FLAGS_SHIFT(1) <= out_SHIFT(15);

--ZERO
aux_FLAGS_SHIFT(2)	<= not(out_SHIFT(15) or out_SHIFT(14) or out_SHIFT(13) or out_SHIFT(12)or out_SHIFT(11) 
				 	or out_SHIFT(10) or out_SHIFT(9) or out_SHIFT(8) or out_SHIFT(7) or out_SHIFT(6) 
				 	or out_SHIFT(5) or out_SHIFT(4) or out_SHIFT(3) or out_SHIFT(2) or out_SHIFT(1)
				 	or out_SHIFT(0));
-------------------------------------------------------------------

aux_FLAGS <= FLAGS_IN										when Sign_FLAG ="00" else 
				 aux_FLAGS_LOG & FLAGS_IN(1 downto 0) 	when Sign_FLAG ="01" else 
				 aux_FLAGS_SHIFT & FLAGS_IN(0) 			when Sign_FLAG ="10" else 
				 aux_FLAGS_ARI;




---------------------------------------------------------------------------------------------
----------------------------------- REGISTO FLAGS -------------------------------------------
---------------------------------------------------------------------------------------------

process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_MSR_FLAGS <= zeros_4;
			else
				aux_MSR_FLAGS <= aux_FLAGS;
			end if;		
		end if;
end process;


FLAGS_OUT <= aux_MSR_FLAGS;
FLAGSTEST_OUT	<= aux_MSR_FLAGS;



--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------

--------------- registo de saída do terceiro andar: EX e MEM -------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_EXMEM_OUT <= zeros;
			else
				aux_reg_EXMEM_OUT <= aux_EXMEM_bit6 & aux_EXMEM_bit15 & out_MEM & reg_IDOF_OUT(65) & reg_IDOF_OUT(64 downto 53) & reg_IDOF_OUT(52) & reg_IDOF_OUT(51 downto 49) & 
								 out_ALU & reg_IDOF_OUT(16 downto 1) & reg_IDOF_OUT(0);
				-- reg_EXMEM_OUT <= aux_EXMEM_bit6 & aux_EXMEM_bit15 & out_MEM & ALU_vs_MEM & save_pc_add_1 & JUMP_MUXWB_OUT & aux_ADD_RWC & 
				--                  out_ALU & out_mux_constantes & ALU_CONS_SEL;
			end if;	
		end if;
end process;

reg_EXMEM_OUT <= aux_reg_EXMEM_OUT when en_registo = '0' else
				 aux_EXMEM_bit6 & aux_EXMEM_bit15 & out_MEM & reg_IDOF_OUT(65) & reg_IDOF_OUT(64 downto 53) & reg_IDOF_OUT(52) & reg_IDOF_OUT(51 downto 49) & 
				 out_ALU & reg_IDOF_OUT(16 downto 1) & reg_IDOF_OUT(0);	

end Behavioral;

