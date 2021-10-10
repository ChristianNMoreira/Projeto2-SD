library ieee;
use ieee.std_logic_1164.all;

-- t: SW(0)
-- clk: !KEY(0)
-- rst: !KEY(1)

entity guess_game is port(
	SW: in std_logic_vector(0 downto 0);
	KEY: in std_logic_vector(1 downto 0);
	LEDR: out std_logic_vector(4 downto 0);
	HEX0, HEX1, HEX2, HEX3, HEX7: out std_logic_vector(6 downto 0)
);
end guess_game;

architecture structural of guess_game is
component seq_S port (
	t: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	en: in std_logic;
	c: out std_logic;
	s2, s1, s0: out std_logic; -- conferir estados
	r: out std_logic
);
end component;
component seq_E port (
	c: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	en: in std_logic;
	e2, e1, e0: out std_logic;
	z: out std_logic
);
end component;
component ff_d port (
	d: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	en: in std_logic;
	q: out std_logic
);
end component;
component decoder port (
	K2, K1, K0: in std_logic;
	D4, D3, D2, D1, D0: out std_logic
);
end component;
component hex_palavra port (
   X2, X1, X0: in std_logic;
	H3, H2, H1, H0: out std_logic_vector(6 downto 0)
);
end component;
component hex_game port (
   r, z: in std_logic;
	H: out std_logic_vector(6 downto 0)
);
end component;

signal r, z: std_logic ;                  -- Ganhou (r) ou Perdeu (z)
signal c: std_logic;                      -- contagem de erros
signal e2, e1, e0: std_logic;             -- estados circuito sequencial E - conta erros
signal s2, s1, s0: std_logic;             -- estados circuito sequencial S - conta tentativas
signal rst: std_logic;                    -- clear dos circuitos sequenciais
signal ens, ene: std_logic;               -- enable dos circuitos sequenciais S(ens) e E(ene)

signal t, clk: std_logic;

begin
	t <= SW(0);
	clk <= not(KEY(0));
	rst <= not(KEY(1));
	ens <= not(e);
	ene <= not(r);

	seqS0: seq_S port map (t, clk, rst, ens, c, s2, s1, s0, r);
	seqE0: seq_E port map (c, clk, rst, ene, e2, e1, e0, z);

	HX7: hex_game port map (r, e, HEX7);
	HXPALAVRA: hex_palavra port map (s2, s1, s0, HEX3, HEX2, HEX1, HEX0);
	VIDAS: decoder port map (e2, e1, e0, LEDR(4), LEDR(3), LEDR(2), LEDR(1), LEDR(0));
end structural;
