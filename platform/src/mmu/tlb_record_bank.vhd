----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:53:28 03/23/2015 
-- Design Name: 
-- Module Name:    tlb_record_bank - tlb_record_bank_arch 
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


entity tlb_record_bank is
	generic (	
		data_width 	: INTEGER := 38;
		va_width		: INTEGER := 16;
		tlb_size		: INTEGER := 64;
		index_width : INTEGER := 6;
		tlb_init		: tlb_init_array
	);
	
	
	
	port (
		clk       : in STD_LOGIC;
		reset		 : in STD_LOGIC;
		r_stb     : in STD_LOGIC;
		w_stb     : in STD_LOGIC;
		priv      : in STD_LOGIC;
		
		v_addr_in : in STD_LOGIC_VECTOR ( va_width - 1 DOWNTO 0);
		data_i    : in STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);
		w_select	 : in STD_LOGIC_VECTOR (tlb_size - 1 downto 0);

		index_o	 : out STD_LOGIC_VECTOR ( index_width - 1 downto 0 ); -- log2 of tlb_size
		data_o    : out STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);
		tlb_hit   : out STD_LOGIC	
		);

end tlb_record_bank;

architecture tlb_record_bank_arch of tlb_record_bank is

	--assert tlb_size = 2**index_width report "TLB port dimensions mismatch" severity failure;

	component tlb_record
	generic (INIT : BIT_VECTOR (37 downto 0));
	port ( 
		
		clk       : in STD_LOGIC;
		v_addr_in : in STD_LOGIC_VECTOR ( va_width - 1 DOWNTO 0);
		r_stb     : in STD_LOGIC;
		w_stb     : in STD_LOGIC;
		priv      : in STD_LOGIC;
		we			 : in STD_LOGIC;
		reset		 : in STD_LOGIC;
		data_i    : in STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);

		data_o    : out STD_LOGIC_VECTOR ( data_width - 1 DOWNTO 0);
		tlb_hit   : out STD_LOGIC	 
	 );
	end component;
	
	component encoder64
	port (
		one_hot_in : in std_logic_vector(63 downto 0);
		encoding : out std_logic_vector(5 downto 0);
		valid : out std_logic
	);
	end component;
	
	type tlb_net is array (0 to tlb_size - 1) of 
		std_logic_vector(data_width - 1 DOWNTO 0);

	signal record_data_o : tlb_net ;
	signal record_data_i : tlb_net ;
	
	signal hit_vector 	: STD_LOGIC_VECTOR(tlb_size - 1 downto 0);

begin

	tlb_block : for i in 0 to tlb_size - 1
	generate	
	begin
		tlb : tlb_record
		generic map (
			INIT => tlb_init(i)
		)
		port map (
			clk => clk,
			v_addr_in => v_addr_in,
			r_stb => r_stb,
			w_stb => w_stb,
			priv => priv,
			we => w_select(i),
			reset => reset,
			data_i => record_data_i(i),
			data_o => record_data_o(i),
			tlb_hit => hit_vector(i)
			);
	end generate;
	
	en64 : encoder64
	port map (
		one_hot_in => hit_vector,
		encoding => index_o,
		valid => tlb_hit
	);
	
	process (record_data_o, data_i)
		variable bank_col : std_logic := '0';	
	begin
		
		
		for i in 0 to data_width - 1 loop
		bank_col := '0';
			for j in 0 to tlb_size - 1 loop
				bank_col := bank_col or record_data_o(j)(i);
			end loop;
		data_o(i) <= bank_col;	
		end loop;
		
		
		for i in 0 to data_width - 1 loop
			for j in 0 to tlb_size - 1 loop
					record_data_i(j)(i) <= data_i(i);
			end loop;
		end loop;

	end process;

end tlb_record_bank_arch;

--------------------------------------
-- 64 to 6 binary encoder Definition--
--------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.conv_std_logic_vector;

entity encoder64 is
port (
   one_hot_in : in std_logic_vector(63 downto 0);
   encoding : out std_logic_vector(5 downto 0);
	valid : out std_logic
);
end encoder64;

architecture encoder64_arch of encoder64 is 
begin
   process (one_hot_in)
	begin
	
	encoding <= (others => '0');
	valid <= '0';
			
	for i in 0 to one_hot_in'length - 1 loop
		if one_hot_in(i) = '1' then
			encoding <= conv_std_logic_vector(i, encoding'length);
			valid <= '1';
		end if;
	end loop;
	end process;
	
end encoder64_arch;
