import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Scanner;

public class App {
    public static void main(String[] args) throws UnsupportedEncodingException {
        // new Login();
        String s = new Scanner(System.in).nextLine();
        System.out.println(s);

    }

    public static void clrscr() {
        try {
            if (System.getProperty("os.name").contains("Windows"))
                new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
            else
                Runtime.getRuntime().exec("clear");
        } catch (IOException | InterruptedException ex) {
        }

    }
}
