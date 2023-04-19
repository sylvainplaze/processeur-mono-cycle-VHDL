Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity multiplexeur is
generic(N:positive :=32);
Port(	A,B : in std_logic_vector(N-1 downto 0);
	M : in std_logic;
	S : out std_logic_vector(N-1 downto 0));
end entity;

architecture arch_multiplexeur of multiplexeur is
begin
S<=B when M='1' else A;
end architecture;
