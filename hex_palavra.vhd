library ieee;
use ieee.std_logic_1164.all;

entity hex_palavra is
	port (
		X2, X1, X0: in std_logic;
		H3, H2, H1, H0: out std_logic_vector(6 downto 0)
	);

end hex_palavra;

architecture hardware of hex_palavra is
signal X: std_logic_vector(2 downto 0);
begin
	X <= X2 & X1 & X0;
	H0 <= "0010010" when (X="100") else
	      "0111111";
	H1 <= "0011001" when (X="100") or (X="011") else
	      "0111111";
	H2 <= "0110000" when (X="100") or (X="011") or (X="010") else
	      "0111111";
	H3 <= "0100100" when (X="100") or (X="011") or (X="010") or (X="001") else
	      "0111111";
end hardware;