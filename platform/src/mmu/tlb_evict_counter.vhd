----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:43 03/26/2015 
-- Design Name: 
-- Module Name:    tlb_evict_counter - tlb_evict_counter_arch 
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

entity tlb_evict_counter is
    Port ( index_i : in  STD_LOGIC_VECTOR (5 downto 0);
           index_o : out  STD_LOGIC_VECTOR (5 downto 0);
			  we		 :	in	 STD_LOGIC;
			  rw		 :	in	 STD_LOGIC;
           trigger : in  STD_LOGIC;
			  rst_n	 :	in  STD_LOGIC
			  );
end tlb_evict_counter;

architecture tlb_evict_counter_arch of tlb_evict_counter is

begin



	process (trigger, rst_n, index_i, we, rw)
	variable last : integer range 0 to 63 := 27;
	variable	free : integer range 0 to 64 := 64;
	begin
	
		if rst_n = '0' then
			free := 0;
			last := 0;
			index_o <= (others => '0');
		elsif trigger = '1' then
			if free < 64 then
				index_o <= conv_std_logic_vector(free, 6);
				free := free + 1;
			else
				
				if last < 63 then
					last := last + 1;
				else
					last := 0;
				end if;
				index_o <= conv_std_logic_vector(last, 6);				
			end if;
		elsif (we and rw) = '1' then
			last := to_integer(unsigned(index_i));
		end if;
	end process;

	


end tlb_evict_counter_arch;

