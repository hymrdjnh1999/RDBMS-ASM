import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class InsertProduct {
    private static String productName, productDes;
    private static Double productPrice, productSalePrice;
    private static Integer quantityInStock;
    static Scanner scanner = new Scanner(System.in);
    static String callStoreProcedure = "";

    public static void insertProduct(Login login) throws UnsupportedEncodingException {
        Program.clrscr();
        String callStoreProcedure = "{call inputInfoProduct(?,?,?,?,?)}";
        CallableStatement cstm = null;
        System.out.println("================================");
        System.out.println("Insert into product");
        System.out.println("================================");
        try {
            cstm = login.connection.prepareCall(callStoreProcedure);
            inputParameter();
            cstm.setString(1, productName);
            cstm.setDouble(2, productPrice);
            cstm.setDouble(3, productSalePrice);
            cstm.setInt(4, quantityInStock);
            cstm.setString(5, productDes);
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

    static void inputParameter() {
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
    }

}