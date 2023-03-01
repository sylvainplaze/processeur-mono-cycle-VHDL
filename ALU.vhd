Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ALU is
Port(	A,B : in std_logic_vector (31 downto 0);
	OP : in std_logic_vector(1 downto 0);
	Y : out std_logic_vector(31 downto 0);
	N : out std_logic);
end entity;

architecture arch_ALU of ALU is
signal AS,BS,S : signed(31 downto 0);
begin
AS<=signed(A);
BS<=signed(B);
S<= (AS+BS) when OP="00"
	else BS when OP="01"
	else (AS-BS) when OP="10"
	else AS when OP="11";
N<=S(31);
Y<=std_logic_vector(S);
end architecture;