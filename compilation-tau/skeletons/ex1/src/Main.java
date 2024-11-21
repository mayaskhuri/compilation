import java.io.*;
import java.io.PrintWriter;
import java_cup.runtime.Symbol;

public class Main {
    static public void main(String argv[]) {
        Lexer l;
        Symbol s;
        FileReader file_reader;
        PrintWriter file_writer;
        String inputFilename = argv[0];
        String outputFilename = argv[1];

        try {
            // Initialize a file reader
            file_reader = new FileReader(inputFilename);

            // Initialize a file writer
            file_writer = new PrintWriter(outputFilename);

            // Initialize a new lexer
            l = new Lexer(file_reader);

            // Read the first token
            s = l.next_token();

            // Main loop: process tokens until EOF
            while (s.sym != TokenNames.EOF) {
                // Write token details to the file
                file_writer.print("[" + l.getLine() + "," + l.getTokenStartPosition() + "]:");
                file_writer.print(s.value);
                file_writer.print("\n");

                // Read the next token
                s = l.next_token();
            }

            // Close lexer input file
            l.yyclose();

            // Close output file
            file_writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
