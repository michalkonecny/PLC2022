import java.util.Collections;
import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;

public class HigherOrder
{
    private static interface String2Boolean
    {
        Boolean execute(String s);
    }

    private static class IsLong implements String2Boolean
    {
        public Boolean execute(String s)
        {
            return s.length() > 10;
        }
    }

    private static class StartsWithHi implements String2Boolean
    {
        public Boolean execute(String s)
        {
            return s.substring(0,2).equals("hi");
        }
    }

    private static List<String> filterStrings
        (String2Boolean test,
         List<String> list)
    {
        List<String> result = new ArrayList<String>();
        for ( String element : list )
        {
            if ( test.execute(element) )
            {
                result.add(element);
            }
        }
        return result;
    }

    private static List<String> filterStringsTwo
        (String2Boolean test1,
         String2Boolean test2,
         List<String> list)
    {
        List<String> result = new ArrayList<String>();
        for ( String element : list )
        {
            if ( test1.execute(element) && test2.execute(element) )
            {
                result.add(element);
            }
        }
        return result;
    }

    public static void main(String[] args)
    {


        // create a list of strings to play with
        List<String> strings =
          Arrays.asList("hi dear", "referential", "hippie", "hilariousness");

        System.out.println("all: " + strings);

        // create a list of function to show it is possible:
        List<String2Boolean> fns =
          Arrays.asList(new IsLong(), new StartsWithHi(), new IsLong());
            // the content of fns is now analogous to Haskell's
            // [isLong, startsWithHi, isLong]

        // create a function object that can check length
        final String2Boolean isLong = new IsLong();

        // filter long strings out:
        List<String> longStrings =
            filterStrings(isLong, strings);
        System.out.println("long ones: " + longStrings);

        // create a function object that can check prefix "hi"
        final String2Boolean startsWithHi = new StartsWithHi();

        // filter out strings starting with "hi":
        List<String> hiStrings =
            filterStrings(startsWithHi, strings);
        System.out.println("hi ones: " + hiStrings);

        // filter out long strings that start with "hi"
        List<String> hiLongStrings =
            filterStringsTwo(startsWithHi, isLong, strings);
        System.out.println("hi+long ones: " + hiLongStrings);

        // filter out long strings that start with "hi"
        // using a dynamically constructed tester function:
        List<String> hiLongStrings2 =
            filterStrings
            (
                new String2Boolean()
                // instance of anonymous class implementing String2Boolean
                { // definition of the anonymous class
                    public Boolean execute(String s)
                    {
                        return isLong.execute(s) && startsWithHi.execute(s);
                    }
                },
                strings
            );
        System.out.println("hi+long ones (2): " + hiLongStrings2);


    }
}
