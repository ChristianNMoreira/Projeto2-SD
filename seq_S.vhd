library ieee;
use ieee.std_logic_1164.all;

entity seq_S is
	port (
		t: in std_logic;                  -- acerto ou erro
		clk: in std_logic;
		reset: in std_logic;
		en: in std_logic;
		c: out std_logic;                 -- entrada do circuito sequencial de erros
		s2, s1, s0: out std_logic;        -- estados
		r: out std_logic                  -- sequência correta
	);
end seq_S;

architecture structural of seq_S is
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
	d2 <= (q2 and not(q1) and not(q0)) or (not(q2) and q1 and q0 and t);
	d1 <= not(q2) and (q1 xor (q0 and t));
	d0 <= not(q2) and (q0 xor t);

	FF2: ff_d port map (d2, clk, reset, en, q2);
	FF1: ff_d port map (d1, clk, reset, en, q1);
	FF0: ff_d port map (d0, clk, reset, en, q0);

	s2 <= q2;
	s1 <= q1;
	s0 <= q0;
	c <= not(q2) and not(t);
	r <= q2;
end structural;