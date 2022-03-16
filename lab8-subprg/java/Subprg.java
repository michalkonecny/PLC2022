import java.util.Collections;
import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.InputMismatchException;

public class Subprg
{
    // a pure function:
    private static boolean isLetter(char c)
    {
        return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
    }

    // a pure function which uses impure operation:
    private static boolean isLetter2(char c)
    {
        boolean b1 = (c >= 'A' && c <= 'Z');
        c = Character.toUpperCase(c); // variable/parameter assignment is not pure
        boolean b2 = (c >= 'A' && c <= 'Z');
        return b1 || b2;
    }

    private static void testIsLetter(char ch)
    {
        // clumsy, without the use of a function:
        if ((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z'))
        {
            System.out.println("A letter " + ch);
        }

        // function abstraction makes programs more readable and maintainable:
        if (isLetter(ch))
        {
            System.out.println("A letter " + ch);
        }

        if (isLetter2(ch))
        {
            System.out.println("A letter " + ch);
        }
    }

    // does this procedure do anything?
    private static void swapArrays(int[] a, int[] b)
    {
        int [] temp = a;
        b = a;
        a = b;
    }

    private static void testSwap()
    {
        int [] a = new int[] { 1, 1 };
        int [] b = new int[] { 2, 2 };
        swapArrays(a,b);
        System.out.println("a[0] = " + a[0] + ", b[0] = " + b[0]);
    }

    private static void testIpp()
    {
        int i = 3;
        int a = 2 * (i++);
        int b = i;
        System.out.println("a = " + a + ", b = " + b);
    }

    public static void main(String[] args)
    {
        testIsLetter('a');
        // testSwap();
        // testIpp();
    }
}
