library ieee;
use ieee.std_logic_1164.all;

entity guess_game is port(
	t: in std_logic; -- entrada da tentativa
	clk: in std_logic;
	r: out std_logic; -- indica vitória
	e: out std_logic; -- indica derrota
	s1, s0: out std_logic; -- conferir estados
	cc: out std_logic;
	c0, c1, c2: out std_logic -- contagem de erros
);
end guess_game;

architecture structural of guess_game is
component seq_S port (
	t: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	c: out std_logic;
	s1, s0: out std_logic; -- conferir estados
	r: out std_logic
);
end component;
component seq_E port (
	c: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	e2, e1, e0: out std_logic;
	z: out std_logic
);
end component;
component ff_d port (
	d: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	q: out std_logic
);
end component;

signal d0, q0, d1, q1: std_logic;
signal c: std_logic;
signal e2, e1, e0: std_logic;
signal ss1, ss0: std_logic;
signal rsts, rste, rstff: std_logic;

begin
	--rst <= q1 or q0;
	seqS0: seq_S port map (t, clk, rsts, c, ss1, ss0, d0);
	seqE0: seq_E port map (c, clk, rste, e2, e1, e0, d1);
	FF0: ff_d port map (d0, clk, rstff, q0);
	FF1: ff_d port map (d1, clk, rstff, q1);

	rsts <= q1 and e2 and e1 and e0;
	rste <= q0 and ss1 and ss0;
	rstff <= '0';

	r <= q0;
	e <= q1;
	c2 <= e2;
	c1 <= e1;
	c0 <= e0;
	s1 <= ss1;
	s0 <= ss0;
	cc <= c;
end structural;
