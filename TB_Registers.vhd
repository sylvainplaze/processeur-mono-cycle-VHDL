Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_Registers is
end entity;

architecture arch_TB_Registers of TB_Registers is
signal CLK : std_logic :='0';
signal W : std_logic_vector(31 downto 0);
signal WE : std_logic;
signal RESET : std_logic;
signal RW,RA,RB : std_logic_vector(3 downto 0);
signal A,B : std_logic_vector(31 downto 0);
begin
E1:Entity work.Registers port map(CLK,W,WE,RESET,RW,RA,RB,A,B);
W<=std_logic_vector(To_signed(10,32)),std_logic_vector(To_signed(20,32)) after 20 ns;
CLK<='1' after 100 ps when CLK='0' else '0' after 100 ps when CLK='1';
WE<='0', '1' after 10 ns, '0' after 15 ns,'1' after 25 ns, '0' after 30 ns;
RESET<='0';
RW<="0001","0010" after 22 ns;
RA<="0000", "0001" after 40 ns;
RB<="0000", "0010" after 45 ns;
--rajouter CLK en code;
end architecture;