-- =============================================================================================================
-- *
-- * Copyright (c) University of York
-- *
-- * File Name: picoblaze.vhd
-- *
-- * Version: V3.0
-- *
-- * Release Date:
-- *
-- * Author(s): M.Freeman
-- *
-- * Description: picoBlaze 8bit processor using the KCPSM3 cpu
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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY picoblaze IS
GENERIC (
  MAIN_MIN : INTEGER := 16#000#;
  MAIN_MAX : INTEGER := 16#2FF#;
  ISR_MIN : INTEGER  := 16#3FF#;
  ISR_MAX : INTEGER  := 16#3FF#;
  SUB_MIN : INTEGER  := 16#300#;
  SUB_MAX : INTEGER  := 16#3FE# );
PORT (
  clk_i : IN STD_LOGIC ;
  rst_i : IN STD_LOGIC ;

  d_adr_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- processor data bus
  d_dat_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
  d_dat_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  --d_we_o : OUT STD_LOGIC;

  r_stb_o : out std_logic;
  w_stb_o : out std_logic;

  i_adr_o : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);  -- processor instruction bus
  i_dat_i : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
  i_stb_o : OUT STD_LOGIC;


  int_i : IN STD_LOGIC;
  int_ack_o : OUT STD_LOGIC );
  
END picoblaze;

ARCHITECTURE picoblaze_arch OF picoblaze IS

  --
  -- components
  --

  COMPONENT kcpsm3 IS
  PORT (      
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    address : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    instruction : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    port_id : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    write_strobe : OUT STD_LOGIC;
    out_port : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    read_strobe : OUT STD_LOGIC;
    in_port : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    interrupt : IN STD_LOGIC;
    interrupt_ack : OUT STD_LOGIC );
  END COMPONENT;
  
  --
  -- signals
  --

  SIGNAL read_stb_int : STD_LOGIC;
  SIGNAL write_stb_int : STD_LOGIC;
  
  SIGNAL i_adr : STD_LOGIC_VECTOR(9 DOWNTO 0); 
  
  SIGNAL MAIN_PROGRAM : STD_LOGIC;
  SIGNAL ISR_PROGRAM : STD_LOGIC;
  SIGNAL SUB_PROGRAM : STD_LOGIC;
  
  signal irq_stb_1 : std_logic;
  signal irq_stb_2 : std_logic;
  
BEGIN

  --
  -- signal buffers
  --
  
  irq_stb_1 <= int_i;
  irq_stb_2 <= irq_stb_1 after 5 ns;
  
  i_stb_o <= '1';  -- read a new instruction each cycle
  --d_we_o <= write_stb_int; -- buffer signal to allow internal read
  
  i_adr_o <= i_adr;
  
  w_stb_o <= write_stb_int;
  r_stb_o <= read_stb_int;
  
  --
  -- processes
  --
  
--  data_strobe : PROCESS(read_stb_int, write_stb_int)
--  BEGIN
--    IF write_stb_int='1' or read_stb_int='1'
--    THEN
--      d_stb_o <= '1';
--    ELSE
--      d_stb_o <= '0'; 
--    END IF;
--  END PROCESS;  
--    
  --
  -- components
  --

  processor : kcpsm3 PORT MAP ( 
    clk => clk_i,
    reset => rst_i,
    address => i_adr,
    instruction => i_dat_i,
    port_id => d_adr_o,
    write_strobe => write_stb_int ,
    read_strobe => read_stb_int ,
    in_port => d_dat_i,
    out_port => d_dat_o,
    interrupt => irq_stb_2 ,
    interrupt_ack	=> int_ack_o ) ;

  --
  -- SIMULATION SIGNALS
  --

  core_1_simulation : PROCESS (i_adr)
  BEGIN
    IF conv_integer(i_adr) >= MAIN_MIN and conv_integer(i_adr) <= MAIN_MAX
    THEN
      MAIN_PROGRAM <= '1';
    ELSE
      MAIN_PROGRAM <= '0';
    END IF;  
    
    IF conv_integer(i_adr) >= ISR_MIN and conv_integer(i_adr) <= ISR_MAX
    THEN
      ISR_PROGRAM <= '1';
    ELSE
      ISR_PROGRAM <= '0';
    END IF;  
    
    IF conv_integer(i_adr) >= SUB_MIN and conv_integer(i_adr) <= SUB_MAX
    THEN
      SUB_PROGRAM <= '1';
    ELSE
      SUB_PROGRAM <= '0';
    END IF;  
    
  END PROCESS;

END picoblaze_arch;



