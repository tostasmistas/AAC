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
	clk, rst			       : in std_logic;
	---PARA ALU
	   REG_A 				 	: in std_logic_vector(15 downto 0);
		REG_B 				 	: in std_logic_vector(15 downto 0);
		ALU_OPER					: in std_logic_vector(4 downto 0);
		FLAGS_IN					: in std_logic_vector(3 downto 0);
			
	---PARA A FlagTest
		TRANS_OP					: in std_logic_vector(1 downto 0);
		TRANS_FI_COND_IN		: in std_logic_vector(3 downto 0);
		FLAGTEST_active_IN	: in std_logic;
	--Output
		--Registo
		REG_WC            	: out std_logic_vector(15 downto 0)
		flagtest_rel_OUT		: out std_logic;			-----Salto relativo
		flagtest_abs_OUT		: out std_logic			-----Salto absoluto
		FLAGS_OUT				: out std_logic_vector(3 downto 0);
		FLAGTEST_cond_OUT		: out std_logic
			
	);
end EXeMEM;

architecture Behavioral of EXeMEM is

signal aux_FLAGS			: std_logic_vector(3 downto 0) := (others => '0'); ---- Z,N,C,O---
signal aux_MSR_FLAGS		: std_logic_vector(3 downto 0) := (others => '0');
signal aux_flagtest_rel	: std_logic := '0';
signal aux_FLAGTEST		: std_logic := '0';

constant zeros		: std_logic_vector(3 downto 0) := (others => '0');

begin
---------------------------------------------------------------------------------------------
---------------------------------- MEMORIA --------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
----------------------------------- ALU -----------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
---------------------------------- TESTE FLAGS ----------------------------------------------
---------------------------------------------------------------------------------------------
aux_FLAGMUX	 <= FLAGS_IN(0) when TRANS_FI_COND_IN="0101" else
					 FLAGS_IN(1) when TRANS_FI_COND_IN="0100" else
					 FLAGS_IN(2) when TRANS_FI_COND_IN="0110" else
					 FLAGS_IN(3) when TRANS_FI_COND_IN="0011" else
						 '1' 	 	 when TRANS_FI_COND_IN="0000" else
					 FLAGS_IN(0) or aux_FLAGS(1) when TRANS_FI_COND_IN="0111" else
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

end Behavioral;

