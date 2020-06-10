import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class ProductDAL {
    private static String productName, productDes;
    private static Double productPrice, productSalePrice;
    private static Integer quantityInStock, productID;
    static Login login;
    static Scanner scanner = new Scanner(System.in);
    static String callStoreProcedure = "";

    public static void insertProduct(Login login) throws UnsupportedEncodingException {
        App.clrscr();
        String callStoreProcedure = "{call inputInfoProduct(?,?,?,?,?)}";
        CallableStatement cstm = null;
        System.out.println("================================");
        System.out.println("Insert into product");
        System.out.println("================================");
        try {
            cstm = login.connection.prepareCall(callStoreProcedure);
            System.out.print("Product Name : ");
            productName = Validate.isNullString();
            System.out.print("Product price : ");
            productPrice = (Double) Validate.getTrueValue(2);
            do {
                System.out.print("Product sale price : ");
                productSalePrice = (Double) Validate.getTrueValue(2);
                if (productSalePrice > productPrice) {
                    System.out.println("Please don't let sale price than root price");
                } else {
                    break;
                }
            } while (productSalePrice > productPrice);
            System.out.print("Product quantity in stock : ");
            quantityInStock = (Integer) Validate.getTrueValue(1);
            System.out.print("Product description : ");
            productDes = Validate.isNullString();
            cstm.setNString(1, productName);
            cstm.setDouble(2, productPrice);
            cstm.setDouble(3, productSalePrice);
            cstm.setInt(4, quantityInStock);
            cstm.setNString(5, productDes);
            System.out.println("================================");
            cstm.execute();
            System.out.println("(1) rows add");
            System.out.println("Enter any key to back...");
            scanner.nextLine();
        } catch (SQLException e) {
            System.out.println("(0) rows add");
            System.out.println("Enter any key to back...");
            scanner.nextLine();
        }

    }

    private static void executeUpdateProductInfo(String sql, Integer select) {
        CallableStatement callableStatement = null;
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
        login = log;
        System.out.println("================================");
        System.out.println("update product information");
        System.out.println("================================");
        storeUpdateProductInfo(select);
        executeUpdateProductInfo(callStoreProcedure, select);
    }
}