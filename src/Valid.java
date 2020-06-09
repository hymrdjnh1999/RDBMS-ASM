
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

public class Valid {
    static Scanner scanner = new Scanner(System.in);

    public static String isNullString() {
        String content = "";
        do {
            content = scanner.nextLine();
            if (!content.trim().isEmpty() && !content.equals(null)) {
                break;
            } else {
                System.out.println("Please don't let the string blank!");
            }
        } while (true);
        return content;
    }

    public static Connection getConnection(String user, String password) throws SQLException {

        String url = "jdbc:mysql://localhost:3306/shopee";
        Connection connection = null;
        connection = DriverManager.getConnection(url, user, password);
        return connection;
    }
}