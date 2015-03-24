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
	end if;
end process;

DO_A <= RAM(conv_integer(Addr_A)); -- leitura assincrona

end Behavioral;

