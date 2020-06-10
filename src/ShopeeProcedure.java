import java.io.UnsupportedEncodingException;
import java.util.Scanner;

public class ShopeeProcedure {
    static Scanner scanner = new Scanner(System.in);
    static Login login;

    public ShopeeProcedure(Login log) {
        login = log;
    }

    public ShopeeProcedure() {

    };

    public static void mainMenu() throws UnsupportedEncodingException {
        while (true) {
            App.clrscr();
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
            mainSwitchMenu();
        }
    }

    static void updateMenu() throws UnsupportedEncodingException {
        App.clrscr();
        System.out.println("|==================================================|");
        System.out.println("| Update Product Infomation with Product ID        |");
        System.out.println("|==================================================|");
        System.out.println("| 1. Update Name , Price, Status                   |");
        System.out.println("| 2. Update Name                                   |");
        System.out.println("| 3. Update Price                                  |");
        System.out.println("| 4. Update Status                                 |");
        System.out.println("|==================================================|");
        System.out.print("#Enter your select : ");
        updateSwitchMenu();
    }

    static void mainSwitchMenu() throws UnsupportedEncodingException {
        System.out.print("#Choose your option : ");
        String select = scanner.nextLine();
        switch (select) {
            case "1":
                ProductDAL.insertProduct(login);
                break;
            case "2":
                updateMenu();
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

    static void updateSwitchMenu() throws UnsupportedEncodingException {

        String select = scanner.nextLine();
        switch (select) {
            case "1":
            case "2":
            case "3":
            case "4":
                ProductDAL.updateProductInfo(login, Integer.parseInt(select));
                break;
            case "0":
                mainMenu();
                break;
            default:
                System.out.println("Not have your select option\nEnter any key to continue...");
                scanner.nextLine();
                break;
        }
    }
}