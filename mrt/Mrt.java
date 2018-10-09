import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * <h1>Mission Resource Tracker</h1>
 * Mission Resource Tracker (aka MRT) is a program to track personnel,
 * vehicles, and possibly other resources for missions or jobs.
 * 
 * @author Elfin Strange
 * @version 0.1
 * @since 2018-10-05
 */

public class Mrt {
    private File dir;
    
    /**
     * Print the syntax for starting the application to the command
     * line.
     */
    private static void printSyntax() {
        String syntax = "Error: Syntax\n\r"                   +
                        "  java -cp . Mrt <options>\n\r"      +
                        "    Option              Description\n\r" +
                        "      -d <directory>    Change working directory to <directory>";
        System.out.println(syntax);
    }
    
    private static File setDir(String dirStr) {
        File newDir = new File(dirStr);
        if (!newDir.isDirectory()) {
            System.err.println("Error: Invalid directory!");
            printSyntax();
            System.exit(1);
        }
        return newDir;
    }
    
    public static void main(String[] args) {
        boolean valid = true;
        String newDirStr;
        Mrt newMrt = new Mrt();
        //System.out.println("Parameters: " + args.length);
        if (args.length == 0) {
            newMrt.dir =setDir(ClassLoader.getSystemClassLoader().getResource(".").getPath());
        } else {
            int i = 0;
            while (valid && i < args.length) {
                if (args[i] == null) {
                    printSyntax();
                    System.exit(1);
                }
                String arg = args[i];
                switch (arg) {
                    case "-d":
                        if(++i >= args.length) {
                            System.err.println("Error: Invalid directory!");
                            printSyntax();
                            System.exit(1);
                        }
                        newDirStr = args[i];
                        newMrt.dir = setDir(newDirStr);;
                        break;
                    default:
                        newDirStr = args[++i];
                        System.out.println("Argument: " + newDirStr);
                        printSyntax();
                        System.exit(1);
                }
                i++;
            }
        }
        try {
            System.out.println("Directory: " + newMrt.dir.getCanonicalPath());
        } catch (IOException ex) {
            Logger.getLogger(Mrt.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}