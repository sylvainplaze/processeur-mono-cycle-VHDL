Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Processor is
end entity;

architecture arch_Processor of Processor is
constant N : positive :=32;
constant J : positive :=24;
constant I : positive :=8;

signal CLK : std_logic :='1';
signal RESET,nPCsel : std_logic :='0';
signal WrEn,WrSrc,ALUSrc,RegWr,PSREn,MemWr,RegSel,flag: std_logic;
signal op : std_logic_vector(1 downto 0);
signal Rw,Ra,Rb,Rd,Rm : std_logic_vector(3 downto 0);
signal IMM : std_logic_vector(I-1 downto 0);
signal Offset : std_logic_vector(J-1 downto 0);
signal BusW,Instruction,PSR,PSR_State : std_logic_vector(N-1 downto 0);
signal Look_addr : std_logic_vector(31 downto 0);

signal BusA : std_logic_vector(N-1 downto 0);
signal BusB : std_logic_vector(N-1 downto 0);

begin
--Génération de l'horloge : 5Ghz
CLK<='1' after 100 ps when CLK='0' else '0' after 100 ps when CLK='1';


E0 : Entity work.processing_unit generic map(N,I) port map(CLK,RegWr,WrEn,ALUSrc,WrSrc,RESET,IMM,Rw,Ra,Rb,OP,flag,BusW,BusA,BusB);
--CLK,We,WrEn,COM1,COM2,RESET : in std_logic;
--	imm : in std_logic_vector(I-1 downto 0);
--	RW,RA,RB : in std_logic_vector(3 downto 0);
--	OP : in std_logic_vector(1 downto 0);
--	flag : out std_logic;
--	BusW : out std_logic_vector(31 downto 0)
Rw<=Rd;
A0 : Entity work.multiplexeur generic map(4) port map(Rd,Rm,RegSel,Rb);
--Code:
PSR(31)<=flag;
PSR(30 downto 0)<=(others=>'0');

A1 : Entity work.Processor_State_Register generic map(32) port map(PSR,RESET,CLK,PSREn,PSR_State);

E1 : Entity work.Instruction_Management_Unit generic map(N,J) port map(nPCsel,RESET,CLK,Offset,Instruction,Look_addr);
--nPCsel,RESET,CLK : in std_logic;
--Offset : in std_logic_vector(J-1 downto 0);
--Instruction : out std_logic_vector(N-1 downto 0));

E3 : Entity work.Instruction_Decoder generic map(N,J,I) port map(Instruction,PSR_State,nPCsel,RegWr,ALUSrc,PSREn,MemWr,WrSrc,RegSel,OP,Ra,Rd,Rm,IMM,Offset);

--Instruction,PSR : in std_logic_vector(N-1 downto 0);
--nPCsel,RegWr,ALUSrc,PSREn,MemWr,WrSrc,RegSel : out std_logic;
--OP : out std_logic_vector(1 downto 0);
--Rn,Rd,Rm : out std_logic_vector(3 downto 0);
--Imm : out std_logic_vector(I-1 downto 0);
--Offset : out std_logic_vector(J-1 downto 0));

end architecture;
