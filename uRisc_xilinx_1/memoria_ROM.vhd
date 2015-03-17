----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:06:47 03/17/2015 
-- Design Name: 
-- Module Name:    memoria_ROM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
	0 => "00100000001000001111111111111111",
	others=> x"00000000"
	);

shared variable myRAM : MEM_TYPE;


begin
process (CLK_A)
	begin
		if rising_edge(CLK_A)then
			--DO_A <= RAM(conv_integer(Addr_A));
	end if;
end process;

end Behavioral;


