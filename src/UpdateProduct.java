import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class UpdateProduct {

    private static String productName, callStoreProcedure = "";
    private static Double productPrice, productSalePrice;
    private static Integer productID;
    static Scanner scanner = new Scanner(System.in);
    static CallableStatement callableStatement = null;
    static Login login;

    static void updateMenu(Login li) throws UnsupportedEncodingException {
        App.clrscr();
        login = li;
        System.out.println("|==================================================|");
        System.out.println("| Update Product Infomation with Product ID        |");
        System.out.println("|==================================================|");
        System.out.println("| 1. Update Name , Price, Status                   |");
        System.out.println("| 2. Update Name                                   |");
        System.out.println("| 3. Update Price                                  |");
        System.out.println("| 0. Back main menu                                |");
        System.out.println("|==================================================|");
        System.out.print("#Enter your select : ");
        updateSwitchMenu();
    }

    static void updateSwitchMenu() throws UnsupportedEncodingException {

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

    private static void executeUpdateProductInfo(String sql, Integer select, Login login) {

        try {
            callableStatement = login.connection.prepareCall(sql);
            switch (select) {
                case 1:
                    callableStatement.setInt(1, productID);
                    callableStatement.setString(2, productName);
                    callableStatement.setDouble(3, productPrice);
                    callableStatement.setDouble(4, productSalePrice);
                    break;
                case 2:
                    callableStatement.setInt(1, productID);
                    callableStatement.setString(2, productName);
                    break;
                case 3:
                    callableStatement.setInt(1, productID);
                    callableStatement.setDouble(2, productPrice);
                    callableStatement.setDouble(3, productSalePrice);
                    break;
            }
            callableStatement.execute();
            System.out.println("1row(s) updated");
            System.out.println("Enter any key to back...");
            scanner.nextLine();
        } catch (SQLException e) {
            System.out.println("0row(s) updated");
            System.out.println("Enter any key to back...");
            scanner.nextLine();
        }
    }

    private static void storeUpdateProductInfo(Integer select) {
        System.out.print("Product ID : ");
        productID = (Integer) Validate.getTrueValue(1);
        switch (select) {
            case 1:
                callStoreProcedure = "{call updateProductInfo(?,?,?,?   )}";
                System.out.print("Product Name : ");
                productName = Validate.isNullString();
                System.out.print("Product price : ");
                productPrice = (Double) Validate.getTrueValue(2);
                do {
                    System.out.print("Product sale price : ");
                    productSalePrice = (Double) Validate.getTrueValue(2);
                    if (productSalePrice < productPrice) {
                        System.out.println("Please don't let sale price than root price");
                    }
                } while (productSalePrice < productPrice);
                break;
            case 2:
                callStoreProcedure = "{call updateProductName(?,?)}";
                System.out.print("Product Name : ");
                productName = Validate.isNullString();
                break;
            case 3:
                callStoreProcedure = "{call updateProductName(?,?,?)}";
                System.out.print("Product price : ");
                productPrice = (Double) Validate.getTrueValue(2);
                do {
                    System.out.print("Product sale price : ");
                    productSalePrice = (Double) Validate.getTrueValue(2);
                    if (productSalePrice < productPrice) {
                        System.out.println("Please don't let sale price than root price");
                    }
                } while (productSalePrice < productPrice);
                break;
        }
    }

    static void updateProductInfo(Login log, Integer select) {
        App.clrscr();
        System.out.println("================================");
        System.out.println("update product information");
        System.out.println("================================");
        storeUpdateProductInfo(select);
        executeUpdateProductInfo(callStoreProcedure, select, log);
    }
}