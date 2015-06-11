----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:14:45 03/19/2015 
-- Design Name: 
-- Module Name:    tlb_register - tlb_register_arch 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity tlb_register is

	generic (
		INIT : BIT_VECTOR(37 downto 0) := (others => '0')
	);
	port ( 		
		d   : in  STD_LOGIC_VECTOR(37 downto 0);
		q   : out STD_LOGIC_VECTOR(37 downto 0);
		rst_n	 : in	STD_LOGIC;
		clk : in  STD_LOGIC
	);

end tlb_register;

architecture tlb_register_arch of tlb_register is

begin
	process(clk, rst_n)
	begin
	
		if rst_n = '0' then
				q <= to_stdlogicvector(INIT);
		elsif clk'event and clk = '1' then
				q <= d;
		end if;

		
	end process;

end tlb_register_arch;

