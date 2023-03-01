Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_multiplexeur is
end entity;

architecture arch_TB_multiplexeur of TB_multiplexeur is
signal N : positive :=6;
signal A,B,S : std_logic_vector(N-1 downto 0);
signal M : std_logic;
component multiplexeur is
	generic(N:positive);
	port( 	A,B : in std_logic_vector(N-1 downto 0);
		M : in std_logic;
		S : out std_logic_vector(N-1 downto 0));
end component;
begin
E0:Entity work.multiplexeur generic map(N) port map(A,B,M,S);
end architecture;