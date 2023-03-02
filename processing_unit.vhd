Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity TB_multiplexeur is
generic(N : positive :=32;
	J : positive :=8);
port(	CLK,We,WrEn,COM1,COM2,RESET : in std_logic;
	imm : in std_logic_vector(J-1 downto 0);
	RW,RA,RB : in std_logic_vector(3 downto 0);
	OP : in std_logic_vector(1 downto 0);
	flag : out std_logic
);
end entity;

architecture arch_TB_multiplexeur of TB_multiplexeur is
signal Bus_W, Bus_A, Bus_B, EXS_OUT, Mux_F_OUT, ALU_OUT, Data_OUT : std_logic_vector(31 downto 0);


begin
E1:Entity work.registers port map(CLK,Bus_W,WE,RESET,RW,RA,RB,Bus_A,Bus_B);

E2:Entity work.ALU port map(Bus_A,Bus_B,OP,ALU_OUT,flag);

E3:Entity work.memory port map(CLK,Bus_B,Data_OUT,ALU_OUT(5 downto 0),WrEn);

E4:Entity work.extend_sign generic map(J) port map(imm,EXS_OUT);

E5:Entity work.multiplexeur generic map(N) port map(EXS_OUT,Bus_B,COM1,Mux_F_OUT);
E6:Entity work.multiplexeur generic map(N) port map(ALU_OUT,Data_OUT,COM2,Bus_W);
end architecture;
