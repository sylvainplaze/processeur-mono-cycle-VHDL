Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Processor_State_Register is
generic(N : positive :=32);
port(	DataIn : in std_logic_vector(N-1 downto 0);
	RESET,CLK,WE : in std_logic;
	DataOut : out std_logic_vector(N-1 downto 0));
end entity;

Architecture arch_Processor_State_Register of Processor_State_Register is
begin
process(CLK)
begin
	if (RESET='1') then
		DataOut<= (others=>'0');
	elsif Rising_edge(CLK) then
		if (WE='1') then
			DataOut<=DataIn;
		end if;
	end if;
end process;
end architecture;

