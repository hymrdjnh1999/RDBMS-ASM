import java.io.IOException;
import java.io.UnsupportedEncodingException;

public class App {
    public static void main(String[] args) throws UnsupportedEncodingException {
        Login login = new Login();

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
