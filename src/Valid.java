
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.regex.Pattern;

public class Valid {
    static Scanner scanner = new Scanner(System.in);

    public static boolean isThanZero(Object obj) {
        if (obj instanceof Integer && (Integer) obj < 0) {
            return false;
        } else if (obj instanceof Double && (Double) obj < 0) {
            return false;
        }
        return true;
    }

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

    public static <T> T isNumberic(Integer option) {
        Object number = scanner.nextLine();

        do {
            if (option == 1) {
                if (Pattern.compile("(\\d)").matcher(number.toString()).find()) {
                    number = Double.parseDouble(number.toString());
                    if ((double) number > 0) {
                        number = (double) 0;
                        break;
                    } else {

                    }

                } else {
                    System.out.println("Wrong Input!!");
                }
            }

        } while (true);
        return ((T) number);
    }

    public static Connection getConnection(String user, String password) throws SQLException {

        String url = "jdbc:mysql://localhost:3306/shopee";
        Connection connection = null;
        connection = DriverManager.getConnection(url, user, password);
        return connection;
    }

}