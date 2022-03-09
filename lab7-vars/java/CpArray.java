import java.util.Collections;
import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.InputMismatchException;

public class CpArray
{
    
    public static void main(String[] args)
    {
        int[] a = new int[100];
        int[] b = new int[100];

        // initialise the arrays
        for ( int i = 0; i < 100; i ++)
        {
            a[i] = 0;
            b[i] = 1;
        }

        System.out.printf("a[1] = %d\n", a[1]);
        System.out.printf("b[1] = %d\n", b[1]);

        System.out.println("a=b;");
        a = b; // copy reference, "a" and "b" aliasing
        
        System.out.printf("a[1] = %d\n", a[1]);
        System.out.printf("b[1] = %d\n", b[1]);

        System.out.println("a[1]=7;");
        a[1] = 7; // change the aliased array, b[1] also changes

        System.out.printf("a[1] = %d\n", a[1]);
        System.out.printf("b[1] = %d\n", b[1]);
    }
}