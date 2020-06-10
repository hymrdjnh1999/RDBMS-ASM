import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

public class Login {
    String account, password;
    Connection connection;
    Scanner scanner = new Scanner(System.in);

    public Login() throws UnsupportedEncodingException {
        do {

            try {
                System.out.print("Account : ");
                account = Validate.isNullString();
                System.out.print("Password : ");
                password = Validate.isNullString();
                connection = Validate.getConnection(account, password);
                System.out.println("Login Success");
                System.out.print("Enter any key to continue...");
                scanner.nextLine();
                break;
            } catch (SQLException e) {
                System.out.println("Wrong Password or account! please check again your account!");
            }
        } while (true);
        new ShopeeProcedure(this).mainMenu();

    }
}
