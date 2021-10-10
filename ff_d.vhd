library ieee;
use ieee.std_logic_1164.all;

entity ff_d is port(
	d: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	en: in std_logic;
	q: out std_logic
);
end ff_d;

architecture behavior of ff_d is
signal ds: std_logic;
begin
	process(clk, reset)
	--	constant delay: time:= 500 ps;
	begin
		if (reset='1') then
			ds <= '0';
		elsif (clk'event and clk='1' and en='1') then
			--ds <= d after delay;
			ds <= d;
		end if;
	end process;
	process(ds)
	begin
		q <= ds;
	end process;
end behavior;