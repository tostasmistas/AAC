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
         addr : OUT  std_logic_vector(11 downto 0);
         saida : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_in : std_logic := '0';
   signal rst_in : std_logic := '0';

 	--Outputs
   signal addr : std_logic_vector(11 downto 0);
   signal saida : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_in_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuito PORT MAP (
          clk_in => clk_in,
          rst_in => rst_in,
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
		

		rst_in <= '1' after 1 ns,
				    '0' after 1 ns + clk_in_period*1.3;
			 

      wait;
   end process;

END;
