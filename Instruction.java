
public enum Instruction {
	// Arithmetic (R) 					 [ALUopcode]
	ADD		(InstructionType.R,		"00000"),
	SUB		(InstructionType.R,		"00001"),
	AND		(InstructionType.R,		"00010"),
	OR		(InstructionType.R,		"00011"),
	SLL		(InstructionType.R,		"00100"),
	SRA		(InstructionType.R,		"00101"),
	MUL		(InstructionType.R,		"00110"),
	DIV		(InstructionType.R,		"00111"),
	SRL		(InstructionType.R, 	"01000"),
	// Arithmetic (I) 						[opcode]
	ADDI	(InstructionType.I,		"00101"),
	// Memory (I)
	SW		(InstructionType.I,		"00111"),
	LW		(InstructionType.I,		"01000"),
	// Branching (I)
	BEQ		(InstructionType.I, 	"01001"),
	BNE		(InstructionType.I,		"00010"),
	BLT		(InstructionType.I,		"00110"),
	// Jump (JI & JII)
	J		(InstructionType.JI,	"00001"),
	JAL		(InstructionType.JI,	"00011"),
	JR		(InstructionType.JII,	"00100"),
	// Exceptions (JI)
	BEX		(InstructionType.JI,	"10110"),
	SETX	(InstructionType.JI,	"10101"),
	NOP		(InstructionType.I,		"00000"),
	// VGA (I)
	SV		(InstructionType.I, 	"01010");
	
	private String name;
	private String opcode;
	InstructionType type;
	
	/**
	 * Constructs the enum from name, type, and opcode
	 * 
	 * @param name
	 * @param type
	 * @param opcode
	 */
	private Instruction(String name, InstructionType type, String opcode) {
		this.name = name;
		this.type = type;
		this.opcode = opcode;
	}
	
	
	/**
	 * Searches for Instruction by name lookup
	 * 
	 * @param name to search by
	 * @return corresponding instruction, if none found returns no-op
	 */
	public static Instruction getByName(String name) {
		
		// Search through values
		for ( Instruction i : Instruction.values() ) {
			Boolean found = name.equals(i.name().toLowerCase());
			if (found) {
				return i;
			}
		}
		
		// If not found return no-op
		return NOP;
	}
	
	/**
	 * @return the opcode for the given instruction
	 */
	public String getOpcode() {
		if (this.type != InstructionType.R) {
			return this.opcode;
		} else {
			return "00000";
		}
	}
	
	/**
	 * @return the ALU opcode for R type instructions (if not R type then empty string)
	 */
	public String getALUopcode() {
		if (this.type == InstructionType.R) {
			return this.opcode;
		} else {
			return "";
		}
	}
}
