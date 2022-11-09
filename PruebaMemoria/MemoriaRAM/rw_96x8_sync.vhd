library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rw_96x8_sync is
	port (clock : in std_logic;
			address : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			writen : in std_logic;
			data_out : out std_logic_vector (7 downto 0));
end entity;

architecture rw_96x8_sync_arch of rw_96x8_sync is
	
	type RW_type is array (128 to 223) of std_logic_vector (7 downto 0);
	
	signal RW: RW_type;
	signal EN: std_logic;
	
	begin 
	
	enable: process (address)
	  begin
	  if((to_integer(unsigned(address))>=128) and
	     (to_integer(unsigned(address))<=223 )) then
		   EN <='1';
		else
		   EN <='0';
		end if;	
	end process;
	
	
	MEMORY : process(clock)
		
		begin 
			if (clock'event and clock='1') then
				if (EN ='1' and writen='1') then 
					RW(to_integer(unsigned(address))) <= data_in;
			elsif (EN ='1' and writen='0') then 
					data_out <= RW (to_integer(unsigned(address)));
				end if;
			end if;
	end process;
	
end architecture;