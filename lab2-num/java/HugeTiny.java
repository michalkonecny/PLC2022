public class HugeTiny 
{

    public static void keep_incrementing(double initial_time, double step, int number_of_increments){
        double time = initial_time;
        for (int j = 0; j < number_of_increments; j++) {
            time = time + step;
        }
        System.out.format("time after %d increments of 0.1: %.20f\n", number_of_increments, time);
    }

    public static void main(String[] args)
    {
/*
        double a = 1;
        double b = 2;
        double c = -1;
     
        double solution =
            (-b + Math.sqrt(Math.pow(b,2) - 4 * a * c))/(2*a);
        System.out.println(solution);
*/

/*      

        byte i = 120;

        the following will loop forever
        unless you *enable assertions* when executing: java -ea Sqpolyroot
       while ( i < 128 )
       {
            byte iBefore = i;
            i++;
            System.out.println("i = " + i);
            assert i > iBefore : "value in variable i has overflown";
        }
*/

        int i = 2147483647; // 2^31-1, the largest int value
        i = i + 2; // overflow
        System.out.println(i); // prints: -2147483647
        i = 2*i; // overflow
        System.out.println(i); // prints: 2

        double tiny = 1.0E-200;
        double huge = 1.0E+200;

        System.out.println("tiny = " + tiny);
        System.out.println("huge = " + huge);

        System.out.println("tiny * tiny = " + (tiny * tiny));
        System.out.println("huge * huge = " + (huge * huge));
        System.out.println("(huge == tiny + huge) = " + (huge == tiny + huge));

        System.out.println("huge * tiny * huge = " + huge * tiny * huge);
        System.out.println("huge * huge * tiny = " + huge * huge * tiny);
        System.out.println("(huge * huge) * (tiny * tiny) = " + (huge * huge) * (tiny * tiny));
        System.out.println("(huge * huge) - (huge * huge) = " + ((huge * huge) - (huge * huge)));

    }
}