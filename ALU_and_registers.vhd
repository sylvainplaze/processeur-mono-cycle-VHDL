Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ALU_and_registers is
port(	WE,RESET,CLK : in std_logic;
	OP : in std_logic_vector(1 downto 0);
	RW,RA,RB : in std_logic_vector(3 downto 0);
	recopie : out std_logic_vector(31 downto 0));
end entity;

architecture arch_ALU_and_registers of ALU_and_registers is
signal A,B,W : std_logic_vector(31 downto 0);
signal N : std_logic;
begin
E0:Entity work.ALU port map(A,B,OP,W,N);
E1:Entity work.Registers port map(CLK,W,WE,RESET,RW,RA,RB,A,B);
recopie<=W;--Recopie du signal  pour l'avoir en sortie du block
end architecture;