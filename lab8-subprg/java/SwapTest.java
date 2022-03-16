import java.util.Collections;
import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.InputMismatchException;

public class SwapTest
{
    // bogus swap in Java:
    private static void swap(int[] v1, int[] v2)
    {
        int[] temp = v1;
        v2 = v1; // changes formal parameter but not actual parameter
        v1 = temp;
    }
    
    public static void main(String[] args)
    {
        int[] a = new int[] { 1,1,1 };
        int[] b = new int[] { 2,2,2 };
        swap(a,b); // does nothing!
        System.out.println("a[0] = " + a[0]);
        System.out.println("b[0] = " + b[0]);
    }
}