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

    static void SearchMenu(Login li) throws UnsupportedEncodingException {
        App.clrscr();
        login = li;
        System.out.println("|==================================================|");
        System.out.println("|               Search product menu                |");
        System.out.println("|==================================================|");
        System.out.println("| 1. Search by category                            |");
        System.out.println("| 2. Search by category,name                       |");
        System.out.println("| 3. Search by category,name,range price           |");
        System.out.println("|==================================================|");
        System.out.print("#Enter your select : ");
        searchSwitchMenu();
    }

    static void searchSwitchMenu() throws UnsupportedEncodingException {

        String select = scanner.nextLine();
        switch (select) {
            case "1":
            case "2":
            case "3":
                UpdateProduct.updateProductInfo(login, Integer.parseInt(select));
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

    static void storeProcedure(Integer select) {
        System.out.println("Product Name : ");
        productName = Validate.isNullString();
        switch (select) {
            case 1:
                callStoreProcedure = "{call searchProductByName(?)}";
                break;
            case 2:
                callStoreProcedure = "{call searchProductByName(?,?)}";
                System.out.println("Product Name : ");
                productName = Validate.isNullString();
                System.out.println("Category Name : ");
                categoryName = Validate.isNullString();
                break;
            case 3:
                callStoreProcedure = "{call searchProductByName(?,?,?,?)}";
                System.out.println("Product Name : ");
                productName = Validate.isNullString();
                System.out.println("Category Name : ");
                categoryName = Validate.isNullString();
                System.out.print("Product price range start  : ");
                productStartRange = (Double) Validate.getTrueValue(2);
                break;
            default:
                break;
        }
    }

    static void executeSearchProduct(String sql, Integer select, Login login) {
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
        }
    }

    static void ResultOfQuery(CallableStatement call, Integer select) throws SQLException {
        ResultSet rs = call.executeQuery();
        // System.out.printf());
        if (select.equals(1))
            while (rs.next()) {

            }
        else if (select.equals(2))
            while (rs.next()) {

            }
        else
            while (rs.next()) {

            }

    }

}