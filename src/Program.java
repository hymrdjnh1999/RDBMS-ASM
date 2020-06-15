import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

public class Program {
    public static void main(String[] args) throws UnsupportedEncodingException, NumberFormatException, SQLException {
        new Login();

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