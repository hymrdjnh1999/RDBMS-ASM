import java.sql.SQLException;
import java.util.Scanner;

public class Login {
    String account, password;

    Scanner scanner = new Scanner(System.in);

    public Login() {
        do {

            try {
                System.out.print("Account : ");
                account = Valid.isNullString();
                System.out.print("Password : ");
                password = Valid.isNullString();
                Valid.getConnection(account, password);
                System.out.println("Login Success");
                System.out.print("Enter any key to continue...");
                scanner.nextLine();
                break;
            } catch (SQLException e) {
                System.out.println("Wrong Password or account! please check again your account!");
            }
        } while (true);
    }
}
