Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity processing_unit is
generic(N : positive :=32;
	I : positive :=8);
port(	CLK,We,WrEn,COM1,COM2,RESET : in std_logic;
	imm : in std_logic_vector(I-1 downto 0);
	RW,RA,RB : in std_logic_vector(3 downto 0);
	OP : in std_logic_vector(1 downto 0);
	flag : out std_logic;
	BusW : out std_logic_vector(31 downto 0)
);
end entity;

architecture arch_processing_unit of processing_unit is
signal Bus_W, Bus_A, Bus_B, EXS_OUT, Mux_F_OUT, ALU_OUT, Data_OUT : std_logic_vector(31 downto 0);

begin

BusW<=Bus_W;--Recopie du signal pour l'avoir en sortie du block

E1:Entity work.registers port map(CLK,Bus_W,WE,RESET,RW,RA,RB,Bus_A,Bus_B);

E2:Entity work.ALU port map(Bus_A,Mux_F_OUT,OP,ALU_OUT,flag);

E3:Entity work.memory port map(CLK,Bus_B,Data_OUT,ALU_OUT(5 downto 0),WrEn);

E4:Entity work.extend_sign generic map(I) port map(imm,EXS_OUT);

E5:Entity work.multiplexeur generic map(N) port map(Bus_B,EXS_OUT,COM1,Mux_F_OUT);

E6:Entity work.multiplexeur generic map(N) port map(ALU_OUT,Data_OUT,COM2,Bus_W);
end architecture;
