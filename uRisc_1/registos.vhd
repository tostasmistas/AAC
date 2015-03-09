library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registos is
	port(
	-- input
	clk				       : in std_logic;

	inst_IN					 : in std_logic_vector(15 downto 0);
	
		
	-- output
	R0 : out std_logic_vector(15 downto 0);
	R1 : out std_logic_vector(15 downto 0);
   R2 : out std_logic_vector(15 downto 0);
	R3 : out std_logic_vector(15 downto 0);
	R4 : out std_logic_vector(15 downto 0);
	R5 : out std_logic_vector(15 downto 0);
	R6 : out std_logic_vector(15 downto 0);
	R7 : out std_logic_vector(15 downto 0)
	
	);
end registos;

architecture Behavioral of registos is

---------------------------------------------------------------------
--------------------------- Aux Signals -----------------------------
---------------------------------------------------------------------
signal R0 : std_logic_vector(15 downto 0) := (others => '0');
signal R1 : std_logic_vector(15 downto 0) := (others => '0');
signal R2 : std_logic_vector(15 downto 0) := (others => '0');
signal R3 : std_logic_vector(15 downto 0) := (others => '0');
signal R4 : std_logic_vector(15 downto 0) := (others => '0');
signal R5 : std_logic_vector(15 downto 0) := (others => '0');
signal R6 : std_logic_vector(15 downto 0) := (others => '0');
signal R7 : std_logic_vector(15 downto 0) := (others => '0');

begin

----------------------------------------------------------------------
----------------------- Banco de Registos	----------------------------
----------------------------------------------------------------------

--------------------------- Registo 0 (R0) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r0 <= zeros;
			else
				aux_reg_r0 <= ;
			end if;		
		end if;
end process;

--------------------------- Registo 1 (R1) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r1 <= zeros;
			else
				aux_reg_r1 <= ;
			end if;		
		end if;
end process;

--------------------------- Registo 2 (R2) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r2 <= zeros;
			else
				aux_reg_r2 <= ;
			end if;		
		end if;
end process;

--------------------------- Registo 3 (R3) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r3 <= zeros;
			else
				aux_reg_r3 <= ;
			end if;		
		end if;
end process;

--------------------------- Registo 4 (R4) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r4 <= zeros;
			else
				aux_reg_r4 <= ;
			end if;		
		end if;
end process;

--------------------------- Registo 5 (R5) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r5 <= zeros;
			else
				aux_reg_r5 <= ;
			end if;		
		end if;
end process;

--------------------------- Registo 6 (R6) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r6 <= zeros;
			else
				aux_reg_r6 <= ;
			end if;		
		end if;
end process;

--------------------------- Registo 7 (R7) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r7 <= zeros;
			else
				aux_reg_r7 <= ;
			end if;		
		end if;
end process;

end Behavioral;