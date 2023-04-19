Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_multiplexeur is
end entity;

architecture arch_TB_multiplexeur of TB_multiplexeur is
constant N : positive :=4;
signal A,B,S : std_logic_vector(N-1 downto 0);
signal M : std_logic;

begin
E0:Entity work.multiplexeur generic map(N) port map(A,B,M,S);
A<="0000","1010" after 100 ps;
B<="0000","0101" after 100 ps;
M<='U','0' after 200 ps, '1' after 300 ps;
end architecture;