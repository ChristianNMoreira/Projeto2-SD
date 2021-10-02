library ieee;
use ieee.std_logic_1164.all;

entity guess_game is port(
	t: in std_logic; -- entrada da tentativa
	clk: in std_logic;
	r: out std_logic; -- indica vitória
	e: out std_logic; -- indica derrota
	c0, c1, c2: out std_logic -- contagem de erros
);
end guess_game;