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
	private static final int NOP_PAD = 1;

	private List<String> _RawAssembly;
	private Map<String, Integer> _JumpTargets;

	public Assembulator() {
		_RawAssembly = new ArrayList<>();
		_JumpTargets = new HashMap<>();

		File codeFile = new File(MIPS_FILE);

		Scanner codeScan;
		try {
			codeScan = new Scanner(codeFile);
			while (codeScan.hasNextLine()) {
				_RawAssembly.add(codeScan.nextLine());
			}
			codeScan.close();
		} catch (FileNotFoundException e) {
			System.out.println("File not found");
			System.exit(1);
		}
	}

	/**
	 * Writes assembly code to output stream
	 * 
	 * @param os is the outputstream
	 */
	public void writeTo(OutputStream os) {
		List<String> filteredCode = filterCode(_RawAssembly);
		List<String> parsedCode = parseCode(filteredCode);		
		printCode(new PrintStream(os), filteredCode, parsedCode);
	}

	/**
	 * Takes raw assembly file line by line and filters out to instructions
	 * 
	 * @param rawAssembly code list
	 * @return filtered assembly code
	 */
	private List<String> filterCode(List<String> rawAssembly) {

		Predicate<String> EmptyAndCommentOnlyLines = s -> {
			// Ignore comments and then split by comma/spaces
			String[] split = s.split("\\#")[0].split("[,\\s]+");
			boolean atLeastOneCommand = split.length > 1 && !split[0].isEmpty();
			return atLeastOneCommand;
		};

		Function<String, String> addNopToEmptyTargetLines = s -> {
			boolean hasColon = s.contains(":");
			boolean canSplitByColon = s.split(":\\s+").length == 2;
			if (!hasColon || canSplitByColon) {
				return s;
			}
			return s + " nop";
		};
		
		List<String> filteredCode = rawAssembly.stream().map(addNopToEmptyTargetLines)
														.filter(EmptyAndCommentOnlyLines)
														.collect(Collectors.toList());

		for (int i = 0; i < filteredCode.size(); i++) {
			String line = filteredCode.get(i);
			if (line.contains(":")) {
				String[] splitLine 	= line.split(":\\s+"); // Split by colon and spaces
				String command 		= splitLine[1];
				String target 		= splitLine[0];

				// trim target tag from command
				// store address of target tag
				filteredCode.set(i, command);
				_JumpTargets.put(target, i);
			}
		}

		return filteredCode;
	}

	/**
	 * Takes filtered code and converts it to assembly, as well as 
	 * replaces branch targets with address lines.
	 * 
	 * @param filteredCode
	 * @return parsed code
	 */
	private List<String> parseCode(List<String> filteredCode) {
		Function<String, String> targetReplacer = s -> {
			if (!s.matches("\\d+[a-zA-z]+")) {
				return s;
			}
			String encoding = s.replaceAll("[a-zA-Z]", "");
			int address = _JumpTargets.get(s.replaceAll("\\d", ""));
			return encoding + Parser.toBinary(NOP_PAD*address, 27);
		};

		return filteredCode.parallelStream().map(Parser::parseLine)
											.map(targetReplacer)
											.collect(Collectors.toList());
	}

	/**
	 * @param filteredCode
	 * @param parsedCode
	 */
	private void printCode(PrintStream ps, List<String> filteredCode, List<String> parsedCode) {
		Map<Integer, String> reverseTargets = new HashMap<>();
		_JumpTargets.forEach((s, i) -> reverseTargets.put(i, s));

		// Print Header
		String n = System.lineSeparator();
		ps.printf(DEPTH_FORMAT + n, DEPTH);
		ps.printf(WIDTH_FORMAT + n, WIDTH);
		ps.println();

		ps.println(ADDR_RADIX);
		ps.println(DATA_RADIX);
		ps.println();

		// Print Content
		ps.println("CONTENT");
		ps.println("BEGIN");

		for (int i = 0; i < filteredCode.size(); i++) {
			String rawLine = filteredCode.get(i);

			if (!reverseTargets.containsKey(i)) {
				ps.printf("%4s-- %s%s", "", rawLine, n);
			} else {
				String target = reverseTargets.get(i);
				ps.printf("%4s-- %s: %s%s", "", target, rawLine, n);
			}

			int address = NOP_PAD*i;
			String instrCode = parsedCode.get(i);
			ps.printf("%04d : %s;%s", address, instrCode, n);
		}
		
		ps.printf("[%d..%d] : %032d;%s", filteredCode.size(), 307200, 0, n);
		ps.println("END;");
	}

	public static void main(String[] args) {
		Assembulator a = new Assembulator();
		a.writeTo(System.out);
	}

}