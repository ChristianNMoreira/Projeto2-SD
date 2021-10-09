library ieee;
use ieee.std_logic_1164.all;

entity hex_palavra is
	port (
		X: in std_logic;
		H: out std_logic_vector(6 downto 0)
	);

end hex_palavra;

architecture hardware of hex_palavra is
begin
	H <= "1000000" when (X='0') else  -- 0
		 "1111001" when (X='1') else   -- 1
		 "0111111";                    -- -
end hardware;