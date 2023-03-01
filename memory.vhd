Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity memory is
port(	CLK : in std_logic;
	DataIn : in std_logic_vector(31 downto 0);
	DataOut : out std_logic_vector(31 downto 0);
	addr : in std_logic_vector(5 downto 0);
	WrEn : in std_logic);
end entity;

Architecture arch_memory of memory is

--Déclaration Type Tableau Memoire
type table is array (63 downto 0) of std_logic_vector(31 downto 0);

--Function d'initialisation du banc de registres
function init_banc return table is
variable result : table;

begin
for i in 14 downto 0 loop
	result(i) := (others=>'0');
end loop;
	result(15) :=X"00000030";
	return result;
end init_banc;

--Déclaration et Initialisation du banc de registre 16x32 bits
signal Banc: table:=init_banc;

begin
--Partie Ecriture:
process(CLK)
begin
	if Rising_edge(CLK) then
		if (WrEn='1') then
			Banc(To_integer(unsigned(addr)))<=DataIn;
		end if;
	end if;
end process;
--Partie Lecture:
DataOut<=Banc(To_integer(unsigned(addr)));
end architecture;

