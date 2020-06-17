import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Scanner;

public class ProcessMenu {
    static Scanner scanner = new Scanner(System.in);
    static Login login;

    public ProcessMenu(Login log) {
        login = log;
    }

    public ProcessMenu() {

    };

    public static void mainMenu() throws UnsupportedEncodingException, NumberFormatException, SQLException {
        while (true) {
            ClearScreen.clrscr();
            System.out.println("|==================================================|");
            System.out.println("| Hello! Here is Sales Data create by Voi Be Nho^^ |");
            System.out.println("|==================================================|");
            System.out.println("|        Below is options of sales database        |");
            System.out.println("|==================================================|");
            System.out.println("|   1. Insert product information                  |");
            System.out.println("|   2. Update product information                  |");
            System.out.println("|   3. Search product                              |");
            System.out.println("|   4. Show Product                                |");
            System.out.println("|   0. Exit                                        |");
            System.out.println("|==================================================|");
            mainSwitchMenu();
        }
    }

    static void mainSwitchMenu() throws UnsupportedEncodingException, NumberFormatException, SQLException {
        System.out.print("#Choose your option : ");
        String select = scanner.nextLine();
        switch (select) {
            case "1":
                InsertProduct.insertProduct(login);
                break;
            case "2":
                UpdateProduct.updateMenu(login);
                break;
            case "3":
                SearchProduct.SearchMenu(login);
                break;
            case "4":
                ShowProduct.show(login);
                break;
            case "0":
                login.connection.close();
                System.exit(0);
                break;
            default:
                System.out.println("Not have your select option\nEnter any key to continue...");
                scanner.nextLine();
                break;
        }
    }

}