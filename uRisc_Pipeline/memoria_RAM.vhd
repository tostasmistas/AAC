library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.TEXTIO.all;
use STD.TEXTIO;
use IEEE.STD_LOGIC_TEXTIO.all;

 
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
 
impure function InitRamFromFile (RamFileName : in string) return MEM_TYPE is
		file INFILE : TEXT  is in "ram_inst.txt";
		variable DATA_TEMP : STD_LOGIC_VECTOR(15 downto 0);	
		variable IN_LINE: LINE;
		variable RAM : MEM_TYPE;
		variable index :integer;
		variable i :integer;
  
		begin			  
			  index := 0;
			  i:=0;
			  readline(INFILE,IN_LINE);	
			  hread(IN_LINE, DATA_TEMP);
			  index := CONV_INTEGER(DATA_TEMP);
			   
			  for i in i to index loop
					RAM(i) := X"0000";
			  end loop;
			  while NOT(endfile(INFILE)) loop
					readline(INFILE,IN_LINE);	
					hread(IN_LINE, DATA_TEMP);
					RAM(index) := DATA_TEMP;
					index := index + 1;
			  end loop;
			  for index in index to 4095 loop
					RAM(index) := X"0000";
			  end loop;
	return RAM; 
   end function;

shared variable RAM : MEM_TYPE := InitRamFromFile("ram_inst.txt");

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

