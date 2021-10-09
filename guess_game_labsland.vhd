library ieee;
use ieee.std_logic_1164.all;

-- t: SW(0)
-- clk: KEY(0)
-- r: LEDG(1)
-- e: LEDG(0)
-- s1, s0: LEDR[1 / 0]
-- cc: LEDR(2)
-- c2, c1, c0: LEDR[5 / 3]

entity guess_game_labsland is port(
	SW: in std_logic_vector(0 downto 0);
	KEY: in std_logic_vector(0 downto 0);
	LEDG: out std_logic_vector(1 downto 0);
	LEDR: out std_logic_vector(17 downto 0);
	HEX0: out std_logic_vector(6 downto 0)
);
end guess_game_labsland;

architecture structural of guess_game_labsland is
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

signal t, clk: std_logic;

begin
	t <= SW(0);
	clk <= not(KEY(0));

	seqS0: seq_S port map (t, clk, rsts, c, ss1, ss0, d0);
	seqE0: seq_E port map (c, clk, rste, e2, e1, e0, d1);
	FF0: ff_d port map (d0, clk, rstff, q0);
	FF1: ff_d port map (d1, clk, rstff, q1);

	rsts <= q1 and e2 and e1 and e0;
	rste <= q0 and ss1 and ss0;
	rstff <= '0';

	LEDG(1) <= q0;
	LEDG(0) <= q1;
	LEDR(5) <= e2;
	LEDR(4) <= e1;
	LEDR(3) <= e0;
	LEDR(1) <= ss1;
	LEDR(0) <= ss0;
	LEDR(2) <= c;
end structural;
