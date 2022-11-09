library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
 port ( clock, reset : in std_logic;
	     address : in std_logic_vector(7 downto 0);
	     data_in : in std_logic_vector(7 downto 0);
	     writen : in std_logic;
	     port_out_00, port_out_01, port_out_02, port_out_03: out std_logic_vector(7 downto 0);
		  data_out : out std_logic_vector(7 downto 0);
		  port_in_00, port_in_01, port_in_02, port_in_03: in std_logic_vector(7 downto 0));
end entity;

architecture memory_arch of memory is

 component rom_128x8_sync
  port (clock : in std_logic;
		address : in std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0));
 end component;
 
 component rw_96x8_sync
  port (clock : in std_logic;
			address : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			writen : in std_logic;
			data_out : out std_logic_vector (7 downto 0));
 end component;
 
 component output_ports
   port(clock, reset : in std_logic;
	address : in std_logic_vector(7 downto 0);
	data_in : in std_logic_vector(7 downto 0);
	writen : in std_logic;
	port_out_00, port_out_01, port_out_02, port_out_03: out std_logic_vector(7 downto 0));
 end component;
 
signal data_out_ROM, data_out_RAM : std_logic_vector(7 downto 0);
 
begin

 MUX1 : process (address, data_out_ROM, data_out_RAM, 
                 port_in_00, port_in_01, port_in_02, port_in_03)
	begin
	 
	 if ( (to_integer(unsigned(address)) >=0 ) and
	      (to_integer(unsigned(address)) <=127)) then
		data_out <= data_out_ROM;
		
	 elsif ( (to_integer(unsigned(address)) >=128 ) and
	         (to_integer(unsigned(address)) <=223 )) then
		data_out <= data_out_RAM;
		
	 elsif (address = x"F0") then data_out <= port_in_00;
	 elsif (address = x"F1") then data_out <= port_in_01;
	 elsif (address = x"F2") then data_out <= port_in_02;
	 elsif (address = x"F3") then data_out <= port_in_03;
	 else data_out <= x"00";
	 
	 end if;
 end process;
 
P1: rom_128x8_sync port map (clock, address, data_out_ROM);
P2: rw_96x8_sync port map (clock, address, data_in, writen, data_out_RAM);
P3: output_ports port map (clock, reset, address, data_in, writen, port_out_00, port_out_01, port_out_02, port_out_03);
 
end memory_arch; 
 
  