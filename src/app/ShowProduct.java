package app;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class ShowProduct {
    static Scanner scanner = new Scanner(System.in);

    public static void show(Login login) {
        String select = "";

        CallableStatement callableStatement = null;
        try {
            String sql = "{ call showListProduct(?)}";
            callableStatement = login.connection.prepareCall(sql);
            int setCount = 0;
            do {
                ClearScreen.clrscr();
                callableStatement.setInt(1, setCount);
                ResultSet rs = callableStatement.executeQuery();
                System.out.println(
                        "======================================================================================================================================================");
                System.out.printf("| %-30s | %-15s | %-15s | %-15s | %-10s | %-10s | %-20s | %-10s | \n", "Category",
                        "Sort Name", "Root Price", "Sale Price", "Quantity", "Sold", "Sort Description", "Rate");
                System.out.println(
                        "======================================================================================================================================================");
                while (rs.next()) {
                    System.out.printf("| %-30s | %-15s | %-15.0f | %-15.0f | %-10d | %-10d | %-20s | %-10.1f |\n",
                            rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getDouble(4), rs.getInt(5),
                            rs.getInt(6), rs.getString(7).substring(1, 10).concat("..."), rs.getDouble(8));
                }
                System.out.println(
                        "======================================================================================================================================================");
                System.out.print("Enter (next | quit)");
                select = Validate.validateInputSelect();
                if (select.equalsIgnoreCase("quit")) {
                    System.out.print("Enter any key to continue...");
                    scanner.nextLine();
                    break;
                }
                setCount += 5;
            } while (!select.equalsIgnoreCase("quit"));

        } catch (SQLException e) {
            e.printStackTrace();

        }
    }
}