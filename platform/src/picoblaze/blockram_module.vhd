-- =============================================================================================================
-- *
-- * Copyright (c) University of York
-- *
-- * File Name: blockram_module.vhd
-- *
-- * Version: V1.0
-- *
-- * Release Date:
-- *
-- * Author(s): M.Freeman
-- *
-- * Description: Random Access Memory single port module
-- *
-- * Change History:  $Author: $
-- *                  $Date: $
-- *                  $Revision: $
-- *
-- * Conditions of Use: THIS CODE IS COPYRIGHT AND IS SUPPLIED "AS IS" WITHOUT WARRANTY OF ANY KIND, INCLUDING,
-- *                    BUT NOT LIMITED TO, ANY IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS FOR A
-- *                    PARTICULAR PURPOSE.
-- *
-- =============================================================================================================
 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
LIBRARY UNISIM;
USE UNISIM.vcomponents.ALL;
 
ENTITY blockram_1024x16bit IS
PORT (
  clk : IN STD_LOGIC;
  we : IN STD_LOGIC;  
  addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
  data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);  
  data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
END blockram_1024x16bit;
 
ARCHITECTURE blockram_1024x16bit_arch OF blockram_1024x16bit IS

  COMPONENT RAMB16_S18
  GENERIC(
    INIT_00 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_01 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_02 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_03 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_04 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_05 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_06 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_07 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_08 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_09 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_0F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_10 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_11 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_12 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_13 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_14 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_15 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_16 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_17 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_18 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_19 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_1F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_20 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_21 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_22 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_23 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_24 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_25 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_26 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_27 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_28 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_29 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_2F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_30 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_31 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_32 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_33 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_34 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_35 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_36 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_37 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_38 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_39 : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3A : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3B : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3C : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3D : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3E : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000";
    INIT_3F : BIT_VECTOR := X"0000000000000000000000000000000000000000000000000000000000000000" );
  PORT (
    DO : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    DOP : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);    
    DI : IN STD_LOGIC_VECTOR (15 DOWNTO 0); 
    DIP : IN STD_LOGIC_VECTOR (1 DOWNTO 0);     
    ADDR : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    CLK : IN STD_ULOGIC;
    EN : IN STD_ULOGIC;
    SSR : IN STD_ULOGIC;
    WE : IN STD_ULOGIC ); 
  END COMPONENT;  

BEGIN
 
  ram_module : RAMB16_S18
  GENERIC MAP (  
    INIT_00 => X"0000008000000080000000230022000200000070006000500040000000000000",
    INIT_01 => X"0000000000000000000000000000000000000000000000000000009000000090",
    INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000" )  
  PORT MAP( 
      DO => data_out,
      dop => OPEN,    
      di => data_in,
      dip => "00",
      addr => addr, 
      clk => clk,    
      en => '1',
      ssr => '0',
      we => we );
  
END blockram_1024x16bit_arch;
 