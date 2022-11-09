library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DecoHex7 is
	Port(A, B, C, D: in std_logic;
			F: out std_logic_vector(6 downto 0));
	end entity;

architecture DecoHex7_arch of DecoHex7 is
	signal ABCD : STD_logic_vector(3 downto 0);
	 begin
	 
	 ABCD <= A & B & C & D;
	 
	 with ABCD select 
	 
	 F <= "0000001" when "0000",
			"1001111" when "0001",
			"0010010" when "0010",
			"0000110" when "0011",
			"1001100" when "0100",
			"0100100" when "0101",
			"0100000" when "0110",
			"0001111" when "0111",
			"0000000" when "1000",
			"0001100" when "1001",
			"0001000" when "1010",
			"1100000" when "1011",
			"0110001" when "1100",
			"1000010" when "1101",
			"0110000" when "1110",
			"0111000" when "1111",
			"1111111" when others;
			
		end DecoHex7_arch;
			