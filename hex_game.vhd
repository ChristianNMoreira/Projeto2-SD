library ieee;
use ieee.std_logic_1164.all;

entity hex_game is
	port (
		r, z: in std_logic;
		H: out std_logic_vector(6 downto 0)
	);

end hex_game;

architecture hardware of hex_game is
signal X: std_logic_vector(1 downto 0);
begin
	X(1) <= r;
	X(0) <= z;
	H <= "0010000" when (X="10") else  -- G
		  "0001010" when (X="01") else  -- P
		  "0111111";                    -- -
end hardware;