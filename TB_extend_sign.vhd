Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_extend_sign is
end entity;

architecture arch_TB_extend_sign of TB_extend_sign is
constant N : positive :=6;
signal E : std_logic_vector(N-1 downto 0);
signal S : std_logic_vector(31 downto 0);

component extend_sign is
	generic(N:positive);
	port( 	A : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(31 downto 0));
end component;

begin
E<="010101","011111" after 10 ps,"100000" after 20 ps, "111111" after 30 ps;
E0:Entity work.extend_sign generic map(N) port map(E,S);
end architecture;