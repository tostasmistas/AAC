library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IDeOF is
	port(
	-- input
	clk				       : in std_logic;

	inst_IN					 : in std_logic_vector(15 downto 0);
	
	R0 : in std_logic_vector(15 downto 0);
	R1 : in std_logic_vector(15 downto 0);
   R2 : in std_logic_vector(15 downto 0);
	R3 : in std_logic_vector(15 downto 0);
	R4 : in std_logic_vector(15 downto 0);
	R5 : in std_logic_vector(15 downto 0);
	R6 : in std_logic_vector(15 downto 0);
	R7 : in std_logic_vector(15 downto 0);
	
	-- output
	oper_A	: out std_logic_vector(15 downto 0);	-- A Data
	oper_B	: out std_logic_vector(15 downto 0) 	-- B Data
				
	);
end IDeOF;

architecture Behavioral of IDeOF is

--------------------------------------------------------------------------
--------------------------- Aux Signals ----------------------------------
--------------------------------------------------------------------------
signal aux_ALU_ADD_RWC	: std_logic_vector(2 downto 0) := (others => '0');
signal aux_ALU_ADD_RA	: std_logic_vector(2 downto 0) := (others => '0');
signal aux_ALU_ADD_RB	: std_logic_vector(2 downto 0) := (others => '0');
signal aux_ALU_OPER		: std_logic_vector(4 downto 0) := (others => '0');

signal aux_CONS_FI_RWC	: std_logic_vector(2 downto 0) := (others => '0');
signal aux_CONS_FI_11B	: std_logic_vector(11 downto 0) := (others => '0');

signal aux_CONS_FII_RWC	: std_logic_vector(2 downto 0) := (others => '0');
signal aux_CONS_FII_R	: std_logic := '0';
signal aux_CONS_FII_8B	: std_logic_vector(7 downto 0) := (others => '0');

signal aux_TRANS_FI_COND: std_logic_vector(3 downto 0) := (others => '0');
signal aux_TRANS_FI_DES : std_logic_vector(7 downto 0) := (others => '0');
signal aux_TRANS_FI_OP	: std_logic := '0';

signal aux_TRANS_FII_DES: std_logic_vector(11 downto 0) := (others => '0');
signal aux_TRANS_FII		: std_logic := '0';

signal aux_TRANS_FIII_ADD_RB : std_logic_vector(2 downto 0) := (others => '0');
signal aux_TRANS_FIII_MUX	  : std_logic := '0';
signal aux_TRANS_FIII_WE_R7  : std_logic := '0'; 

signal RA : std_logic_vector(15 downto 0) := (others => '0');
signal RB : std_logic_vector(15 downto 0) := (others => '0');


--------------------------------------------------------------------------
---------------------  Constantes   --------------------------------------
--------------------------------------------------------------------------
constant one		: std_logic_vector(12 downto 0) :="0000000000001" ;
constant zeros		: std_logic_vector(12 downto 0) := (others => '0');

begin

--------------------------------------------------------------------------
------ Conjuntos de instrucções ------------------------------------------
------ Inst_IN(15:14)           ------------------------------------------
------ 0 0 => Transferencia de Controlo    -------------------------------
------ 0 1 => Constantes Formato I		    -------------------------------
------ 1 0 => Instrucoes para ALU/Memoria  -------------------------------
------ 1 1 => Constante Formato II		    -------------------------------
--------------------------------------------------------------------------


--------------------------------------------------------------------------
-------- 0 0 -> Transferência de Controlo --------------------------------
-------- exitsem 3 formatos ----------------------------------------------
--------------------------------------------------------------------------

-------- 0 0/ 0 1 -> Formato I condicional -------------------------------
aux_TRANS_FI_COND	<= inst_IN(11 downto 8);
aux_TRANS_FI_DES	<= inst_IN(7 downto 0);
aux_TRANS_FI_OP   <= inst_IN(12);

-------- 1 0 -> Formato II incondicional ---------------------------------
aux_TRANS_FII_DES <= inst_IN(11 downto 0);
aux_TRANS_FII   	<= ------------- logica

-------- 1 1 -> Formato III jumps ----------------------------------------
aux_TRANS_FIII_ADD_RB   <= inst_IN(2 downto 0);
aux_TRANS_FIII_MUX   	<= ---------- logicaaux_TRANS_FIII_WE_R7   	<= ---------- logica


--------------------------------------------------------------------------
-------- 0 1 -> Constantes	Formato I   -----------------------------------
--------------------------------------------------------------------------
aux_CONS_FI_RWC 	<= inst_IN(13 downto 11);
aux_CONS_FI_11B 	<= inst_IN(10 downto 0 );


--------------------------------------------------------------------------
-------- 1 0 -> Instrucções para a ALU/Memoria ----------------------------
--------------------------------------------------------------------------
aux_ALU_ADD_RWC   <= inst_IN(13 downto 11);
aux_ALU_ADD_RA		<= inst_IN(5 downto 2);	-- A Address
aux_ALU_ADD_RB		<= inst_IN(2 downto 0);	-- B Address
aux_ALU_OPER		<= inst_IN(10 downto 6);

--------------------------------------------------------------------------
-------- 1 1 -> Constantes	Formato II  -----------------------------------
--------------------------------------------------------------------------
aux_CONS_FII_RWC	<= inst_IN(13 downto 11);
aux_CONS_FII_R		<=	inst_IN(10);
aux_CONS_FII_8B	<=	inst_IN(7 downto 0);


--------------------------------------------------------------------------
----------------- MUXs para selecção de RA e de RB  ----------------------
--------------------------------------------------------------------------
RA <= R0 when aux_ALU_ADD_RA = "000" else 
		R1 when aux_ALU_ADD_RA = "001" else
		R2 when aux_ALU_ADD_RA = "010" else
		R3 when aux_ALU_ADD_RA = "011" else
		R4 when aux_ALU_ADD_RA = "100" else
		R5 when aux_ALU_ADD_RA = "101" else
		R6 when aux_ALU_ADD_RA = "110" else
		R7;
			 
RB <= R0 when aux_ALU_ADD_RB = "000" else 	
		R1 when aux_ALU_ADD_RB = "001" else
		R2 when aux_ALU_ADD_RB = "010" else
		R3 when aux_ALU_ADD_RB = "011" else
		R4 when aux_ALU_ADD_RB = "100" else
		R5 when aux_ALU_ADD_RB = "101" else
		R6 when aux_ALU_ADD_RB = "110" else
		R7;
			 
--------------------------------------------------------------------------
-------- MUXs para selecção entre RA/RB e os imediatos A/B ---------------
--------------------------------------------------------------------------
oper_A <=


oper_B <=

			 
end Behavioral;