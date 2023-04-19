Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_Memory is
generic(N : positive :=32);
port(	addr : in std_logic_vector(N-1 downto 0);
	Instruction : out std_logic_vector(N-1 downto 0));
end entity;


Architecture arch_Instruction_Memory of Instruction_Memory is

--Déclaration Type Tableau Memoire
type table is array (63 downto 0) of std_logic_vector(31 downto 0);

--Function d'initialisation du banc de registres
function init_banc return table is
variable result : table;

begin
for i in 62 downto 0 loop
	result(i) := (others=>'0');
end loop;
	--MOV:
	result(0) :="111000111010" & "0000" & "0001" & "0000" & "00100000";
	--MOV:
	result(1) :="111000111010" & "0000" & "0010" & "0000" & "00000000";
	--LDR:
	result(2) :="111001100001" & "0001" & "0000" & "000000000000";
	--ADDr:
	result(3) :="111000001000" & "0010" & "0010" & "00000000" & "0000";
	--ADDi:
	result(4) :="111000001000" & "0001" & "0001" & "0000" & "00000001";--vérifier
	--CMP:
	result(5) :="111000110101" & "0001" & "0000" & "0000" & "00101010";
	--BLT:
	result(6) :="10111010" & "111111111111111111111011";
	--STR:
	result(7) :="111001100000" & "0001" & "0010" & "000000000000";
	--BAL:
	result(8) :="11101010" & "111111111111111111110111"; 

	result(63):="00000000000000000000000000000000";--Exit programme --X"000000000000";56 en decimal
	return result;
end init_banc;

--Déclaration et Initialisation du banc de registre 16x32 bits
signal Banc: table:=init_banc;

begin

--Partie Lecture:
Instruction<=Banc(To_integer(signed(addr)));
--Voir pour rajouter une sécuriter pour ne pas dépasser la valeur 64 ou ajouter cela dans instruction incrementer
end architecture;

