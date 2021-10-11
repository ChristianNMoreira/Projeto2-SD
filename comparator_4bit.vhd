library ieee;
use ieee.std_logic_1164.all;

entity comparator_4bit is
	port (
		A, B: in std_logic_vector(3 downto 0);
		E: out std_logic
	);

end comparator_4bit;

architecture hardware of comparator_4bit is
signal equal: std_logic;
begin
    detect: for i in 0 to 3 generate
		equal <= A(i) xnor B(i)
	end generate;

    E <= equal
end hardware;