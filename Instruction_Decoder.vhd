Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_Decoder is
generic(N : positive :=32);
port(	Instruction,PSR : in std_logic_vector(N-1 downto 0);
	--Commande:
	nPCsel,RegWr,ALUSrc,PSREn,MemWr,WrSrc,RegSel : out std_logic;
	OP : out std_logic_vector(1 downto 0);
	--Commande Registre:
	Rn,Rd,Rm : out std_logic_vector(3 downto 0));	
end entity;

Architecture arch_Instruction_Decoder of Instruction_Decoder is
type enum_instruction is (MOV,ADDi,ADDr,CMP,LDR,STR,BAL,BLT);
signal instr_courante : enum_instruction;


begin
--Partie pour d�terminer l'instruction � �xecuter:
instr_courante<=ADDi when Instruction(31 downto 20)="111000101000" else
		ADDr when Instruction(31 downto 20)="111000001000" else
		BAL when Instruction(31 downto 24)="11101010" else
		BLT when Instruction(31 downto 24)="10111010" else
		CMP when Instruction(31 downto 20)="111000110101" else
		LDR when Instruction(31 downto 20)="111001100001" else
		MOV when Instruction(31 downto 20)="111000111010" else
		STR when Instruction(31 downto 20)="111001100000";

--
process(instr_courante)
begin
	case instr_courante is
		when ADDi =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='1';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
		when ADDr =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='0';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
		when BAL =>
			nPCsel<='1';
			RegWr<='0';
			ALUSrc<='0';
			OP<="--";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
		when BLT =>
			nPCsel<='1';
			RegWr<='0';
			ALUSrc<='0';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
		when CMP =>
			nPCsel<='0';
			RegWr<='0';
			ALUSrc<='1';
			OP<="10";
			PSREn<='1';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
		when LDR =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='1';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='1';
			RegSel<='0';
		when MOV =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='1';
			OP<="11";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
		when STR =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='1';
			OP<="00";
			PSREn<='0';
			MemWr<='1';
			WrSrc<='0';
			RegSel<='-';
	end case;
end process;
end architecture;