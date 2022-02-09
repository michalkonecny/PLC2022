import java.util.Scanner;
import java.util.InputMismatchException;

public class BoolChar
{
    private static int getNumber()
    {
        boolean haveResult = false;
        int result = 0;
        Scanner stdin = new Scanner(System.in);

        while ( ! haveResult )
        {
            System.out.print("Input number: ");
            try
            {
                result = stdin.nextInt();
                haveResult = true;
            }
            catch (InputMismatchException e)
            {
                System.out.println("Not a valid number.");
                stdin.nextLine(); // skip the invalid input
            }
        }

        return result;
    }

    public static void main(String[] args)
    {

        String aS = "a";
        System.out.println(aS + " contains " + aS.toCharArray().length + " chars");
        int aI = Character.codePointAt(aS.toCharArray(), 0);
        System.out.println("code point of " + aS + " is " + aI);

        String cleff = "𝄞";
        System.out.println(cleff + " contains " + cleff.toCharArray().length + " chars");

        int n = getNumber();

        while ( n == 0 )
        {
            System.out.println("Please, input a non-zero number.");
            n = getNumber();
        }

        System.out.println("You typed: " + n);
    }
}
