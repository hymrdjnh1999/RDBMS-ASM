import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.Scanner;
import java.sql.ResultSet;

public class SearchProduct {
    private static String productName, callStoreProcedure = "", categoryName;
    private static Double productStartRange, productEndRange, productRate, productStatus;
    private static Integer productID;
    static Scanner scanner = new Scanner(System.in);
    static CallableStatement callableStatement = null;
    static Login login;

    static void SearchMenu(Login li) throws UnsupportedEncodingException, NumberFormatException, SQLException {
        login = li;
        while (true) {
            App.clrscr();
            System.out.println("|==============================================|");
            System.out.println("|               Search product menu            |");
            System.out.println("|==============================================|");
            System.out.println("| 1. Search by name                            |");
            System.out.println("| 2. Search by category,name                   |");
            System.out.println("| 3. Search by category,name,range price       |");
            System.out.println("| 0. Back to main menu                         |");
            System.out.println("|==============================================|");
            System.out.print("#Enter your select : ");
            searchSwitchMenu();
        }

    }

    static void searchSwitchMenu() throws UnsupportedEncodingException, NumberFormatException, SQLException {

        String select = scanner.nextLine();
        switch (select) {
            case "1":
            case "2":
            case "3":
                storeProcedure(Integer.parseInt(select));
                break;
            case "0":
                ShopeeProcedure.mainMenu();
                break;
            default:
                System.out.println("Not have your select option\nEnter any key to continue...");
                scanner.nextLine();
                break;
        }
    }

    static void storeProcedure(Integer select) throws SQLException {
        System.out.print("Product Name : ");
        productName = Validate.isNullString();
        switch (select) {
            case 1:
                callStoreProcedure = "{call searchProductByName(?)}";
                break;
            case 2:
                callStoreProcedure = "{call searchProductbyCategoryName(?,?)}";
                System.out.print("Category Name : ");
                categoryName = Validate.isNullString();
                break;
            case 3:
                callStoreProcedure = "{call searchProductbyPriceRange(?,?,?,?)}";
                System.out.print("Category Name : ");
                categoryName = Validate.isNullString();
                System.out.print("Product price range start  : ");
                productStartRange = (Double) Validate.getTrueValue(2);
                System.out.print("Product price range end  : ");
                productEndRange = (Double) Validate.getTrueValue(3);
                break;
            default:
                break;
        }
        executeSearchProduct(callStoreProcedure, select, login);
    }

    static void executeSearchProduct(String sql, Integer select, Login login) throws SQLException {
        try {
            callableStatement = login.connection.prepareCall(sql);
            switch (select) {
                case 1:
                    callableStatement.setString(1, productName);
                    break;
                case 2:
                    callableStatement.setString(1, productName);
                    callableStatement.setString(2, categoryName);
                    break;
                case 3:
                    callableStatement.setString(1, productName);
                    callableStatement.setString(2, categoryName);
                    if (productEndRange > productStartRange) {
                        callableStatement.setDouble(3, productStartRange);
                        callableStatement.setDouble(4, productEndRange);
                    } else {
                        callableStatement.setDouble(3, productEndRange);
                        callableStatement.setDouble(4, productStartRange);
                    }
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            scanner.nextLine();
        }
        ResultOfQuery(callableStatement);
    }

    static void ResultOfQuery(CallableStatement call) throws SQLException {
        ResultSet rs = call.executeQuery();
        Integer rowsCount = 0;
        System.out.println(
                "=================================================================================================================================================");
        System.out.printf("| %-20s | %-15s | %-15s | %-15s | %-10s | %-10s | %-20s | %-10s | \n", "Category",
                "Name Sort", "Root Price", "Sale Price", "Quantity", "Sold", "Des Sort", "Rate");
        System.out.println(
                "=================================================================================================================================================");
        while (rs.next()) {
            System.out.printf("| %-20s | %-15s | %-15.0f | %-15.0f | %-10d | %-10d | %-20s | %-10.1f |\n",
                    rs.getString(1), rs.getString(2), rs.getDouble(3), rs.getDouble(4), rs.getInt(5), rs.getInt(6),
                    rs.getString(7), rs.getDouble(8));
            rowsCount++;
        }
        System.out.println(
                "=================================================================================================================================================");
        System.out.println(rowsCount + " row(s) returned!");
        System.out.print("Enter any key to back main menu...");
        scanner.nextLine();

    }

}