package assembulator;

import java.io.OutputStream;

public interface Assembler {
		
	/**
	 * Writes mips assembly to stream
	 * 
	 * @param os
	 */
	public void writeTo(OutputStream os);
}
