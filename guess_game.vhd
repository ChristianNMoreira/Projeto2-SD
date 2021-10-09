library ieee;
use ieee.std_logic_1164.all;

-- t: SW(0)
-- rst: SW(1)
-- clk: KEY(0)
-- r: LEDG(1)
-- e: LEDG(0)
-- s1, s0: LEDR[1 / 0]
-- c2, c1, c0: LEDR[5 / 3]

entity guess_game is port(
	SW: in std_logic_vector(1 downto 0);
	KEY: in std_logic_vector(0 downto 0);
	LEDR: out std_logic_vector(4 downto 0);
	HEX0, HEX1, HEX2, HEX3, HEX7: out std_logic_vector(6 downto 0)
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
component decoder port (
	K2, K1, K0: in std_logic;
	D4, D3, D2, D1, D0: out std_logic
);
end component;
component hex_palavra port (
   X: in std_logic;
	H: out std_logic_vector(6 downto 0)
);
end component;
component hex_game port (
   r, z: in std_logic;
	H: out std_logic_vector(6 downto 0)
);
end component;

signal d0, q0, d1, q1: std_logic; -- flip flops
signal c: std_logic;              -- contagem de erros
signal e2, e1, e0: std_logic;     -- estados circuito sequencial E
signal ss1, ss0: std_logic;       -- estados circuito sequencial S
signal rsts, rste, rstff: std_logic;  -- clear dos circuitos sequenciais

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

	HX7: hex_game port map (q0, q1, HEX7);
	VIDAS: decoder port map (e2, e1, e0, LEDR(4), LEDR(3), LEDR(2), LEDR(1), LEDR(0));
end structural;
