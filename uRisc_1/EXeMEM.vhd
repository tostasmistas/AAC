use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EXeMEM is
	port(
	-- input
<<<<<<< HEAD
	clk, rst			       : in std_logic;
	---PARA ALU
	   REG_A 				 	: in std_logic_vector(15 downto 0);
		REG_B 				 	: in std_logic_vector(15 downto 0);
		ALU_OP					: in std_logic_vector(4 downto 0);
		FLAGS_IN					: in std_logic_vector(3 downto 0);

=======
	clk, rst 					: in std_logic;
	reg_IDOF_OUT				: in std_logic_vector();  


	ALU_OPER					: in std_logic_vector(4 downto 0);
	FLAGS_IN					: in std_logic_vector(3 downto 0);
			
>>>>>>> origin/master
	---PARA A FlagTest
	TRANS_OP					: in std_logic_vector(1 downto 0);
	TRANS_FI_COND_IN			: in std_logic_vector(3 downto 0);
	FLAGTEST_active_IN			: in std_logic;

	--Registo
	REG_WC            			: out std_logic_vector(15 downto 0)
	flagtest_rel_OUT			: out std_logic;					-- salto relativo
	flagtest_abs_OUT			: out std_logic						-- salto absoluto
	FLAGS_OUT					: out std_logic_vector(3 downto 0);
	FLAGTEST_cond_OUT			: out std_logic
		
	-- output
	reg_EXMEM_OUT				: out std_logic_vector();	
	);
end EXeMEM;

architecture Behavioral of EXeMEM is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal out_ALU				: std_logic_vector(15 downto 0) := (others => '0'); -- saída da ALU
signal aux_FLAGS			: std_logic_vector(3 downto 0) := (others => '0'); 	-- Z,N,C,O
signal aux_MSR_FLAGS		: std_logic_vector(3 downto 0) := (others => '0');
<<<<<<< HEAD
signal aux_flagtest_rel	: std_logic := '0';
signal aux_FLAGTEST		: std_logic := '0';
signal Aux_LogA				: std_logic_vector(15 downto 0);
signal Aux_LogB				: std_logic_vector(15 downto 0);
signal Aux_Arith			: std_logic_vector(15 downto 0);
signal OUT_XOR			: std_logic_vector(15 downto 0);
signal OUT_LOG			: std_logic_vector(15 downto 0);
signal Sign_OP				: std_logic_vector(1 downto 0);
signal SignA				: std_logic;
signal SignB				: std_logic;
=======
signal aux_flagtest_rel		: std_logic := '0';
signal aux_FLAGTEST			: std_logic := '0';

signal operando_A			: std_logic_vector(15 downto 0) := (others => '0');
signal operando_B			: std_logic_vector(15 downto 0) := (others => '0');

>>>>>>> origin/master

--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant zeros				: std_logic_vector(3 downto 0) := (others => '0');

begin
---------------------------------------------------------------------------------------------
---------------------------------- MEMORIA --------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
----------------------------------- ALU -----------------------------------------------------

------------------------------------LOG------------------------------------------------------

SignA<=(ALU_OP(0) and not(ALU_OP(1))or(ALU_OP(2) and not(ALU_OP(3)));
SignB<=(ALU_OP(0) or (ALU_OP(1))nand(ALU_OP(2) or not(ALU_OP(3)));

Aux_LogA <= (not REG_A) when signA ='0' else 
			REG_A when signA = '1' else 
			'1';
Aux_LogB <= (not REG_B) when signB ='0' else 
			REG_B when signA = '1' else 
			'1';

Aux_LogA<=Aux_LogA and ((ALU_OP(0) xnor ALU_OP(1))and(ALU_OP(2) xnor ALU_OP(3)));
Aux_LogB<=Aux_LogB and ((ALU_OP(0) xnor ALU_OP(2))and(ALU_OP(1) xnor ALU_OP(3)));

Sign_OP(0)<=((ALU_OP(0) nor ALU_OP(1)) or (ALU_OP(1) xor ALU_OP(2))) or (ALU_OP(0) xor ALU_OP(3));
Sign_OP(1)<=((ALU_OP(0) or ALU_OP(3)) nand (ALU_OP(1) or ALU_OP(2)));

OUT_XOR <= (Aux_LogA xor Aux_LogB) when ALU_OP = '0' else 
			not (Aux_LogA xor Aux_LogB) when ALU_OP = '1' else 
			'0000000000000000';

OUT_LOG  <= '0000000000000001' when Sign_OP = '00' else 
			(Aux_LogA or Aux_LogB) when Sign_OP = '01' else
			OUT_XOR when Sign_OP = '10' else
			(Aux_LogA and Aux_LogB) when Sign_OP = '11' else
			'0000000000000000';


-----------------------------------ARIT------------------------------------------------------



operando_A <= reg_IDOF_OUT(48 downto 33);
operando_B <= reg_IDOF_OUT(32 downto 17);

-- os sinais de cima sao os operandos com que deves trabalhar na ALU
-- a saida da ALU deve ser armazenada no sinal out_ALU


---------------------------------------------------------------------------------------------
---------------------------------- TESTE FLAGS ----------------------------------------------
---------------------------------------------------------------------------------------------
aux_FLAGMUX	 <= FLAGS_IN(0) 						when TRANS_FI_COND_IN = "0101" else
					 FLAGS_IN(1)					when TRANS_FI_COND_IN = "0100" else
					 FLAGS_IN(2) 					when TRANS_FI_COND_IN = "0110" else
					 FLAGS_IN(3) 					when TRANS_FI_COND_IN = "0011" else
					'1' 	 	 					when TRANS_FI_COND_IN = "0000" else
					 FLAGS_IN(0) or aux_FLAGS(1) 	when TRANS_FI_COND_IN = "0111" else
					'0';


aux_FLAGTEST <= aux_FLAGMUX xnor TRANS_OP(1);

aux_FLAGTEST_cond <= (TRANS_OP(1) and not(TRANS_OP(0))) or (aux_FLAGTEST and not(TRANS_OP(1))); 




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
				reg_EXMEM_OUT <= reg_IDOF_OUT(51 downto 49) & out_ALU & reg_IDOF_OUT(16 downto 1) & reg_IDOF_OUT(0);
			end if;	
		end if;
end process;

end Behavioral;

