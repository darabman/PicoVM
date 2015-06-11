-- =============================================================================================================
-- *
-- * Copyright (c) M.Freeman
-- *
-- * File Name: picoblaze_top_level_tb.vhd
-- *
-- * Version: V1.0
-- *
-- * Release Date:
-- *
-- * Author(s): M.Freeman
-- *
-- * Description: PicoBlaze top level testbench
-- *
-- * Change History:  $Author: $
-- *                  $Date: $
-- *                  $Revision: $
-- *
-- * Conditions of Use: THIS CODE IS COPYRIGHT AND IS SUPPLIED "AS IS" WITHOUT WARRANTY OF ANY KIND, INCLUDING,
-- *                    BUT NOT LIMITED TO, ANY IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS FOR A
-- *                    PARTICULAR PURPOSE.
-- *
-- * Notes:
-- *
-- =============================================================================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY picoblaze_top_level_tb IS
END picoblaze_top_level_tb;
 
ARCHITECTURE behavior OF picoblaze_top_level_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT picoblaze_top_level
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         pio_A_dat_o : OUT  std_logic_vector(7 downto 0);
         pio_A_dat_i : IN  std_logic_vector(7 downto 0);
         pio_B_dat_o : OUT  std_logic_vector(7 downto 0);
         pio_B_dat_i : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
	
   signal pio_A_dat_i : std_logic_vector(7 downto 0) := (others => '0');
   signal pio_B_dat_i : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pio_A_dat_o : std_logic_vector(7 downto 0);
   signal pio_B_dat_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: picoblaze_top_level PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          pio_A_dat_o => pio_A_dat_o,
          pio_A_dat_i => pio_A_dat_i,
          pio_B_dat_o => pio_B_dat_o,
          pio_B_dat_i => pio_B_dat_i );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst_i <= '0';
      wait for clk_i_period*10;
      rst_i <= '1';
		
		pio_A_dat_i <= "10101010";
		pio_B_dat_i <= "01010101";
		wait for 5 us;
		
		pio_A_dat_i <= "00000000";
		pio_B_dat_i <= "00000000";
		wait for 5 us;
		
		pio_A_dat_i <= "11111111";
		pio_B_dat_i <= "11111111";
		
      wait;
   end process;

END;
