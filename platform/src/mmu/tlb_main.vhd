----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:12:28 11/12/2014 
-- Design Name: 
-- Module Name:    tlb_main - tlb_main_arch 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;
use work.system_params.all;

entity tlb_main is

	generic ( 
		va_width       : INTEGER := 16;
		data_width     : INTEGER := 38;
		flag_width		: INTEGER := 6;
		phys_mem_width : INTEGER := 16;
		
		tlb_size			: INTEGER := 64;
		index_width		: INTEGER := 6;
		
		tlb_init			: tlb_init_array
		--don't forget to assert bank dimensions!
	);
	port (
	
		v_addr_in : in STD_LOGIC_VECTOR ( va_width - 1 DOWNTO 0);
		index_i	 : in STD_LOGIC_VECTOR ( index_width - 1 downto 0 ); -- log2 of tlb_size
		data_i    : in STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);
		
		index_o	 :	out STD_LOGIC_VECTOR (index_width - 1 downto 0);
		va_evict	 : out STD_LOGIC_VECTOR ( data_width - 1 DOWNTO phys_mem_width + flag_width);
		ppa_o     : out STD_LOGIC_VECTOR ( phys_mem_width - 1 DOWNTO 0);
		flags_o	 :	out STD_LOGIC_VECTOR ( flag_width - 1 downto 0);
		tlb_hit   : out STD_LOGIC;
		evict		 : out STD_LOGIC;
		
		r_stb     : in STD_LOGIC;
		w_stb     : in STD_LOGIC;
		priv      : in STD_LOGIC;
		we			 : in STD_LOGIC;
		
		clk       : in STD_LOGIC;
		reset		 : in STD_LOGIC
	
		
		);

--	function or_std_vector(V: std_logic_vector) return std_logic is
--		variable ret: std_logic := '0';
--		begin
--			for i in V'range loop
--				ret := ret or V(i);
--			end loop;
--		return(ret);
--	end function or_std_vector;


end tlb_main;

architecture tlb_main_arch of tlb_main is

	component tlb_record_bank
	generic (tlb_init		: tlb_init_array);
	port (
		clk       : in STD_LOGIC;
		reset		 : in STD_LOGIC;
		r_stb     : in STD_LOGIC;
		w_stb     : in STD_LOGIC;
		priv      : in STD_LOGIC;
		
		v_addr_in : in STD_LOGIC_VECTOR ( va_width - 1 DOWNTO 0);
		data_i    : in STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);
		w_select	 : in STD_LOGIC_VECTOR ( tlb_size - 1 downto 0);

		index_o	 : out STD_LOGIC_VECTOR ( index_width - 1 downto 0 ); -- log2 of tlb_size
		data_o    : out STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);
		tlb_hit   : out STD_LOGIC	
		);
	end component;
	
	component demux64
	port (
	stb_in 		: in std_logic;
	selector_i 	: in std_logic_vector (5 downto 0);
	select_o		: out std_logic_vector (63 downto 0)
	);	
	end component;
	
	component shift_register is
   port(
      clk      : in  std_logic;
      reset     : in  std_logic;
      data_in  : in  std_logic_vector(va_width - 1 downto 0);
      data_out 	: out std_logic_vector(va_width - 1 downto 0)
   );
	end component;


	signal we_muxed  		: STD_LOGIC_VECTOR(tlb_size - 1 downto 0);
	
	signal index_tlb		: STD_LOGIC_VECTOR(5 downto 0);
	signal index_muxed	: STD_LOGIC_VECTOR(5 downto 0);
	
	signal data_tlb		: STD_LOGIC_VECTOR(data_width - 1 downto 0);
	signal data_muxed		: STD_LOGIC_VECTOR(data_width - 1 downto 0);
	
	signal write_sig		: STD_LOGIC;
	signal hit_sig			: STD_LOGIC;
	
	signal va_buff			: STD_LOGIC_VECTOR(va_width - 1 downto 0);
	signal bank_addr_in	: STD_LOGIC_VECTOR(va_width - 1 downto 0);
	


begin

	record_bank : tlb_record_bank
	generic map (
		tlb_init => tlb_init
	)
	port map (
	
		clk => clk,
		reset	=> reset,
		r_stb => r_stb,
		w_stb => w_stb,
		priv => priv,
		
		v_addr_in => bank_addr_in,
		data_i => data_muxed,
		w_select	=> we_muxed,

		index_o => index_tlb,
		data_o  => data_tlb,
		tlb_hit => hit_sig
	);

	de64 : demux64
	port map(
		stb_in => write_sig,
		selector_i 	=> index_muxed,
		select_o	=> we_muxed
	);	

	shift_reg : shift_register
	port map (
      clk => clk,
      reset => reset,
      data_in  => v_addr_in,
      data_out 	=> va_buff
   );

	
	write_sig 	<= we or (hit_sig and (r_stb or w_stb));
	--va_buff		<= v_addr_in;
	
	ppa_o 		<= data_tlb(data_width - va_width - 1 downto flag_width);
	flags_o 	<= data_tlb(flag_width - 1 downto 0);
	tlb_hit 		<= (hit_sig and (r_stb or w_stb));
	index_o		<= index_tlb;

process(hit_sig, index_tlb, data_tlb, index_i, data_i, r_stb, w_stb, we, va_buff, v_addr_in)
		
	begin
	
		--write_sig 	<= we or (hit_sig and (r_stb or w_stb));	
		if we = '1' then
			bank_addr_in <= va_buff;
			
		else
			bank_addr_in <= v_addr_in;
			
		end if;
		
		


		if hit_sig = '1' and (r_stb or w_stb) = '1' then
		
			index_muxed <= index_tlb;
			data_muxed <= 	data_tlb(data_width - 1 downto flag_width) 
								& (w_stb or data_tlb(5)) & (r_stb or data_tlb(4)) 
								& data_tlb(flag_width - 3 downto 0);
		else
			index_muxed <= index_i;
			data_muxed <= data_i;
		end if;
		
		
		
		if (we and data_tlb(3)) = '1' then
			evict <= '1';
			va_evict		<= data_tlb ( data_width - 1 DOWNTO phys_mem_width + flag_width);
		else
			evict <= '0';
			va_evict <= (others => '0');
		end if;
	--end if;
	
end process;

end tlb_main_arch;

--------------------------------------
-- 6 to 64 demux Definition--
--------------------------------------			
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.conv_integer;
use IEEE.NUMERIC_STD.ALL;

entity demux64 is
port (

	stb_in 		: in std_logic;
	selector_i 	: in std_logic_vector (5 downto 0);
	select_o		: out std_logic_vector (63 downto 0)
);	
end demux64;

architecture demux64_arch of demux64 is
begin
	process (stb_in, selector_i)
	begin	
	select_o <= (others => '0');
	
	for i in 0 to 63 loop
		if i = to_integer(unsigned(selector_i)) then
			select_o(i) <= stb_in;
		end if;
	end loop;
	
	end process;
end demux64_arch;
