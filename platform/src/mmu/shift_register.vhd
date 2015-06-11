----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:58 04/08/2015 
-- Design Name: 
-- Module Name:    shift_register - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
   generic (
		width : integer := 16;
		count : integer := 10
	);
	port(
      clk      : in  std_logic;
      reset     : in  std_logic;
      data_in  : in  std_logic_vector(width - 1 downto 0);
      data_out 	: out std_logic_vector(width - 1 downto 0);
		tail_out	: out std_logic_vector(width - 1 downto 0)
   );
	
	type signal_array is array ( 0 to count - 1 ) of std_logic_vector(width - 1 downto 0);
	
	
	function or_array (a: signal_array; n: integer) return std_logic_vector is
		variable ret : std_logic_vector(n - 1 downto 0) := (others => '0');
	begin
		for i in a'range loop
			ret := ret or a(i);
		end loop;
		return ret;
	end or_array;
	
end shift_register;


architecture shift_register_arch of shift_register is

	signal shift_reg : signal_array;
	
begin

	data_out <= or_array(shift_reg, width);
	tail_out <= shift_reg(count - 1);
	
	process (clk, reset)
	begin
		if rising_edge(clk) then
			if reset = '0' then
				shift_reg <= (others => (others => '0'));
			else
				shift_reg(1 to count - 1) <= shift_reg(0 to count - 2);
				shift_reg(0) <= data_in;
			end if;
		end if;
	end process;

end shift_register_arch;
