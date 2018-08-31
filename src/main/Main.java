package main;

import java.util.Scanner;

import assembulator.Assembler;
import assembulator.Assembulator;

/**
 * The main entry point for the assembler program
 * 
 * @author george
 */
public final class Main {
	public static void main(String[] args) {
		String filename;
		
		if (args.length == 0) {
			Scanner read = new Scanner(System.in);
			System.out.print("Please type the filename: ");
			filename = read.nextLine();
			read.close();
		} else {
			filename = args[0];
		}
		
		Assembler a = new Assembulator(filename);
		//a.writeTo(System.out);
	}
}
