
package app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Validate {

    static BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));

    public static String isNullString() {
        String content = "";
        do {

            try {
                content = bufferedReader.readLine();
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (!content.trim().isEmpty() && !content.equals(null)) {
                break;
            } else {
                System.out.print("Please don't let the string blank!\nPlease re-enter : ");
            }
        } while (true);
        return content;
    }

    public static Object getTrueValue(Integer option) {
        Object obj = null;

        do {
            try {
                if (option.equals(1)) {

                    obj = Integer.parseInt(bufferedReader.readLine());

                } else {

                    obj = Double.parseDouble(bufferedReader.readLine());

                }
                break;
            } catch (Exception e) {
                System.out.print("Wrong data type\nPlease re-enter :  ");
            }

        } while (true);
        return obj;

    }

    public static Connection getConnection(final String user, final String password) throws SQLException {

        final String url = "jdbc:mysql://localhost:3306/shopee?useUnicode=true&characterEncoding=UTF-8";
        Connection connection = null;
        connection = DriverManager.getConnection(url, user, password);
        return connection;
    }

    public static String validateInputSelect() {
        String select = "";
        do {
            select = isNullString();

            if (select.equalsIgnoreCase("next") || select.equalsIgnoreCase("quit"))
                break;
            else
                System.out.print("Please exactly select : ");
        } while (!select.equalsIgnoreCase("next") || !select.equalsIgnoreCase("quit"));

        return select;
    }

}