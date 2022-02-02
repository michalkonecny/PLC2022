import java.util.List;
import java.util.LinkedList;
import java.util.Scanner;
import java.util.InputMismatchException;

public class Overflow
{

    private static int getPositiveInteger(String varName)
    {
        boolean haveResult = false;
        int result = 0;
        Scanner stdin = new Scanner(System.in);

        while ( ! haveResult )
        {
            System.out.print("Input a positive integer " + varName + " = ");
            try
            {
                result = stdin.nextInt();
                if(result <= 0)
                {
                    System.out.println("Not a positive integer.");
                }
                else
                {
                    haveResult = true;
                }
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
                    stdin.next();
                    System.out.println("Not a valid number.");
                }
            }
        }

        return result;
    }

    /**
    * Compute the sequence of powers n^0,n^1,...,n^m
    * for a given integer n and natural number m.
    * @param n = a number to raise to the power m
    * @param m = the power (has to be >= 0)
    * @return list containing n^0,n^1,...,n^m
    */
    private static List<Integer> power(int n, int m)
    {
        assert m >= 0 : ("power called with illegal value m = " + m);

        List<Integer> resultList = new LinkedList<Integer>();
        int ns = 1;
        resultList.add(ns);
        for ( int j = 1; j <= m; j++ )
        {
            int next_ns = ns * n;
//             assert ?? : "power: Integer overflow";
            resultList.add(next_ns);
            ns = next_ns;
        }
        return resultList;
    }

    /**
    * Compute the sequence of powers n^0,n^1,...,n^m
    * for a given floating point number n and a natural number m.
    * @param n = a number to raise to the power m
    * @param m = the power (has to be >= 0)
    * @return list containing n^0,n^1,...,n^m
    */
    private static List<Float> power_fp(float n, int m)
    {
        assert m >= 0 : ("illegal power " + m);

        List<Float> resultList = new LinkedList<Float>();
        float ns = 1;
        for ( int j = 1; j <= m; j++ )
        {
            ns = ns * n;
//             assert ?? : "Floating-point overflow";
            resultList.add(ns);
        }
        return resultList;
    }

    /**
    * Compute the series of partial sums of a harmonic series:
    * 1, 1+1/n, 1+1/n+1/n^2, ... , 1+1/n+...+1/n^m
    * @param n = the base of the series, inverted
    * @param m = number of terms of the series to add
    * @return list containing 1, 1+1/n, 1+1/n+1/n^2, ... , 1+1/n+...+1/n^m
    */
    private static List<Float> geom_fp(float n, int m)
    {
        assert m >= 0 : ("illegal power " + m);

        List<Float> resultList = new LinkedList<Float>();

        float ns_inv = 1;
        float geom_sum = 1;
        resultList.add(geom_sum);

        for ( int j = 0; j <= m; j++ )
        {
            ns_inv = ns_inv / n; // update from 1/n^(i-1) to 1/n^i
//             assert ?? : "Floating point underflow";
            geom_sum = ns_inv + geom_sum;
            resultList.add(geom_sum);
        }
        return resultList;
    }

    public static void main(String[] args)
    {
        int n = getPositiveInteger("n");
        int m = getPositiveInteger("m");
        int t = getPositiveInteger("task (1=floating-point n^m; 2=integer n^m; 3=floating-point 1+1/n+1/n^2+...+1/n^m)");

        switch(t)
        {
            case 1: System.out.println(power_fp(n,m)); break;
            case 2: System.out.println(power(n,m)); break;
            case 3: System.out.println(geom_fp(n,m));
        }
    }
}
