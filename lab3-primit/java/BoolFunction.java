import java.util.Scanner;
import java.util.InputMismatchException;

public class BoolFunction
{

    private static int getInteger()
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
        int j = getInteger();

        System.out.printf("Input = %d, output = %d.\n", j, (j>0)*j + (j<0)*(-j)); // TASK 3.3 (b)

    }
}
