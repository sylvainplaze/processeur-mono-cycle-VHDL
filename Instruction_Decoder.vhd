Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Instruction_Decoder is
generic(N : positive :=32;
	J : positive :=24;
	I : positive :=8);
port(	Instruction,PSR : in std_logic_vector(N-1 downto 0);
	--Commande:
	nPCsel,RegWr,ALUSrc,PSREn,MemWr,WrSrc,RegSel : out std_logic;
	OP : out std_logic_vector(1 downto 0);
	--Commande Registre:
	Rn,Rd,Rm : out std_logic_vector(3 downto 0);
	Imm : out std_logic_vector(I-1 downto 0);
	Offset : out std_logic_vector(J-1 downto 0));
	--Rajouter le RESET:
end entity;

Architecture arch_Instruction_Decoder of Instruction_Decoder is
type enum_instruction is (LDR,ADDi,MOV,ADDr,CMP,STR,BAL,BLT,EXT);
signal instr_courante : enum_instruction;
--Commentaire: ajouter une instruction : interuption(pause) et reset(pour remettre � zero)

begin
--Partie pour d�terminer l'instruction � �xecuter:
instr_courante<=ADDi when Instruction(31 downto 20)="111000101000" else
		ADDr when Instruction(31 downto 20)="111000001000" else
		BAL when Instruction(31 downto 24)="11101010" else
		BLT when Instruction(31 downto 24)="10111010" else
		CMP when Instruction(31 downto 20)="111000110101" else
		LDR when Instruction(31 downto 20)="111001100001" else
		MOV when Instruction(31 downto 20)="111000111010" else
		STR when Instruction(31 downto 20)="111001100000" else
		EXT when Instruction(31 downto 20)="000000000000";

--Execution de l'instuction d�termin�e par l'envoie des commandes:
process(Instruction,instr_courante)
begin
--	if instr_courante=ADDi then
--			nPCsel<='0';
--			RegWr<='1';
--			ALUSrc<='1';
--			OP<="00";
--			PSREn<='0';
--			MemWr<='0';
--			WrSrc<='0';
--			RegSel<='0'; --Mis en commentaire car peut �tre � 0 ou 1
--			Rn<=Instruction(19 downto 16);
--			Rd<=Instruction(15 downto 12);
--			Imm<=Instruction(7 downto 0);
--	elsif instr_courante=ADDr then
--			nPCsel<='0';
--			RegWr<='1';
--			ALUSrc<='0';
--			OP<="00";
--			PSREn<='0';
--			MemWr<='0';
--			WrSrc<='0';
--			RegSel<='0';
--			Rn<=Instruction(19 downto 16);
--			Rd<=Instruction(15 downto 12);
--			Rm<=Instruction(3 downto 0);
--	elsif instr_courante=BAL then
--			nPCsel<='1';
--			RegWr<='0';
--			ALUSrc<='0';
--			OP<="00";
--			PSREn<='0';
--			MemWr<='0';
--			WrSrc<='0';
--			RegSel<='0';
--			Offset<=Instruction(J-1 downto 0);
--	elsif instr_courante=BLT then
--			nPCsel<=PSR(31);
--			RegWr<='0';
--			ALUSrc<='0';
--			OP<="00";
--			PSREn<='0';
--			MemWr<='0';
--			WrSrc<='0';
--			RegSel<='0';
--			Offset<=Instruction(J-1 downto 0);
--	elsif instr_courante=CMP then
--			nPCsel<='0';
--			RegWr<='0';
--			ALUSrc<='1';
--			OP<="10";
--			PSREn<='1';
--			MemWr<='0';
--			WrSrc<='0';
--			RegSel<='0';
--			Rn<="0000";
--			--Rn<=Instruction(19 downto 16);
--			Imm<=Instruction(7 downto 0);
--	elsif instr_courante=LDR then
--			nPCsel<='0';
--			RegWr<='1';
--			ALUSrc<='1';
--			OP<="00";
--			PSREn<='0';
--			MemWr<='0';
--			WrSrc<='1';
--			RegSel<='0';
--			Rn<=Instruction(19 downto 16);
--			Rd<=Instruction(15 downto 12);
--			Imm<=Instruction(I-1 downto 0);
--	elsif instr_courante=MOV then
--			nPCsel<='0';
--			RegWr<='1';
--			ALUSrc<='1';
--			OP<="01";
--			PSREn<='0';
--			MemWr<='0';
--			WrSrc<='0';
--			RegSel<='0';
--			Rd<=Instruction(15 downto 12);
--			Imm<=Instruction(I-1 downto 0);
--	elsif instr_courante=STR then
--			nPCsel<='0';
--			RegWr<='0';
--			ALUSrc<='1';
--			OP<="00";
--			PSREn<='0';
--			MemWr<='1';
--			WrSrc<='0';
--			RegSel<='1';
--			Rn<=Instruction(19 downto 16);
--			Rd<=Instruction(15 downto 12);
--			Imm<=Instruction(I-1 downto 0);
--	elsif instr_courante=EXT then
--			nPCsel<='0';
--			RegWr<='0';
--			ALUSrc<='0';
--			OP<="00";
--			PSREn<='0';
--			MemWr<='0';
--			WrSrc<='0';
--			RegSel<='0';
--			Rn<="0000";
--			Rd<="0000";
--			Rm<="0000";
--			Imm<="00000000";
--			offset<="000000000000000000000000";
--	end if;

	case instr_courante is
		when ADDi =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='1';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0'; --Mis en commentaire car peut �tre � 0 ou 1
			Rn<=Instruction(19 downto 16);
			Rd<=Instruction(15 downto 12);
			Imm<=Instruction(7 downto 0);
		when ADDr =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='0';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
			Rn<=Instruction(19 downto 16);
			Rd<=Instruction(15 downto 12);
			Rm<=Instruction(3 downto 0);
		when BAL =>
			nPCsel<='1';
			RegWr<='0';
			ALUSrc<='0';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
			Offset<=Instruction(J-1 downto 0);
		when BLT =>
			nPCsel<=PSR(31);
			RegWr<='0';
			ALUSrc<='0';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
			Offset<=Instruction(J-1 downto 0);
		when CMP =>
			nPCsel<='0';
			RegWr<='0';
			ALUSrc<='1';
			OP<="10";
			PSREn<='1';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
			Rn<=Instruction(19 downto 16);
			Imm<=Instruction(7 downto 0);
		when LDR =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='1';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='1';
			RegSel<='0';
			Rn<=Instruction(19 downto 16);
			Rd<=Instruction(15 downto 12);
			Imm<=Instruction(I-1 downto 0);
		when MOV =>
			nPCsel<='0';
			RegWr<='1';
			ALUSrc<='1';
			OP<="01";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
			Rd<=Instruction(15 downto 12);
			Imm<=Instruction(I-1 downto 0);
		when STR =>
			nPCsel<='0';
			RegWr<='0';
			ALUSrc<='1';
			OP<="00";
			PSREn<='0';
			MemWr<='1';
			WrSrc<='0';
			RegSel<='1';
			Rn<=Instruction(19 downto 16);
			Rd<=Instruction(15 downto 12);
			Imm<=Instruction(I-1 downto 0);
		when EXT =>
			nPCsel<='0';
			RegWr<='0';
			ALUSrc<='0';
			OP<="00";
			PSREn<='0';
			MemWr<='0';
			WrSrc<='0';
			RegSel<='0';
			Rn<="0000";
			Rd<="0000";
			Rm<="0000";
			Imm<="00000000";
			offset<="000000000000000000000000";
	end case;
end process;
end architecture;