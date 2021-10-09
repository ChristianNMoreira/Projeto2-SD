library ieee;
use ieee.std_logic_1164.all;

entity decoder is
	port(
	K2, K1, K0: in std_logic;
	D4, D3, D2, D1, D0: out std_logic
	);
end decoder;

architecture hardware of decoder is
signal K: std_logic_vector(2 downto 0);
signal D: std_logic_vector(4 downto 0);
begin
	K(2) <= K2;
	K(1) <= K1;
	K(0) <= K0;
	D <= "11111" when (K="000") else
		  "01111" when (K="001") else
		  "00111" when (K="010") else
		  "00011" when (K="011") else
		  "00001" when (K="100") else
		  "00000";
	D4 <= D(4);
	D3 <= D(3);
	D2 <= D(2);
	D1 <= D(1);
	D0 <= D(0);
end hardware;