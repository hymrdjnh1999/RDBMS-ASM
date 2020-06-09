import java.io.UnsupportedEncodingException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class ProductDAL {
    private static String productName, productDes;
    private static Double productPrice, productSalePrice;
    private static Integer quantityInStock, quantitySold, productStatus;
    static Scanner scanner = new Scanner(System.in);

    public static void insertProduct(Login login) throws UnsupportedEncodingException {
        String callStoreProcedure = "{call inputInfoProduct(?,?,?,?,?,?,?)}";
        CallableStatement cstm = null;
        try {
            cstm = login.connection.prepareCall(callStoreProcedure);
            System.out.print("Product Name : ");
            productName = Valid.isNullString();
            System.out.print("Product price : ");
            productPrice = Double.parseDouble(scanner.nextLine());
            System.out.print("Product sale price : ");
            productSalePrice = Double.parseDouble(scanner.nextLine());
            System.out.print("Product quantity in stock : ");
            quantityInStock = Integer.parseInt(scanner.nextLine());
            System.out.print("Product quantity sold : ");
            quantitySold = Integer.parseInt(scanner.nextLine());
            System.out.print("Product description : ");
            productDes = scanner.nextLine();
            System.out.print("Product status(1,2,3)<=>(Còn Hàng,Bán Hết,Không Còn Kinh Doanh): ");
            productStatus = Integer.parseInt(scanner.nextLine());
            cstm.setNString(1, productName);
            cstm.setDouble(2, productPrice);
            cstm.setDouble(3, productSalePrice);
            cstm.setInt(4, quantityInStock);
            cstm.setInt(5, quantitySold);
            cstm.setNString(6, productDes);
            cstm.setInt(7, productStatus);
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
}