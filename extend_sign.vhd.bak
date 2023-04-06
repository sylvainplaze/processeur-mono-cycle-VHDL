Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity extend_sign is
generic(J:positive :=32);
Port(	E : in std_logic_vector(J-1 downto 0);
	S : out std_logic_vector(31 downto 0));
end entity;

architecture arch_extend_sign of extend_sign is
begin
--S(31 downto J)<= (others => E(J-1));
--S(J-1 downto 0)<=E;
process(E)
begin
	if E(J-1)='1' then
		S<=(others => '1');
	else
		S<=(others => '0');
	end if;
	S(J-1 downto 0)<=E;
end process;
end architecture;