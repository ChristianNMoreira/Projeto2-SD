library ieee;
use ieee.std_logic_1164.all;

-- t: SW(0)
-- clk: !KEY(0)
-- rst: !KEY(1)
-- pre: !KEY(2)

entity guess_game is port(
	SW: in std_logic_vector(0 downto 0);
	KEY: in std_logic_vector(2 downto 0);
	LEDR: out std_logic_vector(4 downto 0);
	HEX0, HEX1, HEX2, HEX3, HEX7: out std_logic_vector(6 downto 0)
);
end guess_game;

architecture structural of guess_game is
component seq_S port (
	t: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	preset: in std_logic;
	c: out std_logic;
	s2, s1, s0: out std_logic; -- conferir estados
	r: out std_logic
);
end component;
component seq_E port (
	c: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	preset: in std_logic;
	e2, e1, e0: out std_logic;
	z: out std_logic
);
end component;
component ff_d port (
	d: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	preset: in std_logic;
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

signal r, e: std_logic ;                  -- G ou P
signal c: std_logic;                      -- contagem de erros
signal e2, e1, e0: std_logic;             -- estados circuito sequencial E
signal ss2, ss1, ss0: std_logic;          -- estados circuito sequencial S
signal rst: std_logic;                    -- clear dos circuitos sequenciais
signal pre: std_logic;                    -- preset dos circuitos sequenciais

signal t, clk: std_logic;

begin
	t <= SW(0);
	clk <= not(KEY(0));
	rst <= not(KEY(1));
	pre <= not(KEY(2));

	seqS0: seq_S port map (t, clk, rst, pre, c, ss2, ss1, ss0, r);
	seqE0: seq_E port map (c, clk, rst, pre, e2, e1, e0, e);

	HX7: hex_game port map (r, e, HEX7);
	VIDAS: decoder port map (e2, e1, e0, LEDR(4), LEDR(3), LEDR(2), LEDR(1), LEDR(0));
end structural;
