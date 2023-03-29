Library ieee;
Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_Incrementer is
generic(N : positive :=32;
	J : positive :=24);
Port(	nPCsel,RESET,CLK : in std_logic;
	offset : in std_logic_vector(J-1 downto 0);
	addr : out std_logic_vector(N-1 downto 0));
end entity;

architecture arch_Instruction_Incrementer of Instruction_Incrementer is
signal PC_EXTENDER_OUT : std_logic_vector(N-1 downto 0);
signal EA_MUX,EB_MUX,OUT_MUX : std_logic_vector(N-1 downto 0);
signal PC_MEMORY_OUT : std_logic_vector(N-1 downto 0) := (others=>'0');
begin
E0 : Entity work.extend_sign generic map(J) port map(offset,PC_EXTENDER_OUT);

E1 : Entity work.multiplexeur generic map(N) port map(EA_MUX,EB_MUX,nPCsel,OUT_MUX);


EA_MUX<=std_logic_vector(SIGNED(PC_MEMORY_OUT) + 1);
EB_MUX<=std_logic_vector(SIGNED(PC_EXTENDER_OUT) + SIGNED(EA_MUX));

process(clk)
begin
	if (RESET='1') then
		PC_MEMORY_OUT<= (others=>'0');
	elsif (rising_edge(CLK)) then
		PC_MEMORY_OUT<=OUT_MUX;
	end if;
end process;
addr<=PC_MEMORY_OUT;
end architecture;