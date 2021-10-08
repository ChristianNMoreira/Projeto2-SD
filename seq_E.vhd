library ieee;
use ieee.std_logic_1164.all;

entity seq_E is
	port (
		c: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		e2, e1, e0: out std_logic;
		z: out std_logic -- alto com 5 erros
	);
end seq_E;

architecture structural of seq_E is
component ff_d port (
	d: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	q: out std_logic
);
end component;

signal d2, d1, d0: std_logic;
signal q2, q1, q0: std_logic;

begin
	d2 <= (q2 and not(c)) or (q1 and q0 and c);
	d1 <= (q1 and not(q0)) or (q1 and not(c)) or (not(q1) and q0 and c);
	d0 <= (q0 and not(c)) or (not(q2) and not(q0) and c);

	FF2: ff_d port map (d2, clk, reset, q2);
	FF1: ff_d port map (d1, clk, reset, q1);
	FF0: ff_d port map (d0, clk, reset, q0);

	z <= q2 and c;
	e2 <= q2;
	e1 <= q1;
	e0 <= q0;
end structural;