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
	clk, rst 					: in std_logic;

	  
	ALU_OPER					: in std_logic_vector(4 downto 0);
	FLAGS_IN					: in std_logic_vector(3 downto 0);
	reg_IDOF_OUT				: in std_logic_vector(); 

		---PARA A FlagTest
		TRANS_OP					: in std_logic_vector(1 downto 0);
		TRANS_FI_COND_IN			: in std_logic_vector(3 downto 0);
		FLAGTEST_active_IN			: in std_logic;
		--Registo
		REG_WC            		: out std_logic_vector(15 downto 0)
		FLAGS_OUT				: out std_logic_vector(3 downto 0);
		FLAGTEST_MUXPC_OUT		: out std_logic

		
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
signal aux_FLAGTEST			: std_logic := '0';

signal operando_A			: std_logic_vector(15 downto 0) := (others => '0');
signal operando_B			: std_logic_vector(15 downto 0) := (others => '0');


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
---------------------------------------------------------------------------------------------

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
				reg_EXMEM_OUT <= reg_IDOF_OUT(51 downto 49) & out_ALU & reg_IDOF_OUT(16 downto 1) & reg_IDOF_OUT(0);
			end if;	
		end if;
end process;

end Behavioral;

