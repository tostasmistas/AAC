library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memoria_RAM is
		Generic(
			ADDR_SIZE :	positive:= 12
		);
		Port(
			CLK_A 	: in 	STD_LOGIC;
			WE_A  	: in 	STD_LOGIC;
			Addr_A 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DI_A 	: in 	STD_LOGIC_VECTOR(15 downto 0);
			DO_A 	: out 	STD_LOGIC_VECTOR(15 downto 0)
		);
end memoria_RAM;

architecture Behavioral of memoria_RAM is

type MEM_TYPE is array(0 to (2**ADDR_SIZE)-1) of STD_LOGIC_VECTOR(15 downto 0);

constant InitValue : MEM_TYPE := ( 
	14 => X"000c",
	15 => X"0007",
	16 => X"000b",
	17 => X"0013",
	18 => X"0011",
	19 => X"0015",
	20 => X"0009",
	21 => X"0017",
	22 => X"000f",
	23 => X"0005",
	24 => X"0003",
	25 => X"0001",
	26 => X"000d",
	others=> X"0000"
	);

shared variable RAM : MEM_TYPE := InitValue;


begin
process (CLK_A)
	begin
		if rising_edge(CLK_A)then
			if WE_A='1'  then
				RAM(conv_integer(Addr_A)) := DI_A;
			end if;
				DO_A <= RAM(conv_integer(Addr_A));
	end if;
end process;

end Behavioral;

