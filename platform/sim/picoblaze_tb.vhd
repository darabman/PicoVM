--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:42:50 04/10/2015
-- Design Name:   
-- Module Name:   H:/workspace/prbe/prbe2015/PicoBlaze_VHDL/picoblaze_tb.vhd
-- Project Name:  PicoBlaze
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: picoblaze_top_level
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
 
ENTITY picoblaze_tb IS
END picoblaze_tb;
 
ARCHITECTURE behavior OF picoblaze_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT picoblaze_top_level
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 

 
	-- Instantiate the Unit Under Test (UUT)
   uut: picoblaze_top_level PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i
        );

   -- Clock process definitions
   clk_i_process : process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
--	process (rst_i)
--	begin
--	if rst_i = '1' then
--		clk_i <= '0';
--	end if;
--	end process;
   -- Stimulus process
   stim_proc: process
   begin		
		
		rst_i <= '1';
		
		
      -- hold reset state for 100 ns.
      wait for 30 ns;
		rst_i <= '0';

      wait for clk_i_period*100;

      -- insert stimulus here 

      wait;
   end process;

END;

