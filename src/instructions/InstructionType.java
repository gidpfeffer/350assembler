package instructions;

public enum InstructionType {
	R,
	I,
	JI,
	JII,
	NOP;
	
	public static InstructionType getByName(String name) {
		for (InstructionType it : InstructionType.values()) {
			if (it.name() == name) {
				return it;
			}
		}
		
		return R;
	}
}
