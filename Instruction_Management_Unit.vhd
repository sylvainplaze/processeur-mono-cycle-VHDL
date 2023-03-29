Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_Management_Unit is
generic(N : positive :=32;
	J : positive :=24);
Port(	nPCsel,RESET,CLK : in std_logic;
	Offset : in std_logic_vector(J-1 downto 0);
	Instruction : out std_logic_vector(N-1 downto 0));
end entity;

architecture arch_Instruction_Management_Unit of Instruction_Management_Unit is
signal addr : std_logic_vector(N-1 downto 0);
begin

E0:Entity work.Instruction_Incrementer generic map(N,J) port map(nPCsel,RESET,CLK,offset,addr);

E1:Entity work.Instruction_Memory generic map(N) port map(addr,Instruction);

end architecture;