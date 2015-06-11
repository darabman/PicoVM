-- =============================================================================================================
-- *
-- * Copyright (c) M.Freeman
-- *
-- * File Name: picoblaze_top_level.vhd
-- *
-- * Version: V1.0
-- *
-- * Release Date:
-- *
-- * Author(s): M.Freeman
-- *
-- * Description: Single core PicoBlaze top level wrapper
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

--
-- Address decoder
-- ---------------
-- 
-- Addr Min          Addr Max          Range    Description
-- 00000000 (00h)    01111111 (3Fh)    128      RAM
-- 10000000 (80h)    10001111 (8Fh)    16       IOA
-- 10010000 (90h)    10011111 (9Fh)    16       IOB
-- 10100000 (A0h)    10101111 (AFh)    16       User defined
-- 10110000 (B0h)    10111111 (BFh)    16       User defined  
-- 11000000 (C0h)    11001111 (CFh)    16       User defined
-- 11010000 (D0h)    11011111 (DFh)    16       User defined
-- 11100000 (E0h)    11101111 (EFh)    16       User defined
-- 11110000 (F0h)    11111111 (FFh)    16       User defined  
--
  
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY picoblaze_top_level IS
PORT (
  clk_i        : IN STD_LOGIC;
  rst_i        : IN STD_LOGIC
  );
--  pio_A_dat_i  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--  pio_A_dat_o  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
--  pio_B_dat_i  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--  pio_B_dat_o  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) );
END picoblaze_top_level;

ARCHITECTURE picoblaze_top_level_arch OF picoblaze_top_level IS

  -- ##############
  -- # Components #
  -- ##############

  --
  -- Processor
  --

  COMPONENT picoblaze_9p_single_core 
  PORT (
  clk_i : IN STD_LOGIC;
  rst_i : IN STD_LOGIC;
  mmu_adr_o  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
  mmu_dat_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  mmu_dat_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  mmu_we_o  : OUT STD_LOGIC;
  
  core_adr_o : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
  core_dat_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  core_dat_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  core_we_o  : OUT STD_LOGIC
  );
  END COMPONENT;

  --
  -- data memory
  --
  
  component block_ram_64x8 is
	PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
  end component;

  -- ###########
  -- # Signals #
  -- ###########

  SIGNAL GND : STD_LOGIC;
  SIGNAL VCC : STD_LOGIC;
  SIGNAL GND_BUS : STD_LOGIC_VECTOR(7 DOWNTO 0);
  
  --
  -- CPU
  --

  SIGNAL core_adr_o : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL core_dat_o : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL core_dat_i : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL core_we_o  : STD_LOGIC_VECTOR(0 downto 0);
 
  SIGNAL mmu_adr_o : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL mmu_dat_o : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL mmu_dat_i : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL mmu_we_o  : STD_LOGIC_VECTOR(0 downto 0);
  signal rst_n : std_logic := '0';
  
  
  
BEGIN

  --
  -- signal buffers
  --

  VCC <= '1';
  GND <= '0';
  GND_BUS <= (OTHERS=>'0');



  rst_n <= not rst_i;
  
  --
  -- Processor
  --
  
  CPU : picoblaze_9p_single_core 
  PORT MAP(
    clk_i      => clk_i,
    rst_i      => rst_n,
    
	 core_adr_o => core_adr_o,
    core_dat_o => core_dat_o,
    core_dat_i => core_dat_i,
    core_we_o  => core_we_o(0),
	 
	 mmu_adr_o => mmu_adr_o,
    mmu_dat_o => mmu_dat_o,
    mmu_dat_i => mmu_dat_i,
    mmu_we_o  => mmu_we_o(0)
    
	 );
  
  -- 
  -- Core data memory
  --
  
	ram: block_ram_64x8 port map (
	 
	 clka 	=> clk_i,
	 wea 		=> core_we_o,
	 addra 	=> core_adr_o,
	 dina 	=> core_dat_o,
	 douta	=> core_dat_i,
	 
	 clkb 	=> clk_i,
	 web		=> mmu_we_o,
	 addrb 	=> mmu_adr_o,
	 dinb 	=> mmu_dat_o,
	 doutb	=> mmu_dat_i
 );
  
--  ram : RAM_128B PORT MAP(
--    clk_i => clk_i,
--    rst_i => rst_n,
--    adr_i => core_adr_o(6 DOWNTO 0),
--    dat_i => core_dat_o,
--    dat_o => core_dat_i(7 DOWNTO 0),
--    we_i  => core_we_o,
--    stb_i => core_stb_o(0),
--    ack_o => core_ack_i(0) ); 
  
  --
  -- Input / Output Port A
  --
  
--  IO_PA : picoblaze_io_port
--  PORT MAP(
--    clk_i   => clk_i,
--    rst_i   => rst_n,
--    adr_i   => core_adr_o(1 DOWNTO 0),
--    dat_i   => core_dat_o,
--    dat_o   => core_dat_i(15 DOWNTO 8),
--    we_i    => core_we_o,
--    stb_i   => core_stb_o(1),
--    ack_o   => core_ack_i(1),
--    cyc_i   => core_cyc_o,
--    int_o   => core_irq_vec(0),
--    p_dat_o => pio_A_dat_o,
--    p_dat_i => pio_A_dat_i ); 
--	
--  --
--  -- Input / Output Port B
--  --
--	
--  IO_PB : picoblaze_io_port
--  PORT MAP(
--    clk_i   => clk_i,
--    rst_i   => rst_n,
--    adr_i   => core_adr_o(1 DOWNTO 0),
--    dat_i   => core_dat_o,
--    dat_o   => core_dat_i(23 DOWNTO 16),
--    we_i    => core_we_o,
--    stb_i   => core_stb_o(2),
--    ack_o   => core_ack_i(2),
--    cyc_i   => core_cyc_o,
--    int_o   => core_irq_vec(1),
--    p_dat_o => pio_B_dat_o,
--    p_dat_i => pio_B_dat_i ); 
--	 

END picoblaze_top_level_arch;


