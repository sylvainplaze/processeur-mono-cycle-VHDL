Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Control_Unit is
generic(N : positive :=32;
	J : positive :=24;
	I : positive :=8);
port(	CLK,RESET : std_logic;
	RegWr,RegSel,ALUSrc,PSREn,MemWr,WrSrc : out std_logic;
	OP : out std_logic_vector(1 downto 0);
	Rn,Rd,Rm : out std_logic_vector(3 downto 0);
	Imm : out std_logic_vector(I-1 downto 0);
	PSR : in std_logic_vector(N-1 downto 0));
end entity;

Architecture arch_Control_Unit of Control_Unit is
signal nPCsel : std_logic :='0';
signal Instruction,addr :std_logic_vector(N-1 downto 0);
signal offset : std_logic_vector(J-1 downto 0) :=(others=>'0');
begin

E0 : Entity work.Instruction_Incrementer generic map(N,J) port map(nPCsel,RESET,CLK,offset,addr);

E1 : Entity work.Instruction_Memory generic map(N) port map(addr,Instruction);

E3 : Entity work.Instruction_Decoder generic map(N,J,I) port map(Instruction,PSR,nPCsel,RegWr,ALUSrc,PSREn,MemWr,WrSrc,RegSel,OP,Rn,Rd,Rm,Imm,offset);

end architecture;
