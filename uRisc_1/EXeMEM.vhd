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

	flag_test_cond			 : in std_logic;
	flag_test_jump			 : in std_logic;
	destino_jump			 : in std_logic_vector(12 downto 0);
	destino_cond			 : in std_logic_vector(12 downto 0);

	reg_pc_IN 				 : in std_logic_vector(12 downto 0);

	-- output
	reg_pc_OUT            : out std_logic_vector(12 downto 0)
			
	);
end EXeMEM;

architecture Behavioral of EXeMEM is

begin


end Behavioral;

