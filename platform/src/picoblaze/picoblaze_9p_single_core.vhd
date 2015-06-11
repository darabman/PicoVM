-- =============================================================================================================
-- *
-- * Copyright (c) M.Freeman
-- *
-- * File Name: picoblaze_4p_single_core.vhd
-- *
-- * Version: V1.0
-- *
-- * Release Date:
-- *
-- * Author(s): M.Freeman
-- *
-- * Description: Single core picoblaze, 4 port
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

LIBRARY UNISIM;
USE UNISIM.VCOMPONENTS.ALL;

ENTITY picoblaze_9p_single_core IS
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
  --core_stb_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
  --core_cyc_o : OUT STD_LOGIC;

	-- may be necessary for interface with paging/DMA device
  --core_irq_i : IN STD_LOGIC;
  --core_irq_o : OUT STD_LOGIC
  );
END picoblaze_9p_single_core;

ARCHITECTURE picoblaze_9p_single_core_arch OF picoblaze_9p_single_core IS

  --
  -- components
  --

  --
  -- processor
  --

  COMPONENT picoblaze IS
  GENERIC (
    MAIN_MIN : INTEGER  := 16#000#;
    MAIN_MAX : INTEGER  := 16#2FF#;
    ISR_MIN  : INTEGER  := 16#3FF#;
    ISR_MAX  : INTEGER  := 16#3FF#;
    SUB_MIN  : INTEGER  := 16#300#;
    SUB_MAX  : INTEGER  := 16#3FE# );
  PORT (
    clk_i : IN STD_LOGIC ;
    rst_i : IN STD_LOGIC ;

    d_adr_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  -- processor data bus
    d_dat_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    d_dat_o : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    --d_we_o : OUT STD_LOGIC;
    --d_stb_o : OUT STD_LOGIC;
	 r_stb_o : out std_logic;
	 w_stb_o : out std_logic;
    --d_ack_i : IN STD_LOGIC;

    i_adr_o : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);  -- processor instruction bus
    i_dat_i : IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
    i_stb_o : OUT STD_LOGIC;
    --i_ack_i : IN STD_LOGIC;

    int_i : IN STD_LOGIC;
    int_ack_o : OUT STD_LOGIC );

  END COMPONENT;

  COMPONENT mmu_main
  PORT(
		v_addr_in 	: IN  std_logic_vector(23 downto 0);
		
		ram_data_in : IN  std_logic_vector(7 downto 0);
		ram_data_o 	: OUT  std_logic_vector(7 downto 0);
		ram_addr_o 	: OUT  std_logic_vector(15 downto 0);
		ram_we_o 	: OUT  std_logic;
		
		p_addr_o 	: OUT  std_logic_vector(23 downto 0);
		flags_o 		: OUT  std_logic_vector(5 downto 0);
		
		busy_o 		: OUT  std_logic;
		p_fault_o 	: OUT  std_logic;
		
		pt_base_in 	: IN  std_logic_vector(15 downto 0);
		real_mode	: IN 	STD_LOGIC;
		r_stb 		: IN  std_logic;
		w_stb 		: IN  std_logic;
		priv_stb 	: IN  std_logic;
		
		clk 			: IN  std_logic;
		rst_n 		: IN  std_logic
	  );
  END COMPONENT;

  --
  -- instruction memory
  --
  
  COMPONENT ROM_1024
  PORT (  
    clk_i : IN STD_LOGIC;
    rst_i : IN STD_LOGIC;
    port_a_adr_i : IN STD_LOGIC_VECTOR ( 9 DOWNTO 0 );
    port_a_dat_o : OUT STD_LOGIC_VECTOR ( 17 DOWNTO 0 );
    port_a_stb_i : IN STD_LOGIC;
    port_a_ack_o : OUT STD_LOGIC  );
  END COMPONENT;
  
  --
  -- instruction memory mirror
  --
  
  COMPONENT blockram_1024x16bit
  PORT (
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;  
    addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    data_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);  
    data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
  END COMPONENT;
    
--  --
--  -- address decoder
--  --
--
--  COMPONENT system_bus_address_decoder9
--  PORT(
--    clk_i : IN STD_LOGIC;
--    rst_i : IN STD_LOGIC;
--    adr_i : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    ce_o : OUT STD_LOGIC_VECTOR(8 DOWNTO 0) );
--  END COMPONENT;
--
--  --
--  -- data mux
--  --
--
--  COMPONENT system_bus_mux9
--  GENERIC(
--    width : INTEGER := 8 );
--  PORT(
--    din_a : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    din_b : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    din_c : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    din_d : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    din_e : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    din_f : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    din_g : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    din_h : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);	 
--    din_i : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);	 	 
--    din_default : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    dout : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    sel : IN STD_LOGIC_VECTOR(8 DOWNTO 0) );
--  END COMPONENT;
--
--  --
  -- pipeline register
  --

--  COMPONENT reg
--  GENERIC (
--    width : INTEGER := 32 );
--  PORT (
--    clk : IN STD_LOGIC;
--    clr : IN STD_LOGIC;
--    en : IN STD_LOGIC;
--    rst : IN STD_LOGIC;
--    din : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
--    dout : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0));
--  END COMPONENT;

  component shift_register is
   generic (
		width : integer := 16;
		count : integer := 10
	);
	port(
      clk      : in  std_logic;
      reset     : in  std_logic;
      data_in  : in  std_logic_vector(width - 1 downto 0);
		--data_out 	: out std_logic_vector(width - 1 downto 0)
      tail_out 	: out std_logic_vector(width - 1 downto 0)
   );
	end component;

  --
  -- signals
  --

  SIGNAL GND     : STD_LOGIC;
  SIGNAL VCC     : STD_LOGIC;
  SIGNAL GND_BUS : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL GND_BUS_16 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  
  signal core_reset : std_logic := '1';
  --
  -- Core
  --
  
  signal core_irq_o		: std_logic;
  
  SIGNAL core_i_adr_o   : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL core_i_dat_i   : STD_LOGIC_VECTOR(17 DOWNTO 0);
  

  SIGNAL core_i_stb_o   : STD_LOGIC;
  
  -- io for pblaze
  signal ext_data_o		: std_logic_vector(7 downto 0);
  signal ext_addr_o		: std_logic_vector (15 downto 0);
  signal core_data_o		: std_logic_vector(7 downto 0);
  signal core_i_ack_i : std_logic;
  
  



  ---
  --- Custom Signals
  ---
  
  signal v_address  : std_logic_vector(23 downto 0);
  signal p_fault	  : std_logic;
  signal p_fault_in : std_logic := '0';
  
  signal mmu_addr_o	: std_logic_vector(23 downto 0);
  signal mmu_flags_o : std_logic_vector(5 downto 0);  
  signal mmu_busy	  	: std_logic;
  signal r_stb			: std_logic;
  signal w_stb			: std_logic;
  
  signal istr_clk	  : std_logic;
  signal cpu_clk	  : std_logic;
  
  signal sr_reset		: std_logic;
  signal sr_in			: std_logic_vector (8 downto 0);
  signal sr_out	: std_logic_vector(8 downto 0);
  
  -- These are place holders for an implementation where 
  -- the values are registered on board the picoblaze
  signal PAGE_TABLE_BASE : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0040";
  signal SVC_MODE			 : STD_LOGIC := '1';
  signal REAL_MODE		 :	std_logic := '0';
  
  signal junk_reg_i	    : std_logic_vector(15 downto 0);
  signal junk_reg_o	    : std_logic_vector(15 downto 0);

BEGIN

  --
  -- signal buffers
  --

  VCC <= '1';
  GND <= '0';
  GND_BUS <= (OTHERS=>'0');
  GND_BUS_16 <= (OTHERS=>'0');

	
	
	sr_in(8 downto 0) <= w_stb & core_data_o;
	core_adr_o <= ext_addr_o;
	core_dat_o <= ext_data_o;
	
	core_reset <= not rst_i;

  -- ################
  -- #  Components  #
  -- ################

  -- 
  -- Core instruction memory
  --

  rom : ROM_1024 PORT MAP(
    clk_i        => istr_clk,
    rst_i        => rst_i,
	 
    port_a_adr_i => core_i_adr_o,
    port_a_dat_o => core_i_dat_i,
    
	 port_a_stb_i => core_i_stb_o,
	 --ack just loops back stb_i
    port_a_ack_o => core_i_ack_i );

  -- 
  -- Core address memory
  --
  
  rom_extended : blockram_1024x16bit PORT MAP(
    clk      => istr_clk,
    we       => GND,
    addr     => core_i_adr_o,
    data_in  => GND_BUS_16,
    data_out => v_address(23 downto 8) );

---
---
---

	data_sreg : shift_register
	generic map ( width => 9, count => 11)
	port map(
      clk => clk_i,
      reset => sr_reset,
      data_in  => sr_in,
      tail_out => sr_out

   );
  --
  -- Core processor
  --

  core_cpu : picoblaze 
  PORT MAP(
    clk_i     => cpu_clk,
    rst_i     => core_reset,
    
	 d_adr_o   => v_address(7 downto 0),
    d_dat_i   => core_dat_i,
    d_dat_o   => core_data_o,
    --d_we_o    => core_we_o,
    
	 r_stb_o   => r_stb,
	 w_stb_o   => w_stb,
    
    i_adr_o   => core_i_adr_o,
    i_dat_i   => core_i_dat_i,
    i_stb_o   => core_i_stb_o,
    
    int_i     => p_fault_in,
    
	 --ack out to reg, unless MMU needs it?
	 int_ack_o => core_irq_o
	 );
	 
	mmu : mmu_main
	PORT MAP (
          v_addr_in => v_address,
          
			 ram_data_in => mmu_dat_i,          
			 ram_data_o => mmu_dat_o,
          ram_addr_o => mmu_adr_o,
          ram_we_o => mmu_we_o,
          
			 p_addr_o => mmu_addr_o,
          flags_o => mmu_flags_o,
          busy_o => mmu_busy,
          p_fault_o => p_fault,
          
			 pt_base_in => PAGE_TABLE_BASE,
			 real_mode => REAL_MODE,
          
			 r_stb => r_stb,
          w_stb => w_stb,
          priv_stb => SVC_MODE,
          
			 clk => clk_i,
          rst_n => rst_i
        );



	junk_reg :
	process (clk_i, core_irq_o, mmu_flags_o, core_i_ack_i, mmu_addr_o, junk_reg_o)--, junk_reg_o, core_irq_o, mmu_flags_o)
	begin
	
		if clk_i = '1' then
			junk_reg_i <= junk_reg_o;
		else
			junk_reg_i <= core_irq_o & mmu_flags_o & core_i_ack_i & mmu_addr_o(23 downto 16);
		end if;
	end process;
	
	latch_pfault :
	process (clk_i, p_fault, core_irq_o)
	begin
		if rising_edge(clk_i) then
		
			if (p_fault = '1') then
				p_fault_in <= '1';
			
			end if;
			
			if core_irq_o = '1' then
				p_fault_in <= '0';
			end if;
		
		end if;
	end process;
	
	stall_cpu :
	process (mmu_busy, clk_i, sr_out, w_stb, core_data_o)
	variable last_clk : std_logic := '0';
	begin

		if mmu_busy = '1' then
			core_we_o  <= sr_out(8) and not p_fault;
			ext_data_o <= sr_out(7 downto 0);

			sr_reset <= '1';
			istr_clk <= last_clk;
			cpu_clk <= last_clk;
		else
			--dirty, nasty hack
			if p_fault = '1' then
				ext_data_o <= v_address(23 downto 16);
				core_we_o <= '1';
				ext_addr_o <= x"FFFE";
			else
				core_we_o  <= w_stb and not p_fault;
				ext_data_o <= core_data_o;
				ext_addr_o <= mmu_addr_o(15 downto 0);
			end if;
			
			sr_reset <= '0';
			last_clk := clk_i;
			istr_clk <= clk_i;
			cpu_clk  <= clk_i;
		end if;
		

	
	end process;

  --
  -- Core data bus addr pipeline register
  --

--  core_adr_pipeline_reg : reg
--  GENERIC MAP(
--    width => 8 )
--  PORT MAP(
--    clk => clk_i,
--    clr => rst_i,
--    en => VCC,
--    rst => GND,
--    din => core_d_adr_o,
--    dout => core_d_adr_p_o );
--
--  --
--  -- Core data bus data out pipeline register
--  --
--
--  ext_data_out_pipeline_reg : reg
--  GENERIC MAP(
--    width => 8 )
--  PORT MAP(
--    clk => clk_i,
--    clr => rst_i,
--    en => VCC,
--    rst => GND,
--    din => core_d_dat_o,
--    dout => core_d_dat_p_o );

  --
  -- Core system bus address decoder
  --
  
  --
  -- Address decoder
  -- ---------------
  -- 
  -- Addr Min          Addr Max          Range    Description
  -- 00000000 (00h)    01111111 (3Fh)    128      RAM
  -- 10000000 (80h)    10001111 (8Fh)    16       User defined
  -- 10010000 (90h)    10011111 (9Fh)    16       User defined
  -- 10100000 (A0h)    10101111 (AFh)    16       User defined
  -- 10110000 (B0h)    10111111 (BFh)    16       User defined  
  -- 11000000 (C0h)    11001111 (CFh)    16       User defined
  -- 11010000 (D0h)    11011111 (DFh)    16       User defined
  -- 11100000 (E0h)    11101111 (EFh)    16       User defined
  -- 11110000 (F0h)    11111111 (FFh)    16       User defined  
  --
  
--  core_addr_dec : system_bus_address_decoder9
--  PORT MAP(
--    clk_i => clk_i,
--    rst_i => rst_i,
--    adr_i => core_d_adr_o,
--    ce_o => core_ce_o );

  --
  -- Core slave data out mux
  --

--  core_data_mux : system_bus_mux9
--  GENERIC MAP(
--    width => 8 )
--  PORT MAP(
--    din_a => core_dat_i(7 DOWNTO 0),
--    din_b => core_dat_i(15 DOWNTO 8),
--    din_c => core_dat_i(23 DOWNTO 16),
--    din_d => core_dat_i(31 DOWNTO 24),
--    din_e => core_dat_i(39 DOWNTO 32),
--    din_f => core_dat_i(47 DOWNTO 40),
--    din_g => core_dat_i(55 DOWNTO 48),
--    din_h => core_dat_i(63 DOWNTO 56),	
--    din_i => core_dat_i(71 DOWNTO 64),		 
--    din_default => GND_BUS,
--    dout  => core_d_dat_i,
--    sel => core_ce_o );


END picoblaze_9p_single_core_arch;


