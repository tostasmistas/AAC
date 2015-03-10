library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InF is
	port(
	-- input
	clk, rst			       : in std_logic;

	FLAGTEST_cond			 : in std_logic;   
	FLAGTEST_jump			 : in std_logic;
	destino_jump			 : in std_logic_vector(11 downto 0);
	destino_cond			 : in std_logic_vector(11 downto 0);

	reg_pc_IN 				 : in std_logic_vector(11 downto 0);

	-- output
	reg_pc_OUT            : out std_logic_vector(11 downto 0)
				
	);
end InF;

architecture Behavioral of InF is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal aux_pc_add_1	   : std_logic_vector(11 downto 0) := (others => '0');
signal aux_saida_mux		: std_logic_vector(11 downto 0) := (others => '0');
signal aux_reg_pc 		: std_logic_vector(11 downto 0) := (others => '0');

--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant one		: std_logic_vector(11 downto 0) :="0000000000001" ;
constant zeros		: std_logic_vector(11 downto 0) := (others => '0');

begin
aux_pc_add_1 	<= reg_pc_IN + one when FLAGTEST_cond = '0' else
						reg_pc_IN + destino_cond;
	
aux_saida_mux  <= aux_pc_add_1 when FLAGTEST_jump = '0' else
						destino_jump;
								
	
---------------------------------------------------------------------------
----------------------- Registo PC	---------------------------------------
---------------------------------------------------------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_pc <= zeros;
			else
				aux_reg_pc <= aux_saida_mux;
			end if;		
		end if;
end process;		


---------------------------------------------------------------------------
--------------------- Registo de Instruções (IR)	------------------------
---------------------------------------------------------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_ir <= zeros;
			else
				aux_reg_ir <= aux_saida_mux; 					-- carregar a próxima instrução da memória (de programa) e armazenar no IR
			end if;		
		end if;
end process;	

--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------
reg_pc_OUT <= aux_reg_pc;

end Behavioral;

