Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Registers is
Port(	CLK : in std_logic;
	W : in std_logic_vector(31 downto 0);
	WE : in std_logic;
	RESET : in std_logic;
	RW,RA,RB : in std_logic_vector(3 downto 0);
	A,B : out std_logic_vector(31 downto 0));
end entity;

architecture arch_Registers of Registers is
--Déclaration Type Tableau Memoire
type table is array (15 downto 0) of std_logic_vector(31 downto 0);

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

process(CLK,RESET)
begin
	if (RESET='1') then 
		banc<=init_banc;
	elsif (rising_edge(CLK)) then
		if (WE='1') then
			Banc(To_integer(unsigned(RW)))<=W;
		end if;
	end if;
end process;
A<=Banc(To_integer(unsigned(RA)));--Le bus de sortie A prend la valeur du registre de l'adresse RA
B<=Banc(To_integer(unsigned(RB)));--Le bus de sortie B prend la valeur du registre de l'adresse RB
end architecture;