package main;

import assembulator.Assembler;
import assembulator.Assembulator;

/**
 * The main entry point for the assembler program
 * 
 * @author george
 */
public final class Main {
	public static void main(String[] args) {
		Assembler a = new Assembulator("./resources/mips.txt");
		a.writeTo(System.out);
	}
}
