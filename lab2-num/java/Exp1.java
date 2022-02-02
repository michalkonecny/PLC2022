import java.util.Scanner;
import java.util.InputMismatchException;

public class Exp1
{
    
    private static int getInteger(String varName)
    {
        boolean haveResult = false;
        int result = 0;
        Scanner stdin = new Scanner(System.in);
        
        while ( ! haveResult )
        {
            System.out.print("Input an integer number " + varName + " = ");
            try
            {
                result = stdin.nextInt();
                haveResult = true;
            }
            catch (InputMismatchException e1)
            {
                try
                {
                    result = Math.round(stdin.nextFloat());
                    haveResult = true;
                    System.out.println("(Rounding to the nearest integer: " + result + ")");
                }
                catch (InputMismatchException e2)
                {
                    System.out.println("Not a valid number.");
                }
            }
        }
        
        return result;
    }
    
    private static float getFloat(String varName)
    {
        boolean haveResult = false;
        float result = 0;
        Scanner stdin = new Scanner(System.in);
        
        while ( ! haveResult )
        {
            System.out.print("Input a floating point number " + varName + " = ");
            try
            {
                result = stdin.nextFloat();
                haveResult = true;
            }
            catch (InputMismatchException e1)
            {
                System.out.println("Not a valid number.");
            }
        }
        
        return result;
    }
    
    private static float exp1(float a, float b)
    {
        float result =
            a + b * (- a + 1/b);
        return result;
    }
  
    public static void main(String[] args)
    {
        System.out.println
           (exp1(getFloat("a"), getFloat("b")));
    }
}