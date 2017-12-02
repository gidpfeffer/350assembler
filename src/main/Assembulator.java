package main;

import java.util.*;
import java.util.Scanner;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import parsing.Parser;

import java.io.*;

/**
 * Simple parser that converts MIPS code into machine code using the ISA
 * provided in instruction_codes.txt
 * 
 * @author pf51, ghb5
 **/
public class Assembulator {

	private static final String ADDR_RADIX = "ADDRESS_RADIX = DEC;";
	private static final String DATA_RADIX = "DATA_RADIX = BIN;";

	private static final String DEPTH_FORMAT = "DEPTH = %d;";
	private static final String WIDTH_FORMAT = "WIDTH = %d;";

	private static final int DEPTH = 4096;
	private static final int WIDTH = 32;

	private static final String MIPS_FILE = "./resources/mips.txt";

	private List<String> code;
	private Map<String, Integer> targets;

	public Assembulator() {
		code = new ArrayList<>();
		targets = new HashMap<>();

		File codeFile = new File(MIPS_FILE);

		Scanner codeScan;
		try {
			codeScan = new Scanner(codeFile);
			while (codeScan.hasNextLine()) {
				code.add(codeScan.nextLine());

			}
			codeScan.close();
		} catch (FileNotFoundException e) {
			System.out.println("File not found");
			System.exit(1);
		}
	}

	public void run() {
		List<String> filteredCode = filterCode(code);
		List<String> parsedCode = parseCode(filteredCode);

		printCode(filteredCode, parsedCode);
	}

	private List<String> filterCode(List<String> rawAssembly) {

		Predicate<String> ignoreLine = s -> {
			// Ignore comments
			s = s.split("\\#")[0];

			// Split by commas
			String[] split = s.split("[,\\s]+");

			// Must have at least one command
			return split.length > 1 && !split[0].isEmpty();
		};

		Function<String, String> convertTarget = s -> {
			if (!s.contains(":")) {
				return s;
			}

			if (s.split(":").length == 2) {
				return s;
			}
			
			return s + " nop";
		};

		List<String> filteredCode = rawAssembly.stream().map(convertTarget).filter(ignoreLine::test).collect(Collectors.toList());
		
		for(int i = 0; i < filteredCode.size(); i++) {
			String line = filteredCode.get(i);
			if(line.contains(":")) {
				String[] splitLine = line.split(":\\s+");
				String command = splitLine[1];
				String target = splitLine[0];
				
				filteredCode.set(i, command);
				targets.put(target, i);
			}
		}
		
		return filteredCode;
		
	}

	private List<String> parseCode(List<String> filteredCode) {
		
		Function<String, String> targetReplacer = s -> {
				if (!s.matches("\\d+[a-zA-z]+")) {
					return s;
				}
				
				
				String encoding = s.replaceAll("[a-zA-Z]", "");
				int address = targets.get(s.replaceAll("\\d", ""));
				
				return encoding + Parser.toBinary(address, 27);
		};
	
		return filteredCode.parallelStream().map(Parser::parseLine).map(targetReplacer).collect(Collectors.toList());
	}

	private void printCode(List<String> filteredCode, List<String> parsedCode) {
		Map<Integer, String> reverseTargets = new HashMap<>();
		targets.forEach((s, i) -> reverseTargets.put(i, s));

		String n = System.lineSeparator();
		System.out.printf(DEPTH_FORMAT + n, DEPTH);
		System.out.printf(WIDTH_FORMAT + n, WIDTH);
		System.out.println();

		System.out.println(ADDR_RADIX);
		System.out.println(DATA_RADIX);
		System.out.println();

		System.out.println("CONTENT");
		System.out.println("BEGIN");

		for (int i = 0; i < filteredCode.size(); i++) {

			String rawLine = filteredCode.get(i);

			if (!reverseTargets.containsKey(i)) {
				System.out.printf("%" + 4 + "s-- %s\n", "", rawLine);
			} else {
				String target = reverseTargets.get(i);
				System.out.printf("%" + 4 + "s-- %s: %s\n", "", target, rawLine);
			}

			System.out.printf("%4d : %s;\n", i, parsedCode.get(i));
		}

		System.out.println("END;");
	}

	public static void main(String[] args) {
		Assembulator a = new Assembulator();
		a.run();
	}

}