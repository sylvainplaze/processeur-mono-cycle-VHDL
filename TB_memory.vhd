Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_memory is
end entity;

architecture arch_TB_memory of TB_memory is
signal CLK : std_logic :='0';
signal DataIn,DataOut : std_logic_vector(31 downto 0);
signal  addr : std_logic_vector(5 downto 0);
signal WrEn : std_logic;
begin
E0:Entity work.memory port map(CLK,DataIn,DataOut,addr,WrEn);
CLK<='1' after 100 ps when CLK='0' else '0' after 100 ps when CLK='1';

addr<=std_logic_vector(To_signed(4,6)),std_logic_vector(To_signed(6,6)) after 10 ns,std_logic_vector(To_signed(2,6)) after 15 ns,std_logic_vector(To_signed(6,6)) after 20 ns;
DataIn<=std_logic_vector(To_signed(10,32)),std_logic_vector(To_signed(20,32)) after 10 ns;
WrEn<='0','1' after 2 ns,'0' after 3 ns, '1' after 11 ns,'0' after 12 ns;
end architecture;
