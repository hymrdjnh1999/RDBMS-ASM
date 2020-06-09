import java.util.Scanner;

public class ShopeeProcedure {
    static Scanner scanner = new Scanner(System.in);

    public static void mainMenu() {
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

    protected static void mainMenuSwitch() {

        System.out.print("      #Choose your option : ");
        String select = scanner.nextLine();
        switch (select) {
            case "1":
                break;
            case "2":
                break;
            case "3":
                break;
            case "0":
                break;
            default:
                System.out.print("Not have your select option");
        }
    }
}