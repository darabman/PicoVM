-- =============================================================================================================
-- *
-- * Copyright (c) M.Freeman
-- *
-- * File Name: picoblaze_io_port.vhd
-- *
-- * Version: V1.0
-- *
-- * Release Date:
-- *
-- * Author(s): M.Freeman
-- *
-- * Description: Registered input / ouput port
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

ENTITY picoblaze_io_port IS
PORT (
  clk_i   : IN STD_LOGIC;
  rst_i   : IN STD_LOGIC;
  adr_i   : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
  dat_i   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  
  dat_o   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  we_i    : IN STD_LOGIC;
  stb_i   : IN STD_LOGIC; 
  ack_o   : OUT STD_LOGIC;
  cyc_i   : IN STD_LOGIC; 
  int_o   : OUT STD_LOGIC;
  p_dat_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  p_dat_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0) ); 
END picoblaze_io_port;

ARCHITECTURE picoblaze_io_port_arch OF picoblaze_io_port IS 

  COMPONENT pulse_sync
  PORT (
    clk: IN STD_LOGIC;
    clr: IN STD_LOGIC;
    pulse_i: IN STD_LOGIC;
    pulse_o: OUT STD_LOGIC;
    pulse_d: OUT STD_LOGIC );
  END COMPONENT;

  SIGNAL input_int : STD_LOGIC_VECTOR(7 DOWNTO 0); 
  SIGNAL output_int : STD_LOGIC_VECTOR(7 DOWNTO 0); 
  SIGNAL irq_int : STD_LOGIC;
    
BEGIN

  --
  -- signal buffers
  --
  
  ack_o <= stb_i and cyc_i;
  
  p_dat_o <= output_int;
  
  --
  -- processes
  --

  -- input register
  --
  input_inst : PROCESS (clk_i, rst_i)    
  BEGIN
    IF rst_i='1'
    THEN
      input_int <= (OTHERS=>'0');
    ELSIF clk_i='1' and clk_i'event
    THEN
      IF adr_i="00" and we_i='1' and stb_i='1' and cyc_i='1'
      THEN
        input_int <= p_dat_i;
      END IF;
    END IF;  
  END PROCESS;
  
  -- output register
  --
  output_inst : PROCESS (clk_i, rst_i)    
  BEGIN
    IF rst_i='1'
    THEN
      output_int <= (OTHERS=>'0');
    ELSIF clk_i='1' and clk_i'event
    THEN
      IF adr_i="10" and we_i='1' and stb_i='1' and cyc_i='1'
      THEN
        output_int <= dat_i;
      END IF;
    END IF;  
  END PROCESS;
  
  --  Write
  --  "0X" & "000000" = latch input data
  --  "0X" & "000001" = NU
  --  "0X" & "000010" = write output data

  --  Read
  --  "0X" & "000000" = read latch input data
  --  "0X" & "000001" = read raw input data
  --  "0X" & "000010" = read output data

  dat_o_mux : PROCESS (adr_i, p_dat_i, input_int, output_int)    
  BEGIN
    CASE adr_i IS
	   WHEN "00"   => dat_o <= input_int;     -- registered input data 
		WHEN "01"   => dat_o <= p_dat_i;       -- raw input data
		WHEN "10"   => dat_o <= output_int;    -- registered output data
		WHEN "11"   => dat_o <= (OTHERS=>'0'); -- default
		WHEN OTHERS => dat_o <= (OTHERS=>'0'); -- default
    END CASE;  
  END PROCESS;

  -- interrupt request generator
  --
  irq_gen : PROCESS( input_int, p_dat_i )
  BEGIN
    IF input_int = p_dat_i
    THEN 
      irq_int <= '0';
    ELSE
      irq_int <= '1';
    END IF;
  END PROCESS;

  --
  -- components
  --

  -- irq pulser
  --
  irq_pulse : pulse_sync PORT MAP(
    clk => clk_i,
    clr => rst_i,
    pulse_i => irq_int,
    pulse_o => int_o,
    pulse_d => OPEN );


END picoblaze_io_port_arch;

