library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.TEXTIO.all;
use STD.TEXTIO;
use IEEE.STD_LOGIC_TEXTIO.all;

 
entity BTB_bram is
		Generic(
			ADDR_SIZE :	positive:= 9
		); 
		Port(   
			CLK_A 	: in 	STD_LOGIC;
			WE_A  	: in 	STD_LOGIC;
			Addr_A 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			Addr_B 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DI_A 		: in 	STD_LOGIC_VECTOR(16 downto 0);
			DO_B 		: out STD_LOGIC_VECTOR(16 downto 0)
		);
end BTB_bram;
    
architecture Behavioral of BTB_bram is
      
type MEM_TYPE is array(0 to (2**ADDR_SIZE)-1) of STD_LOGIC_VECTOR(16 downto 0);

constant InitValue : MEM_TYPE := ( others => "00000000000000000");

shared variable myRAM : MEM_TYPE := InitValue;

begin
process (CLK_A)
	begin
		if rising_edge(CLK_A)then
			if WE_A='1'  then
				myRAM(conv_integer(Addr_A)) := DI_A;
			end if;				
	end if;
end process;

DO_B <= myRAM(conv_integer(Addr_B)); -- leitura assincrona

end Behavioral;

