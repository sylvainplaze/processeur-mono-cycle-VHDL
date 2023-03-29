Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_Memory is
generic(N : positive :=32);
port(	addr : in std_logic_vector(N-1 downto 0);
	Instruction : out std_logic_vector(N-1 downto 0));
end entity;


Architecture arch_Instruction_Memory of Instruction_Memory is

--D�claration Type Tableau Memoire
type table is array (63 downto 0) of std_logic_vector(31 downto 0);

--Function d'initialisation du banc de registres
function init_banc return table is
variable result : table;

begin
for i in 62 downto 0 loop
	result(i) := (others=>'0');
end loop;
	result(63) :=X"00000038";--56 en decimal
	return result;
end init_banc;

--D�claration et Initialisation du banc de registre 16x32 bits
signal Banc: table:=init_banc;

begin

--Partie Lecture:
Instruction<=Banc(To_integer(unsigned(addr)));
end architecture;
