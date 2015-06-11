--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:52:34 03/26/2015
-- Design Name:   
-- Module Name:   H:/workspace/stuff/mmu_test_bench.vhd
-- Project Name:  stuff
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mmu_main
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
use ieee.std_logic_arith.all;


use work.system_params.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY mmu_test_bench IS

	constant tlb_test_full : tlb_init_array :=
	(
	x"00000000" & "001000",
	x"00010001" & "001000",
	x"00020002" & "001000",
	x"00030003" & "001000",
	x"00040004" & "001000",
	x"00050005" & "001000",
	x"00060006" & "001000",
	x"00070007" & "001000",
	x"00080008" & "001000",
	x"00090009" & "001000",
	x"000A000A" & "001000",
	x"000B000B" & "001000",
	x"000C000C" & "001000",
	x"000D000D" & "001000",
	x"000E000E" & "001000",
	x"000F000F" & "001000",
	x"00100010" & "001000",
	x"00110011" & "001000",
	x"00120012" & "001000",
	x"00130013" & "001000",
	x"00140014" & "001000",
	x"00150015" & "001000",
	x"00160016" & "001000",
	x"00170017" & "001000",
	x"00180018" & "001000",
	x"00190019" & "001000",
	x"001A001A" & "001000",
	x"001B001B" & "001000",
	x"001C001C" & "001000",
	x"001D001D" & "001000",
	x"001E001E" & "001000",
	x"001F001F" & "001000",
	x"00200020" & "001000",
	x"00210021" & "001000",
	x"00220022" & "001000",
	x"00230023" & "001000",
	x"00240024" & "001000",
	x"00250025" & "001000",
	x"00260026" & "001000",
	x"00270027" & "001000",
	x"00280028" & "001000",
	x"00290029" & "001000",
	x"002A002A" & "001000",
	x"002B002B" & "001000",
	x"002C002C" & "001000",
	x"002D002D" & "001000",
	x"002E002E" & "001000",
	x"002F002F" & "001000",
	x"00300030" & "001000",
	x"00310031" & "001000",
	x"00320032" & "001000",
	x"00330033" & "001000",
	x"00340034" & "001000",
	x"00350035" & "001000",
	x"00360036" & "001000",
	x"00370037" & "001000",
	x"00380038" & "001000",
	x"00390039" & "001000",
	x"003A003A" & "001000",
	x"003B003B" & "001000",
	x"003C003C" & "001000",
	x"003D003D" & "001000",
	x"003E003E" & "001000",
	x"003F003F" & "001000"
	
	);
	
	constant tlb_test_empty : tlb_init_array :=
	(others => x"00000000" & "000000");
	

END mmu_test_bench;
 
ARCHITECTURE behavior OF mmu_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mmu_main
	 generic (tlb_init		: tlb_init_array);
    PORT(
         v_addr_in : IN  std_logic_vector(23 downto 0);
         ram_data_in : IN  std_logic_vector(7 downto 0);
         ram_data_o : OUT  std_logic_vector(7 downto 0);
         ram_addr_o : OUT  std_logic_vector(15 downto 0);
         ram_we_o : OUT  std_logic;
         p_addr_o : OUT  std_logic_vector(23 downto 0);
         flags_o : OUT  std_logic_vector(5 downto 0);
         busy_o : OUT  std_logic;
         p_fault_o : OUT  std_logic;
         pt_base_in : IN  std_logic_vector(15 downto 0);
			real_mode		: in 	STD_LOGIC;
         r_stb : IN  std_logic;
         w_stb : IN  std_logic;
         priv_stb : IN  std_logic;
         clk : IN  std_logic;
         rst_n : IN  std_logic
        );
    END COMPONENT;
    
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

   --Inputs
   signal v_addr_in : std_logic_vector(23 downto 0) := (others => '0');
   signal ram_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal pt_base_in : std_logic_vector(15 downto 0) := x"0040";
	signal real_mode : std_logic := '0';
   signal r_stb : std_logic := '0';
   signal w_stb : std_logic := '0';
   signal priv_stb : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
	signal addrb : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
	signal dinb : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
	signal wea	: std_logic_vector(0 downto 0);
	signal web	: std_logic_vector(0 downto 0) := (others => '0');
			

 	--Outputs
   signal ram_data_o : std_logic_vector(7 downto 0);
   signal ram_addr_o : std_logic_vector(15 downto 0);
   signal ram_we_o : std_logic;
   signal p_addr_o : std_logic_vector(23 downto 0);
   signal flags_o : std_logic_vector(5 downto 0);
   signal busy_o : std_logic;
   signal p_fault_o : std_logic;
	signal doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	
	
	
	

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	type test_phase is (
		n100, n101, n102, n103, n104, n105, n106, 
		n201, n202, n203,
		n300, n301, n302, 
		n401, n402, n403, 
		n501, n502, 
		n601, n602, n603,
		n700,
		n800,
		n900
	);
	signal phase : test_phase;
	

BEGIN
 
	wea(0) <= ram_we_o;
 
	ram: block_ram_64x8 port map (
	    clka 	=> clk,
		 wea 		=> wea,
		 addra 	=> ram_addr_o,
		 dina 	=> ram_data_o,
		 douta	=> ram_data_in,
		 clkb => clk,
		 web => web,
		 addrb => addrb,
		 dinb => dinb,
		 doutb => doutb
	 );
	-- Instantiate the Unit Under Test (UUT)
   uut: mmu_main 
	generic map (
		tlb_init => tlb_test_empty
	) 
	PORT MAP (
          v_addr_in => v_addr_in,
          ram_data_in => ram_data_in,
          ram_data_o => ram_data_o,
          ram_addr_o => ram_addr_o,
          ram_we_o => ram_we_o,
          p_addr_o => p_addr_o,
          flags_o => flags_o,
          busy_o => busy_o,
          p_fault_o => p_fault_o,
          pt_base_in => pt_base_in,
			 real_mode => real_mode,
          r_stb => r_stb,
          w_stb => w_stb,
          priv_stb => priv_stb,
          clk => clk,
          rst_n => rst_n
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
--   	signal v_addr_in : std_logic_vector(23 downto 0) := (others => '0');
--   	signal ram_data_in : std_logic_vector(7 downto 0) := (others => '0');
--   	signal pt_base_in : std_logic_vector(15 downto 0) := (others => '0');
--		signal real_mode : std_logic := '0';
--   	signal r_stb : std_logic := '0';
--   	signal w_stb : std_logic := '0';
--	   signal priv_stb : std_logic := '0';
--   	signal clk : std_logic := '0';
--   	signal rst_n : std_logic := '0';
--		signal addrb : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
--		signal dinb : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
--		signal wea	: std_logic_vector(0 downto 0);
--		signal web	: std_logic_vector(0 downto 0) := (others => '0');


   -- Stimulus process
   stim_proc: process
	variable row : integer := 0;
   begin

		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		
		rst_n <= '1';
      wait for clk_period*10;
		
--		-- TEST SERIES 1 			--
--		-- TLB Miss & Page Miss --
--		phase <= n100;
--		
--		r_stb <= '1'; w_stb <= '1';
--		v_addr_in <= x"ffff00";
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0';
--		wait until busy_o = '0';
--		
--		phase <= n102;
--		
--		r_stb <= '1'; w_stb <= '1';
--		v_addr_in <= x"010000";
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0';
--		wait until busy_o = '0';
--		
--		r_stb <= '1'; w_stb <= '1';
--		v_addr_in <= x"ff0000";
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0';
--		wait until busy_o = '0';
--		
--		
--
--		phase <= n104;
--		
--		r_stb <= '1'; w_stb <= '1';
--		v_addr_in <= x"008000";
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0';
--		wait until busy_o = '0';
--		
--		r_stb <= '1'; w_stb <= '1';
--		v_addr_in <= x"00f000";
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0';
--		wait until busy_o = '0';
--		
--		r_stb <= '1'; w_stb <= '1';
--		v_addr_in <= x"00ff00";
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0';
--		wait until busy_o = '0';
--		
--
--		phase <= n106;
--		r_stb <= '1'; w_stb <= '1'; priv_stb <= '1';
--		v_addr_in <= x"004000";
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0'; priv_stb <= '0';
--		wait until busy_o = '0';
--		
--		-- TEST SERIES 2 			--
--		-- tlb miss & page access fault
--		phase <= n201;
--		r_stb <= '1';
--		v_addr_in <= x"003f00";
--		wait for clk_period;
--		r_stb <= '0';
--		wait until busy_o = '0';
--		
--		phase <= n202;
--		w_stb <= '1';		
--		wait for clk_period;
--		w_stb <= '0';		
--		wait until busy_o = '0';
--		
--		phase <= n203;
--		r_stb <= '1'; w_stb <= '1';
--		wait for clk_period;
--		r_stb <= '0'; w_stb <= '0';
--		wait until busy_o = '0';
		
		
		-- TEST SERIES 4 			--
		-- tlb miss, page hit, new wb
		phase <= n401;
		priv_stb <= '1';
		
		--write tlb_entries
		for i in 0 to 63 loop
			
			v_addr_in <= std_logic_vector(to_unsigned(i, 16) & x"00");
			
			if (i mod 2 = 0) then
				r_stb <= '1'; w_stb <= '0';
			else
				w_stb <= '1'; r_stb <= '0';
			end if;
			
			wait for clk_period;
			w_stb <= '0'; r_stb <= '0';
			v_addr_in <= (others => '0');
			wait until busy_o = '0';
--			wait until busy_o = '0';
			wait for clk_period;
			wait until clk = '0';
		
		end loop;
		
		
--		--read PTEs
--		for i in 0 to 63 loop
--			for k in 0 to 3 loop
--				row := (i * 4) + k + 8768;
--				addrb <= std_logic_vector(to_unsigned(row, 16));
--				wait for clk_period;
--			end loop;
--			wait for clk_period;
--		end loop;
--	
--		
		wait for clk_period;
		
		phase <= n402;
		wait for clk_period;
		
		phase <= n403;
		wait for clk_period / 2;
		
		-- TEST SERIES 6 			--
		-- TLB Hit
		phase <= n601;
		
		-- read entries from tlb, set both flags
		
		for i in 0 to 63 loop
			
			v_addr_in <= std_logic_vector(to_unsigned(i, 16) & x"00");
			
			if (i mod 2 = 0) then
				r_stb <= '0'; w_stb <= '1';
			else
				w_stb <= '0'; r_stb <= '1';
			end if;
			
			wait for clk_period;
			w_stb <= '0'; r_stb <= '0';
			
			wait until clk = '0';
		
		end loop;
		
		wait for clk_period;
		
		-- TEST SERIES 5 			--
		-- TLB miss, page hit, tlb evict
		phase <= n501;
		
		for i in 64 to 127 loop
			
			v_addr_in <= std_logic_vector(to_unsigned(i, 16) & x"00");
			
			if (i mod 2 = 0) then
				r_stb <= '1'; w_stb <= '0';
			else
				w_stb <= '1'; r_stb <= '0';
			end if;
			
			wait for clk_period;
			w_stb <= '0'; r_stb <= '0';
			v_addr_in <= (others => '0');
			wait until busy_o = '0';
			wait until busy_o = '0';
			wait until clk = '0';
			wait for clk_period;
		
		end loop;
		
		wait for clk_period;
		
		phase <= n502;
		wait for clk_period;
		

		
		phase <= n602;
		wait for clk_period;
		
		r_stb <= '1'; w_stb <= '1';
		v_addr_in <= x"004000";
		wait for clk_period;
		r_stb <= '0'; w_stb <= '0';
		wait for clk_period;
		
		r_stb <= '1'; w_stb <= '1';
		v_addr_in <= x"005500";
		wait for clk_period;
		r_stb <= '0'; w_stb <= '0';
		wait for clk_period;
		
		r_stb <= '1'; w_stb <= '1';
		v_addr_in <= x"006600";
		wait for clk_period;
		r_stb <= '0'; w_stb <= '0';
		wait for clk_period;
		
		r_stb <= '1'; w_stb <= '1';
		v_addr_in <= x"002000";
		wait for clk_period;
		r_stb <= '0'; w_stb <= '0';
		wait for clk_period;
		wait until busy_o = '0';
		wait until busy_o = '0';
		
		v_addr_in <= (others => '0');
		-- TEST SERIES 7, 8 & 9		--
		-- No access without r/w stb 	--
		phase <= n700;
		wait for clk_period;
		
		for i in 32 to 95 loop
			
			v_addr_in <= std_logic_vector(to_unsigned(i, 16) & x"00");

			wait for clk_period;
			
			wait until clk = '0';
		
		end loop;
		v_addr_in <= (others => '0');
		-- real mode enabled
		phase <= n800;
		
		real_mode <= '1';
		
		wait for clk_period;
		
				for i in 127 to 512 loop
			
				v_addr_in <= std_logic_vector(to_unsigned(i, 16) & x"11");

			wait for clk_period;
		
		end loop;
		
		real_mode <= '0';
		v_addr_in <= (others => '0');
		-- mmu reset
		phase <= n900;
		wait for clk_period;
		
		rst_n <= '0';
		wait for clk_period;

		--check values manually

      -- insert stimulus here 

      wait;
   end process;

END;
