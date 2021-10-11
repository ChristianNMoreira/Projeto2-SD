library ieee;
use ieee.std_logic_1164.all;

entity seq_E is
	port (
		c: in std_logic;
		clk: in std_logic;
		reset: in std_logic;
		en: in std_logic;
		e2, e1, e0: out std_logic;     -- estados
		z: out std_logic               -- alto com 5 erros
	);
end seq_E;

architecture structural of seq_E is
component ff_d port (
	d: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	en: in std_logic;
	q: out std_logic
);
end component;

signal d2, d1, d0: std_logic;
signal q2, q1, q0: std_logic;

begin
	d2 <= (q2 and not(q1)) or (not(q2) and q1 and q0 and c);
	d1 <= not(q2) and ((q0 and c) xor q1);
	d0 <= (not(q2) and (q0 xor c)) or (not(q1) and q0 and not(c)) or (q2 and not(q1) and c);

	FF2: ff_d port map (d2, clk, reset, en, q2);
	FF1: ff_d port map (d1, clk, reset, en, q1);
	FF0: ff_d port map (d0, clk, reset, en, q0);

	z <= q2 and q0;
	e2 <= q2;
	e1 <= q1;
	e0 <= q0;
end structural;