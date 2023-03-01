Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity multiplexeur is
generic(N:positive);
Port(	A,B : in std_logic_vector(N-1 downto 0);
	M : in std_logic;
	S : out std_logic_vector(N-1 downto 0));
end entity;

architecture arch_multiplexeur of multiplexeur is
begin
S<=A when M='0' else B;
end architecture;
