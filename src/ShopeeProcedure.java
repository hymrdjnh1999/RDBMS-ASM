import java.io.UnsupportedEncodingException;
import java.util.Scanner;

public class ShopeeProcedure {
    static Scanner scanner = new Scanner(System.in);
    static Login login;

    public ShopeeProcedure(Login log) {
        this.login = log;
    }

    public ShopeeProcedure() {

    };

    public static void mainMenu() throws UnsupportedEncodingException {
        while (true) {
            System.out.println("|==================================================|");
            System.out.println("| Hello! Here is Sales Data create by Voi Be Nho^^ |");
            System.out.println("|==================================================|");
            System.out.println("|        Below is options of sales database        |");
            System.out.println("|==================================================|");
            System.out.println("|   1. Input product information                   |");
            System.out.println("|   2. Update product information                  |");
            System.out.println("|   3. Search product                              |");
            System.out.println("|   0. Exit                                        |");
            System.out.println("|==================================================|");
            ShopeeProcedure.mainMenuSwitch();
        }
    }

    protected static void mainMenuSwitch() throws UnsupportedEncodingException {
        System.out.print("#Choose your option : ");
        String select = scanner.nextLine();
        switch (select) {
            case "1":
                ProductDAL.insertProduct(login);
                break;
            case "2":
                break;
            case "3":
                break;
            case "0":
                System.exit(0);
                break;
            default:
                System.out.println("Not have your select option\nEnter any key to continue...");
                scanner.nextLine();
                break;
        }
    }
}