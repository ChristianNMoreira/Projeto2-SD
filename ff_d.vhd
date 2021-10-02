library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
	port(
		d: in std_logic;
		clk: in std_logic;
		q: out std_logic
	);
end ff_d;

architecture behavior of ff_d is
signal ds: std_logic;
begin
	process(clk)
	--	contant delay: time:= 500 ps;
	begin
		if(clk'event and clk='1') then
			ds <= d after delay;
		end if;
	end process;
	process(ds)
		q <= ds;
	end process;
end behavior;