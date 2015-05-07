library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use STD.TEXTIO.all;
use STD.TEXTIO;
use IEEE.STD_LOGIC_TEXTIO.all;	

entity memoria_ROM is
		Generic(
			ADDR_SIZE :	positive:= 12
		);
		Port(
			Addr_ROM 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DO_ROM 	: out 	STD_LOGIC_VECTOR(15 downto 0)
		);
end memoria_ROM;    
              
architecture Behavioral of memoria_ROM is
        
type MEM_TYPE is array(0 to (2**ADDR_SIZE)-1) of STD_LOGIC_VECTOR(15 downto 0);
      
 impure function InitRamFromFile (RamFileName : in string) return MEM_TYPE is
		file INFILE : TEXT  is in "rom_inst.txt";
		variable DATA_TEMP : STD_LOGIC_VECTOR(15 downto 0);	
		variable IN_LINE: LINE;
		variable ROM : MEM_TYPE;
		variable index :integer;
          
		begin			    
			  index := 0;
			  while NOT(endfile(INFILE)) loop
					readline(INFILE,IN_LINE);	
					hread(IN_LINE, DATA_TEMP);
					ROM(index) := DATA_TEMP;
					index := index + 1;
			  end loop;
			  for index in index to 4095 loop
					ROM(index) := X"0000";
			  end loop;
	return ROM;
   end function;

signal ROM : MEM_TYPE := InitRamFromFile("rom_inst.txt");

 
begin
DO_ROM <= ROM(conv_integer(Addr_ROM)); -- leitura assincrona

end Behavioral;


