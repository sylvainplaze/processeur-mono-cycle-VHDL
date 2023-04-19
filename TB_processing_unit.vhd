Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_processing_unit is
generic(N : positive :=32;
	J : positive :=8);
end entity;

architecture arch_TB_processing_unit of TB_processing_unit is
signal CLK,We,RESET : std_logic :='0';
signal WrEn,COM1,COM2 : std_logic;
signal imm : std_logic_vector(J-1 downto 0);
signal RW,RA,RB : std_logic_vector(3 downto 0);
signal OP : std_logic_vector(1 downto 0);
signal flag : std_logic;
signal BusW : std_logic_vector(31 downto 0);
begin
E0:Entity work.processing_unit generic map(N,J) port map(CLK,We,WrEn,COM1,COM2,RESET,imm,RW,RA,RB,OP,flag,BusW);
CLK<='1' after 100 ps when CLK='0' else '0' after 100 ps when CLK='1';

--	
--	Y=A		Y=A+B		 	Y=RA+ImmE=63		Y=A-B			Y=RA-B			RA=RB			Y=ADDR_Memory		Y=ADDR_Memory
OP<=	"00",		"00" after 5 ns,	"00" after 10 ns,	"10" after 15 ns,	"10" after 20 ns,	"11" after 25 ns,	"11" after 30 ns,	"11" after 35 ns;
--	A=R(15)		A=R(15)			A=R(15)			A=R(1)			A=R(15)			A=R(15)			A=R(2)			A=R(15)
RA<=	"1111",		"1111" after 5 ns,	"1111" after 10 ns,	"0001" after 15 ns,	"1111" after 20 ns,	"0010" after 25 ns,	"0010" after 30 ns,	"0100" after 35 ns;
--	B=R(0)		B=R(15)			B=R(0)			B=R(15)			B=R(0)			B=R(0)			B=R(0)			B=R(1)
RB<=	"0000",		"1111" after 5 ns,	"0000" after 10 ns,	"1111" after 15 ns,	"0000" after 20 ns,	"0000" after 25 ns,	"0000" after 30 ns,	"0001" after 35 ns;
--	W=R(0)		W=R(1)			W=R(2)			W=R(3)			W=R(4) 			W=R(5)			W=R(6)			W=R(0)
RW<=	"0000",		"0001" after 5 ns,	"0010" after 10 ns,	"0011" after 15 ns,	"0100" after 20 ns, 	"0101" after 25 ns,	"0110" after 30 ns,	"0000" after 35 ns;
--	S<=A		S<=A			S<=B			S<=A			S<=B			S<=A			S<=A			S<=A
COM1<=	'0',		'0' after 5 ns, 	'1' after 10 ns,	'0' after 15 ns,	'1' after 20 ns,	'1' after 25 ns,	'0' after 30 ns,	'0' after 35 ns;
--	S<=A		S<=A			S<=A			S<=A			S<=A 			S<=A			S<=B			S<=B	
COM2<=	'0',		'0' after 5 ns,		'0' after 10 ns,	'0' after 15 ns,	'0' after 20 ns, 	'0' after 25 ns,	'1' after 30 ns,	'1' after 35 ns;
imm<="00000000","00001111" after 10 ns;
-- 	EcritureMemory=R
WrEn<= '0', '1' after 35 ns, '0' after 36 ns;
We <= '1' after  5 ns when We='0' else '0' after 200 ps when We='1';
end architecture;