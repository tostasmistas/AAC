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
		
	---PARA A FlagTest
		TRANS_FI_COND_IN		: in std_logic_vector(3 downto 0);
		TRANS_FI_OP_IN			: in std_logic;
		
		TRANS_FII_IN			: in std_logic;
		
		TRANS_FIII_IN			: in std_logic;
	--Output
		--Registo
		REG_WC            	: out std_logic_vector(15 downto 0)
		flagtest_rel_OUT		: out std_logic;			-----Salto relativo
		flagtest_abs_OUT		: out std_logic			-----Salto absoluto
			
	);
end EXeMEM;

architecture Behavioral of EXeMEM is

signal aux_FLAGS			: std_logic_vector(3 downto 0) := (others => '0'); ---- Z,N,C,O---
signal aux_R_FLAGS		: std_logic_vector(3 downto 0) := (others => '0');
signal aux_flagtest_rel	: std_logic := '0';
signal aux_flagtest_abs	: std_logic := '0';

constant zeros		: std_logic_vector(12 downto 0) := (others => '0');

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

---------------------------------------------------------------------------------------------
----------------------------------- REGISTO FLAGS -------------------------------------------
---------------------------------------------------------------------------------------------

process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_R_FLAGS <= zeros;
			else
				aux_R_FLAGS <= aux_FLAGS;
			end if;		
		end if;
end process;


end Behavioral;

