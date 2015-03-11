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
	clk						: in std_logic;
	inst_IN					: in std_logic_vector(15 downto 0);
	en_r0					: in std_logic;
	en_r1					: in std_logic;
	en_r2					: in std_logic;
	en_r3					: in std_logic;
	en_r4					: in std_logic;
	en_r5					: in std_logic;
	en_r6					: in std_logic;
	en_r7					: in std_logic;	
		
	-- output
	R0 						: out std_logic_vector(15 downto 0);
	R1 						: out std_logic_vector(15 downto 0);
	R2 						: out std_logic_vector(15 downto 0);
	R3 						: out std_logic_vector(15 downto 0);
	R4 						: out std_logic_vector(15 downto 0);
	R5 						: out std_logic_vector(15 downto 0);
	R6 						: out std_logic_vector(15 downto 0);
	R7 						: out std_logic_vector(15 downto 0);	
	);
end registos;

architecture Behavioral of registos is

---------------------------------------------------------------------
--------------------------- Aux Signals -----------------------------
---------------------------------------------------------------------
signal aux_reg_r0 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_r1 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_r2 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_r3 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_r4 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_r5 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_r6 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_reg_r7 : std_logic_vector(15 downto 0) := (others => '0');

begin


----------------------------------------------------------------------
----------------------- Banco de Registos ----------------------------
----------------------------------------------------------------------

--------------------------- Registo 0 (R0) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r0 <= zeros;
			elsif en_r0 = '1' then 
				aux_reg_r0 <= result;
			end if;	
		end if;
end process;

--------------------------- Registo 1 (R1) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r1 <= zeros;
			elsif en_r1 = '1' then 
				aux_reg_r1 <= result;
			end if;		
		end if;
end process;

--------------------------- Registo 2 (R2) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r2 <= zeros;
			elsif en_r2 = '1' then 
				aux_reg_r2 <= result;
			end if;			
		end if;
end process;

--------------------------- Registo 3 (R3) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r3 <= zeros;
			elsif en_r3 = '1' then 
				aux_reg_r3 <= result;
			end if;		
		end if;
end process;

--------------------------- Registo 4 (R4) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r4 <= zeros;
			elsif en_r4 = '1' then 
				aux_reg_r4 <= result;
			end if;			
		end if;
end process;

--------------------------- Registo 5 (R5) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r5 <= zeros;
			elsif en_r5 = '1' then 
				aux_reg_r5 <= result;
			end if;		
		end if;
end process;

--------------------------- Registo 6 (R6) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r6 <= zeros;
			elsif en_r6 = '1' then 
				aux_reg_r6 <= result;
			end if;		
		end if;
end process;

--------------------------- Registo 7 (R7) ---------------------------
process (clk, rst)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				aux_reg_r7 <= zeros;
			elsif en_r7 = '1' then 
				aux_reg_r7 <= result;
			end if;			
		end if;
end process;



--------------------------------------------------------------------------
------------------------------- Exit -------------------------------------
--------------------------------------------------------------------------
R0 <= aux_reg_r0;
R1 <= aux_reg_r1;
R2 <= aux_reg_r2;
R3 <= aux_reg_r3;
R4 <= aux_reg_r4;
R5 <= aux_reg_r5;
R6 <= aux_reg_r6;
R7 <= aux_reg_r7;



end Behavioral;