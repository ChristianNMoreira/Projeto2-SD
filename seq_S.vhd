library ieee;
use ieee.std_logic_1164.all;

entity seq_S is
	port (
		t: in std_logic; -- tentativa
		clk: in std_logic;
		c: out std_logic; -- erro
		r: out std_logic -- sequência correta
	);
end seq_S;

architecture structural of seq_S is
component ff_d port (
	d: in std_logic;
	clk: in std_logic;
	q: out std_logic
);
end component;

signal d1, d0: std_logic;
signal q1, q0: std_logic;

begin
	d1 <= (q0 and not(t)) or (q1 and not(q0));
	d0 <= (q1 + q0) xor t;
	
	FF1: ff_d port map (d1, clk, q1);
	FF0: ff_d port map (d0, clk, q0);
	
	c <= (not(q1) + q0) xor t;
	r <= s1 and s0 and t;
end structural;