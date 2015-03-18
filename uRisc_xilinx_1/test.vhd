--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:13:12 03/17/2015
-- Design Name:   
-- Module Name:   C:/Users/Nmac/Documents/GitHub/AAC/uRisc_xilinx_1/test.vhd
-- Project Name:  uRisc_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: circuito
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT circuito
    PORT(
         clk_in : IN  std_logic;
         rst_in : IN  std_logic;
         inst : IN  std_logic_vector(15 downto 0);
         addr : OUT  std_logic_vector(11 downto 0);
         saida : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_in : std_logic := '0';
   signal rst_in : std_logic := '0';
   signal inst : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal addr : std_logic_vector(11 downto 0);
   signal saida : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuito PORT MAP (
          clk_in => clk_in,
          rst_in => rst_in,
          inst => inst,
          addr => addr,
          saida => saida
        );

   -- Clock process definitions
   clk_in_process :process
   begin
		clk_in <= '0';
		wait for clk_in_period/2;
		clk_in <= '1';
		wait for clk_in_period/2;	
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_in_period*10;
		

		rst_in <= '1' after 15 ns,
				 '0' after 15 ns + clk_in_period*2;
	
      -- insert stimulus here 

		inst <=  X"0000" after 35 ns ;
		inst <=  X"2003" after 45 ns ;
		inst <=  X"2055" after 55 ns ;
		inst <=  X"2055" after 65 ns ;
		inst <=  X"2055" after 75 ns ;
		inst <=  X"6005" after 85 ns ;
--		inst <=  X"c000" after 155 ns ;
--		inst <=  X"c480" after 175 ns ;
--		inst <=  X"c8ae" after 195 ns ;
--		inst <=  X"ccdd" after 215 ns ;
--		inst <=  X"d0ea" after 235 ns ;
--		inst <=  X"d47f" after 255 ns ;
--		inst <=  X"d8c7" after 275 ns ;
--		inst <=  X"dc2b" after 295 ns ;
--		inst <=  X"b000" after 315 ns ;
--		inst <=  X"0301" after 335 ns ;
--		inst <=  X"a0e0" after 355 ns ;
--		inst <=  X"b01b" after 375 ns ;
--		inst <=  X"1301" after 395 ns ;
--		inst <=  X"a0e0" after 415 ns ;
--		inst <=  X"b15a" after 435 ns ;
--		inst <=  X"0401" after 245 ns ;
--		inst <=  X"a0e0" after 255 ns ;
--		inst <=  X"b153" after 265 ns ;
--		inst <=  X"1401" after 275 ns ;
--		inst <=  X"a0e0" after 285 ns ;
--		inst <=  X"b152" after 295 ns ;
--		inst <=  X"0501" after 305 ns ;
--		inst <=  X"a0e0" after 315 ns ;
--		inst <=  X"b15a" after 325 ns ;
--		inst <=  X"1501" after 335 ns ;
--		inst <=  X"a0e0" after 345 ns ;
--		inst <=  X"b15b" after 355 ns ;
--		inst <=  X"0701" after 365 ns ;
--		inst <=  X"a0e0" after 375 ns ;
--		inst <=  X"b153" after 385 ns ;
--		inst <=  X"1701" after 395 ns ;
--		inst <=  X"a0e0" after 405 ns ;
--		inst <=  X"b000" after 415 ns ;
--		inst <=  X"0601" after 425 ns ;
--		inst <=  X"a0e0" after 435 ns ;
--		inst <=  X"b013" after 445 ns ;
--		inst <=  X"1601" after 455 ns ;
--		inst <=  X"a0e0" after 465 ns ;
--		inst <=  X"b142" after 475 ns ;
--		inst <=  X"1301" after 485 ns ;
--		inst <=  X"2001" after 495 ns ;
--		inst <=  X"a0e0" after 505 ns ;
--		inst <=  X"b01b" after 515 ns ;
--		inst <=  X"0301" after 525 ns ;
--		inst <=  X"2001" after 535 ns ;
--		inst <=  X"a0e0" after 545 ns ;
--		inst <=  X"b15a" after 555 ns ;
--		inst <=  X"1401" after 565 ns ; 
--		inst <=  X"2001" after 575 ns ;
--		inst <=  X"a0e0" after 585 ns ;
--		inst <=  X"b153" after 595 ns ;
--		inst <=  X"0401" after 605 ns ;
--		inst <=  X"2001" after 615 ns ;
--		inst <=  X"a0e0" after 625 ns ; 
--		inst <=  X"b176" after 635 ns ;
--		inst <=  X"1501" after 645 ns ;
--		inst <=  X"2001" after 655 ns ;
--		inst <=  X"a0e0" after 665 ns ;
--		inst <=  X"b11a" after 675 ns ;
--		inst <=  X"0501" after 685 ns ;
--		inst <=  X"2001" after 695 ns ;
--		inst <=  X"a0e0" after 705 ns ;
--		inst <=  X"b149" after 715 ns ;
--		inst <=  X"1701" after 725 ns ;
--		inst <=  X"2001" after 735 ns ;
--		inst <=  X"a0e0" after 745 ns ;
--		inst <=  X"b153" after 755 ns ;
--		inst <=  X"0701" after 765 ns ;
--		inst <=  X"2001" after 775 ns ;
--		inst <=  X"a0e0" after 785 ns ;
--		inst <=  X"b001" after 795 ns ;
--		inst <=  X"1601" after 805 ns ;
--		inst <=  X"2001" after 815 ns ;
--		inst <=  X"a0e0" after 825 ns ;
--		inst <=  X"b013" after 835 ns ;
--		inst <=  X"0601" after 845 ns ;
--		inst <=  X"2001" after 855 ns ;
--		inst <=  X"a0e0" after 865 ns ;
--		inst <=  X"a260" after 875 ns ;
--		inst <=  X"6be8" after 885 ns ;
--		inst <=  X"82ec" after 895 ns ;
--		inst <=  X"2fff" after 905 ns ;
--		inst <=  X"3807" after 915 ns ;
--		inst <=  X"3807" after 925 ns ;
--		inst <=  X"3807" after 935 ns ;
--		inst <=  X"005a" after 945 ns ;
--		 

      wait;
   end process;

END;
