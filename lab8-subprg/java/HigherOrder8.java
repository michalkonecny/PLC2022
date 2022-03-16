import java.util.Collections;
import java.util.List;
import java.util.Arrays;
import java.util.stream.Stream; // Java 8 and above
import java.util.stream.Collectors; // Java 8 and above

public class HigherOrder8
{
    private static interface String2Boolean
    {
        Boolean execute(String s);
    }

    /* The following "lambda" expression
       creates an anonymous class that implements String2Boolean.
       The given expression is used in the body of the "execute" method
       as the value to be returned by the method.
       The "lambda" expression also creates one instance of the new anonymous class.
    */
    private static String2Boolean isLong =
      (String s) // header of the anonymous method
                 // the type String is optional - Java can infer it
      -> // separator of head and body, the syntax of "lambda" expression
      s.length() > 10;  // the body of the method
                        // "return" is inserted automatically in the body
    private static String2Boolean startsWithHi =
      (s) -> s.substring(0,2).equals("hi");
      // a "lambda" expression - see above for an explanation

    private static List<String> filterStrings
        (String2Boolean test,
         List<String> list)
    {
       return list.stream().filter(test::execute).collect(Collectors.toList());
    }

    private static List<String> filterStringsTwo
        (String2Boolean test1,
         String2Boolean test2,
         List<String> list)
    {
       return list.stream().filter((s) -> test1.execute(s) && test2.execute(s)).collect(Collectors.toList());
    }

    public static void main(String[] args)
    {
        // create a list of strings to play with
        List<String> strings =
          Arrays.asList("hi dear", "referential", "hippie", "hilariousness");

        System.out.println("all: " + strings);

        // create a list of function to show it is possible:
        List<String2Boolean> fns =
          Arrays.asList(isLong, startsWithHi, isLong);

        // filter long strings out:
        List<String> longStrings =
            filterStrings(isLong, strings);
        System.out.println("long ones: " + longStrings);

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
                (s) -> isLong.execute(s) && startsWithHi.execute(s),
                strings
            );
        System.out.println("hi+long ones (2): " + hiLongStrings2);


    }
}
