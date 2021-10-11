library ieee;
use ieee.std_logic_1164.all;

entity comparator_10bit is
	port (
		A, B: in std_logic_vector(9 downto 0);
		E: out std_logic
	);

end comparator_10bit;

architecture behavior of comparator_10bit is
begin
	process(A, B)
	begin
		if A=B then
			E <= '1';
		else
			E <= '0';
		end if;
	end process;
    
end behavior;