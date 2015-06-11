----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:39:05 03/24/2015 
-- Design Name: 
-- Module Name:    pt_walk_main - pt_walk_main_arch 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.conv_std_logic_vector;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pt_walk_main is
    
	 generic (
		--f_dirty  : INTEGER := 5;
		--f_access : INTEGER := 4;
		f_valid  : INTEGER := 3;
		f_read   : INTEGER := 2;
		f_write  : INTEGER := 1;
		f_super  : INTEGER := 0;
		
		sr_width : integer := 26;
		
		p_fault_reg : std_logic_vector(15 downto 0) := x"fffe"
	);
			
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
		
		
end pt_walk_main;

	

architecture pt_walk_main_arch of pt_walk_main is

	component shift_register is
	generic ( width : integer := 16 );
   port(
      clk      : in  std_logic;
      reset     : in  std_logic;
      data_in  : in  std_logic_vector(sr_width - 1 downto 0);
      data_out 	: out std_logic_vector(sr_width - 1 downto 0)
   );
	end component;
	
	type ptw_state_t is (s_idle, s_pdir, s_plvl, s_pte, s_hit);
	type word_state_t is (w0, w1, w2, w3, w4);
	signal state, next_state : ptw_state_t;
	signal word, next_word : word_state_t;
	

	signal addr_buff_i : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal addr_buff_o : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal pte_tmp		: STD_LOGIC_VECTOR(21 downto 0) := (others => '0');
	signal va_buff		: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal rws_flags	: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	signal tlb_evicted: STD_LOGIC := '0';
	signal tlb_flags	: STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
	
	signal sr_in		: std_logic_vector(sr_width - 1 downto 0);
	signal sr_out		: std_logic_vector(sr_width - 1 downto 0);
	signal fault      : std_logic := '0';
	

begin

	

	shift_reg : shift_register
	generic map (
		width => 26
	)
	port map (
      clk => clk,
      reset => reset,
      data_in  => sr_in,
      data_out 	=> sr_out
   );

	update_state :
	process (clk, reset)
	begin
		if reset = '0' then
			state <= s_idle;
			word <= w0;
			--clear other regs
		elsif rising_edge(clk) then
			state <= next_state;
			word <= next_word;
		end if;
	end process;

	walk_table : 
	process (v_addr_in, pt_base_in, tlb_miss_in,
				r_stb, w_stb, priv_stb, sr_out,
				ram_data_i, state, word, pte_tmp,
				tlb_flags_in, tlb_evict_in, va_buff)
	begin

--	ab	<= (others => '0');
	ram_addr_o <= (others => '0');
	sr_in <= (others => '0');
	--busy			<= '0';
	
	va_buff <= sr_out(18 downto 3);
	rws_flags <= sr_out(2 downto 0);
	
	ram_we 		<= '0';
	tlb_wb_stb 	<= '0';
	p_fault_o 	<= '0';
	
		case state is
			-- wait for PTE request
			when s_idle  =>

				next_state 	<= s_idle;
				next_word	<= w0;
				--rws_flags	<= "000";
				
				
				
				pte_o <= (others => '0');
				pte_tmp <= (others => '0');
				--page_tmp <= (others => '0');
				busy			<= '0';
				ram_data_o	<= (others => '0');



				tlb_flags	<= (others => '0');
				tlb_evicted <= '0';
				
				if ((tlb_miss_in or sr_out(19)) and (r_stb or w_stb)) = '1' then
					sr_in(19) <= sr_out(19);
					sr_in(18 downto 3) <= v_addr_in;
					if sr_out(19) = '1' then
						sr_in(25 downto 20)	<= sr_out(25 downto 20);
						sr_in(18 downto 3) <= sr_out(18 downto 3);
						sr_in(2 downto 0) <= sr_out(2 downto 0);
					else
						sr_in(25 downto 20)	<= tlb_flags_in;
						
						sr_in(2 downto 0) <= r_stb & w_stb & priv_stb;
					end if;
					next_state 	<= s_pdir;
					busy			<= '1';

					ram_addr_o	<= std_logic_vector(unsigned(pt_base_in) + (unsigned(x"00" & va_buff(15 downto 8)) sll 1));
				end if;


			-- read PT dir
			when s_pdir  =>
				next_state 	<= s_pdir;
				busy			<= '1';
				sr_in(19) <= '0';
				ram_we <= '0';	
				tlb_wb_stb <= '0';
				
				case word is
					when w0 =>
						next_word <= w1;
						
						ram_addr_o	<= std_logic_vector(unsigned(pt_base_in) + (unsigned(x"00" & va_buff(15 downto 8)) sll 1) + 1);
						addr_buff_o(15 downto 8) <= ram_data_i;
					when w1 =>
						next_word <= w0;
						next_state <= s_plvl;
						addr_buff_o(7 downto 0) <= ram_data_i;
					when others =>
						next_word <= w0;
						next_state 	<= s_idle;
				end case;
		
			-- read 2nd level PT dir
			when s_plvl  =>
				next_state 	<= s_plvl;
				busy			<= '1';
				case word is
					when w0 =>
						ram_addr_o	<=  std_logic_vector(unsigned(addr_buff_o) + (unsigned(x"00" & va_buff(7 downto 4)) sll 1)) ;
						
						next_word <= w1;

					when w1 =>
						ram_addr_o	<=  std_logic_vector(unsigned(addr_buff_o) + (unsigned(x"00" & va_buff(7 downto 4)) sll 1) + 1) ;
						next_word <= w2;
						addr_buff_i(15 downto 8) <= ram_data_i;
						
					when w2 =>
						
						addr_buff_i(7 downto 0) <= ram_data_i;
							
						next_word <= w0;
						next_state <= s_pte;

					when others =>
						next_word <= w0;
						next_state 	<= s_idle;
				end case;
				
			when s_pte 	 =>			
				next_state <= s_pte;
				busy			<= '1';
				case word is
					when w0 =>
						next_word <= w1;
						addr_buff_o <= addr_buff_i;
						ram_addr_o	<=  std_logic_vector(unsigned(addr_buff_o) + (unsigned( x"00" & va_buff(3 downto 0)) sll 2)) ;
						
					when w1 =>
						
						ram_addr_o	<=  std_logic_vector(unsigned(addr_buff_o) + (unsigned(x"00" & va_buff(3 downto 0)) sll 2) + 1) ;						
						pte_tmp(21 downto 14) <= ram_data_i;
						next_word <= w2;
					when w2 =>
						next_word <= w3;
						ram_addr_o	<=  std_logic_vector(unsigned(addr_buff_o) + (unsigned(x"00" & va_buff(3 downto 0)) sll 2) + 2) ;
						pte_tmp(13 downto 6) <= ram_data_i;
						
					when w3 =>
						pte_tmp(5 downto 0) <= ram_data_i(7 downto 2);
						
						next_word <= w0;
						next_state <= s_hit;
					when others =>
						next_word <= w0;
						next_state 	<= s_idle;
				end case;

			when s_hit	 =>
				next_state <= s_idle;
				ram_addr_o	<=  std_logic_vector(unsigned(addr_buff_o) + (unsigned(x"00" & va_buff(3 downto 0)) sll 2) + 2) ;
				busy			<= '1';		
				
--				if fault = '1' then
--						ram_data_o <= addr_buff_o(7 downto 0);
--						ram_addr_o <= p_fault_reg(15 downto 1) & '1';
--						ram_we <= '1';
--						fault <= '0';
--						p_fault_o <= '0';
--				els
				if sr_out(19) = '1' then
							tlb_wb_stb <= '0';
							ram_we <= '1';	
							ram_data_o <= sr_out(25 downto 20) & "00";
							
				else
					
					if  pte_tmp(f_valid) = '1'  and (
						(pte_tmp(f_write) or not rws_flags(1) or rws_flags(0)) and
						(pte_tmp(f_read)  or not rws_flags(2) or rws_flags(0)) and
						(not pte_tmp(f_super) or rws_flags(0))) = '1'
					then		
							
							ram_data_o <= (rws_flags(1) or pte_tmp(5)) & (rws_flags(2) or pte_tmp(4)) & pte_tmp(3 downto 0) & "00"; 
							ram_we <= '1';	
							tlb_wb_stb <= '1';
							pte_o <= va_buff & pte_tmp(21 downto 6) & rws_flags(1) & rws_flags(2) & pte_tmp(3 downto 0);
	
					else
							p_fault_o <= '1';
							busy <= '0';

							ram_data_o <= v_addr_in(7 downto 0);
							ram_addr_o <= p_fault_reg(15 downto 1) & '1';
							ram_we <= '1';
							--next_state <= s_hit;
					end if;
				end if;
				
				--begin reading for next word on next clk cycle
				
				if tlb_evict_in = '1' then
					--next_state 	<= s_pdir;
					busy			<= '1';
					--next_word <= w1;
					sr_in(19) <= tlb_evict_in;
					sr_in(25 downto 20)	<= tlb_flags_in;					
					sr_in(18 downto 3) <= v_addr_in;
					sr_in(2 downto 0) <= r_stb & w_stb & priv_stb;
					
					--ram_addr_o	<= (others => '0');
					--tlb_wb_stb 	<= '0';
					--p_fault_o 	<= '0';
					--next_state 	<= s_idle;
				end if;
				
		end case;
	end process;
end pt_walk_main_arch;

----------------------------------------------
----------------------------------------------
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--
--entity shift_register is
--   generic (
--		width : integer := 26
--	);
--	port(
--      clk      : in  std_logic;
--      reset     : in  std_logic;
--      data_in  : in  std_logic_vector(width - 1 downto 0);
--      data_out 	: out std_logic_vector(width - 1 downto 0)
--   );
--end shift_register;
--
--
--architecture shift_register_arch of shift_register is
--
--	type va_flags_sr is array ( 0 to 10 ) of std_logic_vector(width - 1 downto 0);
--	signal shift_reg : va_flags_sr;
--	
--begin
--
--data_out <= shift_reg(10) or
--				shift_reg(9) or
--				shift_reg(8) or
--				shift_reg(7) or
--				shift_reg(6) or
--				shift_reg(5) or
--				shift_reg(4) or
--				shift_reg(3) or
--				shift_reg(2) or
--				shift_reg(1) or
--				shift_reg(0);
--
--process (clk, reset)
--begin
--	if rising_edge(clk) then
--		if reset = '0' then
--			shift_reg <= (others => (others => '0'));
--		else
--			shift_reg(1 to 9) <= shift_reg(0 to 8);
--			shift_reg(0) <= data_in;
--		end if;
--		
--	end if;
--end process;
--
--end shift_register_arch;

