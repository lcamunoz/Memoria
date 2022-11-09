library IEEE;
use IEEE.std_logic_1164.all;

entity PruebaMemoria is
	port(
			address, data_in: in std_logic_vector(7 downto 0);
			writen, reset, clock: in std_logic;
			Display0, Display1, Display2, Display3: out std_logic_vector(6 downto 0);
			port_in_00, port_in_01, port_in_02, port_in_03: in std_logic_vector(7 downto 0);
			port_out_00, port_out_01, port_out_02, port_out_03: out std_logic_vector(7 downto 0));
end entity;

architecture PruebaMemoria_arch of PruebaMemoria is

component memory
 port ( clock, reset : in std_logic;
	     address : in std_logic_vector(7 downto 0);
	     data_in : in std_logic_vector(7 downto 0);
	     writen : in std_logic;
	     port_out_00, port_out_01, port_out_02, port_out_03: out std_logic_vector(7 downto 0);
		  data_out : out std_logic_vector(7 downto 0);
		  port_in_00, port_in_01, port_in_02, port_in_03: in std_logic_vector(7 downto 0));
end component;

component DecoHex7
 port(A, B, C, D: in std_logic;
			F: out std_logic_vector(6 downto 0));
end component;

signal data_out: std_logic_vector (7 downto 0);

begin
P1: DecoHex7 port map (address(7), address(6), address(5), address(4), Display0);
P2: DecoHex7 port map (address(3), address(2), address(1), address(0), Display1);
P3: memory port map (clock, reset, address, data_in, writen, port_out_00, port_out_01, port_out_02, port_out_03, data_out, port_in_00, port_in_01, port_in_02, port_in_03);
P4: DecoHex7 port map (data_out(7), data_out(6), data_out(5), data_out(4), Display2);
P5: DecoHex7 port map (data_out(3), data_out(2), data_out(1), data_out(0), Display3);

end architecture;