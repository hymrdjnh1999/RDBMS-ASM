
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.regex.Pattern;

public class Valid {
    static Scanner scanner = new Scanner(System.in, "UTF-8");
    static BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

    public static String isNullString() throws UnsupportedEncodingException {
        String content = "";
        do {

            content = scanner.nextLine();
            // try {
            // content = bufferedReader.readLine();
            // } catch (IOException e) {
            // e.printStackTrace();
            // }
            System.out.println(content);

            if (!content.trim().isEmpty() && !content.equals(null)) {
                break;
            } else {
                System.out.println("Please don't let the string blank!");
            }
        } while (true);
        return content;
    }

    public static <T> T isNumberic(Integer option) throws UnsupportedEncodingException {
        Object number = isNullString();

        do {
            if (option == 1) {
                if (Pattern.compile("(\\d)").matcher(number.toString()).find()) {
                    number = Integer.parseInt(number.toString());
                    break;
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