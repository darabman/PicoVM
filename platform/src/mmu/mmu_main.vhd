----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:01:43 03/24/2015 
-- Design Name: 
-- Module Name:    mmu_main - mmu_main_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.system_params.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mmu_main is
    
	 generic (
		va_width       : INTEGER := 16;
		data_width     : INTEGER := 38;
		flag_width		: INTEGER := 6;
		phys_mem_width : INTEGER := 16;
		
		tlb_size			: INTEGER := 64;
		index_width		: INTEGER := 6;
		tlb_init			: tlb_init_array := 
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
	
	)
		);
	 
	 Port (
		v_addr_in 		: in  STD_LOGIC_VECTOR (23 downto 0);
		ram_data_in 	: in  STD_LOGIC_VECTOR (7 downto 0);
		ram_data_o		: out STD_LOGIC_VECTOR (7 downto 0);
		ram_addr_o		: out STD_LOGIC_VECTOR (15 downto 0);
		ram_we_o			: out STD_LOGIC;
		
		p_addr_o 		: out  STD_LOGIC_VECTOR (23 downto 0);
		flags_o			: out STD_LOGIC_VECTOR (5 downto 0);
		busy_o			: out	STD_LOGIC;
		p_fault_o 		: out  STD_LOGIC;
		
		pt_base_in 		: in  STD_LOGIC_VECTOR (15 downto 0);
		real_mode		: in 	STD_LOGIC;
		r_stb 			: in  STD_LOGIC;
		w_stb 			: in  STD_LOGIC;
		priv_stb 		: in  STD_LOGIC;
		
		clk				: in STD_LOGIC;
		rst_n				: in STD_LOGIC
		);
end mmu_main;

architecture mmu_main_arch of mmu_main is

	component tlb_main is
	generic (tlb_init		: tlb_init_array);
	port (
		v_addr_in : in STD_LOGIC_VECTOR ( va_width - 1 DOWNTO 0);
		index_i	 : in STD_LOGIC_VECTOR ( index_width - 1 downto 0 ); -- log2 of tlb_size
		data_i    : in STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);

		index_o	 :	out STD_LOGIC_VECTOR (index_width - 1 downto 0);
		va_evict	 : out STD_LOGIC_VECTOR ( data_width - 1 DOWNTO phys_mem_width + flag_width);
		ppa_o     : out STD_LOGIC_VECTOR ( phys_mem_width - 1 DOWNTO 0);
		flags_o	 :	out STD_LOGIC_VECTOR ( flag_width - 1 downto 0);
		tlb_hit   : out STD_LOGIC;
		evict		 :	out STD_LOGIC;
		
		r_stb     : in STD_LOGIC;
		w_stb     : in STD_LOGIC;
		priv      : in STD_LOGIC;
		we			 : in STD_LOGIC;
		
		clk       : in STD_LOGIC;
		reset		 : in STD_LOGIC
	);
	end component;

	component pt_walk_main is
	Port ( 
		v_addr_in 	: in  STD_LOGIC_VECTOR (15 downto 0);
		--PT BASE IS (dbl) PAGE-ALIGNED! ( multiples of x0100 )
		pt_base_in 	: in  STD_LOGIC_VECTOR (15 downto 0);
		tlb_miss_in : in  STD_LOGIC;
		tlb_evict_in: in	STD_LOGIC;
		tlb_flags_in: in  STD_LOGIC_VECTOR(5 downto 0);
		
		ram_addr_o 	: out  STD_LOGIC_VECTOR (15 downto 0);
		ram_data_i 	: in  STD_LOGIC_VECTOR (7 downto 0);
		ram_data_o  : out STD_LOGIC_VECTOR (7 downto 0);
		ram_we		: out STD_LOGIC;
		
		tlb_wb_stb 	: out  STD_LOGIC;
		pte_o 		: out  STD_LOGIC_VECTOR (37 downto 0);
		
		r_stb 		: in  STD_LOGIC;
		w_stb 		: in  STD_LOGIC;
		priv_stb 	: in  STD_LOGIC;
		
		busy			: out STD_LOGIC; 
		p_fault_o 	: out STD_LOGIC;
		
		clk 			: in  STD_LOGIC;
		reset 		: in  STD_LOGIC
		);
	end component;

	component tlb_evict_counter is
	Port ( 
		index_i 	: in  STD_LOGIC_VECTOR (5 downto 0);
      index_o 	: out  STD_LOGIC_VECTOR (5 downto 0);
	   we		 	:	in	 STD_LOGIC;
		rw		 :	in	 STD_LOGIC;
      trigger 	: in  STD_LOGIC;
		rst_n	 	:	in  STD_LOGIC
		);
	end component;
	
	component shift_register is
   generic (
		width : integer := 16;
		count : integer := 10
	);
	port(
      clk      : in  std_logic;
      reset     : in  std_logic;
      data_in  : in  std_logic_vector(width - 1 downto 0);
		data_out 	: out std_logic_vector(width - 1 downto 0)
      --tail_out 	: out std_logic_vector(width - 1 downto 0)
   );
	end component;
	
	signal flag_mux				: STD_LOGIC_VECTOR(5 downto 0) := (others => '0');

	signal ptw_wb_stb				: STD_LOGIC;
	signal ptw_busy				: STD_LOGIC;
	signal pte_data				: STD_LOGIC_VECTOR(37 downto 0);
	
	signal ptw_tlb_miss			: STD_LOGIC;
	signal tlb_index_hit			: STD_LOGIC_VECTOR(5 downto 0);
	signal index_wb				: STD_LOGIC_VECTOR(5 downto 0);
	
	signal tlb_data				: STD_LOGIC_VECTOR(21 downto 0);
	signal tlb_hit					: STD_LOGIC;
	signal tlb_evict				: STD_LOGIC;
	signal tlb_evicted_va		: STD_LOGIC_VECTOR(15 downto 0);
	signal evict_buffer			: STD_LOGIC_VECTOR(22 downto 0);
	signal va_shared				: STD_LOGIC_VECTOR(15 downto 0);
	signal tec_write_op			: std_logic;
	
	signal rw_switch				: std_logic_vector(1 downto 0);

begin
	
	tec_write_op <= (r_stb or w_stb);
	ptw_tlb_miss <= (r_stb or w_stb) and not tlb_hit;
	flags_o	<= flag_mux;
	busy_o <= ptw_busy;
	--va_shared <= v_addr_in(23 downto 8) or tlb_evicted_va;
	
	tec : tlb_evict_counter
	port map( 
		index_i 	=> tlb_index_hit,
      index_o 	=> index_wb,
	   we		 	=> tlb_hit,
		rw		 	=> tec_write_op,
      trigger 	=> ptw_wb_stb,
		rst_n	 	=> rst_n
		);

	ptw : pt_walk_main
	port map (
		
		v_addr_in 	=> va_shared,
		pt_base_in 	=> pt_base_in,
		tlb_miss_in => ptw_tlb_miss,
		tlb_evict_in => tlb_evict,
		tlb_flags_in => evict_buffer(6 downto 1),
		
		ram_addr_o 	=> ram_addr_o,
		ram_data_i 	=> ram_data_in,
		ram_data_o  => ram_data_o,
		ram_we		=> ram_we_o,
		
		tlb_wb_stb 	=> ptw_wb_stb,
		pte_o 		=> pte_data,
		
		r_stb 		=> rw_switch(0),
		w_stb 		=> rw_switch(1),
		priv_stb 	=> priv_stb,
		
		busy			=> ptw_busy,
		p_fault_o 	=> p_fault_o,
		
		clk 			=> clk,
		reset 		=> rst_n
	);

	tlb : tlb_main
	generic map (
		tlb_init => tlb_init
	)
	port map (
		
		v_addr_in => v_addr_in(23 downto 8),
		index_i	 => index_wb,
		data_i    => pte_data,

		index_o	 => tlb_index_hit,
		va_evict	 => evict_buffer(22 downto 7),
		ppa_o     => tlb_data(21 downto 6),
		flags_o	 => tlb_data(5 downto 0),
		tlb_hit   => tlb_hit,
		evict		 => evict_buffer(0),
		
		r_stb     => rw_switch(0),
		w_stb     => rw_switch(1),
		priv      => priv_stb,
		we			 => ptw_wb_stb,
		
		clk       => clk,
		reset		 => rst_n
	);
	
	evict_sr : shift_register
	generic map ( width => 16, count => 2)
	port map(
      clk => clk,
      reset => rst_n,
      data_in  => evict_buffer(22 downto 7),
      data_out => tlb_evicted_va

   );
	
	process (ptw_busy, v_addr_in, pte_data, tlb_data, clk, real_mode, r_stb, w_stb, ptw_wb_stb)
	begin	
		
		if real_mode = '1' then
			p_addr_o <= v_addr_in;
			rw_switch <= "00";
		else
			rw_switch <= r_stb & w_stb;
			if ptw_wb_stb = '1' then
				flag_mux <= pte_data(5 downto 0);
				p_addr_o <= pte_data(21 downto 6) & v_addr_in(7 downto 0);
				va_shared <= tlb_evicted_va;
			else
				flag_mux <= tlb_data(5 downto 0);
				p_addr_o <= tlb_data(21 downto 6) & v_addr_in(7 downto 0);
				va_shared <= v_addr_in(23 downto 8);
			end if;
			
		end if;
		
		if falling_edge(clk) then
			--tlb_evicted_va <= evict_buffer(22 downto 7);
			tlb_evict <= evict_buffer(0);
			evict_buffer(6 downto 1) <= tlb_data(5 downto 0);
		end if;
			
		
	end process;
	
end mmu_main_arch;

