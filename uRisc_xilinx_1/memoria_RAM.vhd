----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:53:55 03/16/2015 
-- Design Name: 
-- Module Name:    memoria_RAM - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoria_RAM is
		Generic(
			ADDR_SIZE :	positive:= 12
		);
		Port(
			CLK_A 	: in 	STD_LOGIC;
			WE_A  	: in 	STD_LOGIC;
			Addr_A 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DI_A 	: in 	STD_LOGIC_VECTOR(31 downto 0);
			DO_A 	: out 	STD_LOGIC_VECTOR(31 downto 0);
			CLK_B   : in 	STD_LOGIC;
			WE_B    : in 	STD_LOGIC;
			Addr_B 	: in 	STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
			DI_B  	: in 	STD_LOGIC_VECTOR(31 downto 0);
			DO_B  	: out 	STD_LOGIC_VECTOR(31 downto 0)
		);
end memoria_RAM;

architecture Behavioral of memoria_RAM is

begin


end Behavioral;

