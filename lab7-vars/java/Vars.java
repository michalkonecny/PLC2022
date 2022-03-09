import java.util.Collections;
import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.InputMismatchException;

public class Vars
{


    private static class A { public int a_c; }
    private static class B extends A { public int b_c; }

    public static void main(String[] args)
    {
        B b = new B();
        A a;
        a = b;
        // b = a; // ERROR

        if ( a == b )
        {
            // System.out.println("" + i); // ERROR, i has linear scope
            int i = 1;
            System.out.println("" + i); // OK
        }

        // System.out.println("" + i); // ERROR, scope of i ends on the above }

        for(int i = 0; i < 2; i++){
            // for(int i = 0; i < 3; i++){ // error: duplicate variable
            //     System.out.println("hi!");
            // }
            for(int j = 0; j < 3; j++){
                System.out.println("hi!");
            }
            for(int j = 0; j < 3; j++){
                System.out.println("hi!");
            }
        }
    }
}
