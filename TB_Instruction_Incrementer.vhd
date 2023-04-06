Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_Instruction_Incrementer is
end entity;

architecture arch_TB_Instruction_Incrementer of TB_Instruction_Incrementer is
constant N : positive :=32;
constant J : positive :=24;
signal nPCsel,RESET : std_logic;
signal CLK : std_logic :='0';
signal offset : std_logic_vector(J-1 downto 0);
signal addr : std_logic_vector(N-1 downto 0);

begin

E0:Entity work.Instruction_Incrementer generic map(N,J) port map(nPCsel,RESET,CLK,offset,addr);

CLK<='1' after 100 ps when CLK='0' else '0' after 100 ps when CLK='1';

process
begin
	--Initialisation:
	RESET<='1';
	nPCsel<='0';
	Offset<=std_logic_vector(To_signed(0,J));
	wait for 2 ns;
	
	--Attente:
	RESET<='0';
	nPCsel<='1';
	Offset<=std_logic_vector(To_signed(0,J));
	wait for 4 ns;
	
	--Commande 10:
	RESET<='0';
	nPCsel<='1';
	Offset<=std_logic_vector(To_signed(2,J));
	wait for 6 ns;

	--Reset:
	RESET<='1';
	nPCsel<='1';
	wait for 7 ns;
	Offset<=std_logic_vector(To_signed(0,J));
	wait for 8 ns;

	--Commande 3:
	RESET<='0';
	nPCsel<='0';
	Offset<=std_logic_vector(To_signed(3,J));
	wait for 10 ns;
	
	--Reset:
	RESET<='1';
	nPCsel<='0';
	wait for 11 ns;
	Offset<=std_logic_vector(To_signed(0,J));
	wait for 12 ns;
	
end process;
end architecture;
