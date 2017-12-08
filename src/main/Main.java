package main;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
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
		
		try {
			String output = "C:\\Users\\George Bernard\\Desktop\\350\\final-project-casino\\labskeleton\\imem.mif";
			FileOutputStream fos = new FileOutputStream(new File(output));
			Assembler a = new Assembulator(filename);
			a.writeTo(fos);
			a.writeTo(System.out);
		} catch (FileNotFoundException e) {
			System.err.println("output file not found");
		} 

	}
}
