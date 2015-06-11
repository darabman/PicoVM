----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:17 03/19/2015 
-- Design Name: 
-- Module Name:    tlb_record - Behavioral 
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tlb_record is

 generic ( 
		va_width       : INTEGER := 16;
		flag_width		: INTEGER := 6;
		
		--define this top level
		phys_mem_width : INTEGER := 16;
		
		INIT : BIT_VECTOR(37 downto 0) := (others => '0');

		f_dirty  : INTEGER := 5;
		f_access : INTEGER := 4;
		f_valid  : INTEGER := 3;
		f_read   : INTEGER := 2;
		f_write  : INTEGER := 1;
		f_super  : INTEGER := 0
		
	 );
	 
	 
	 
	 port ( 
		
		clk       : in STD_LOGIC;
		v_addr_in : in STD_LOGIC_VECTOR  ( va_width - 1 DOWNTO 0);
		r_stb     : in STD_LOGIC;
		w_stb     : in STD_LOGIC;
		priv      : in STD_LOGIC;
		we			 : in STD_LOGIC;
		reset		 : in STD_LOGIC;
		data_i    : in STD_LOGIC_VECTOR  ( va_width + phys_mem_width + flag_width - 1 DOWNTO 0);

		data_o    : out STD_LOGIC_VECTOR ( va_width + phys_mem_width + flag_width - 1 DOWNTO 0);
		tlb_hit   : out STD_LOGIC
	 );
	 

end tlb_record;

architecture tlb_record_arch of tlb_record is

	constant reg_width : INTEGER := va_width + phys_mem_width + flag_width;

	component tlb_register is 
	generic (INIT : BIT_VECTOR(37 downto 0));
	port(
		d   : in  STD_LOGIC_VECTOR(reg_width - 1 downto 0);
		q   : out STD_LOGIC_VECTOR(reg_width - 1 downto 0);
		rst_n	 : in STD_LOGIC;
		clk : in  STD_LOGIC
		);
	end component;
		
	signal reg_i : STD_LOGIC_VECTOR(reg_width - 1 downto 0);
	signal reg_o : STD_LOGIC_VECTOR(reg_width - 1 downto 0);
	
begin

	tlb_reg : tlb_register
	generic map (
		INIT => INIT
		
	)
	port map (
		d => reg_i,
		q => reg_o,
		rst_n => reset,
		clk => clk
	);
	
	

	process(v_addr_in, reg_o, we, r_stb, w_stb, priv, data_i)
	begin
	

	
		

		
		if v_addr_in = reg_o(reg_width - 1 downto phys_mem_width + flag_width)
			and (reg_o(f_valid)
			and (priv or reg_o(f_read)  or not r_stb)
			and (priv or reg_o(f_write) or not w_stb)
			and (not reg_o(f_super) or priv)) = '1'
		then			
			tlb_hit <= '1';
			
			data_o <= reg_o(reg_width - 1 DOWNTO 0);
			
			if we = '1' then
				reg_i <= data_i; --and std_logic_vector'(x"11111111" & (w_stb or reg_o(5)) & (r_stb or reg_o(4)) & "1111");
			else
				reg_i <= reg_o;
			end if;
			
		else
			tlb_hit <= '0';
			if we = '1' then
				reg_i <= data_i;
				data_o <= reg_o(reg_width - 1 DOWNTO 0);
			else
				reg_i <= reg_o;
				data_o <= (others => '0');
			end if;
			
		end if;
	
	end process;

end tlb_record_arch;

