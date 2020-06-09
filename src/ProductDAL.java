import java.sql.CallableStatement;
import java.sql.SQLException;

public class ProductDAL {
    private static String productName, productDes, productStatus;
    private static Double productPrice, productSalePrice;
    private static Integer quantityInStock, quantitySold;

    public static void insertProduct(Login login) {

        String callStoreProcedure = "{call inputInfoProduct(?,?,?,?,?,?,?)}";
        CallableStatement cstm = null;
        try {
            cstm = login.connection.prepareCall(callStoreProcedure);
            System.out.print("Product Name : ");
            productName = Valid.isNullString();
        } catch (SQLException e) {
            // TODO: handle exception
        }

    }
}