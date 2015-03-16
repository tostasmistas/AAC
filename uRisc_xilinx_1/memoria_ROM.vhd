library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memoria_ROM is
		Generic(
			ADDR_SIZE :	positive:= 12
		);
		Port(
			CLK_A 	: in 	STD_LOGIC;
			Addr_A 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DO_A 	: out 	STD_LOGIC_VECTOR(15 downto 0)
		);
end memoria_ROM;

architecture Behavioral of memoria_ROM is

type MEM_TYPE is array(0 to (2**ADDR_SIZE)-1) of STD_LOGIC_VECTOR(15 downto 0);

constant InitValue : MEM_TYPE := ( 
	others=> x"00000000"
	);

shared variable myRAM : MEM_TYPE := InitValue0;


begin
process (CLK_A)
	begin
		if rising_edge(CLK_A)then
			DO_A <= RAM(conv_integer(Addr_A));
	end if;
end process;

end Behavioral;

