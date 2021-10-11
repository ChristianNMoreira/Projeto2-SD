library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1 is
 port(
     A,B,C,D : in std_logic;
     s1,s0: in std_logic;
     Z: out std_logic
  );
end mux_4x1;

architecture behavior of mux_4x1 is
begin
process (A,B,C,D,s1,s1) is
begin
  if (S0 ='0' and S1 = '0') then
      Z <= A;
  elsif (S0 ='1' and S1 = '0') then
      Z <= B;
  elsif (S0 ='0' and S1 = '1') then
      Z <= C;
  else
      Z <= D;
  end if;

end process;
end behavior;