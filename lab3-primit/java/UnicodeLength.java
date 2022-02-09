public class UnicodeLength
{

    private static String s1;
    private static String s2;

    static
    {
        s1 = "\u5B66\uD800\uDF30";
        s2 = "\u0068\u0069\u0021";
    }

    private static int unicodeLength(String s)
    {
        return 0; // TODO
    }

    public static void main(String[] args)
    {
        System.out.println(s1 + " contains " + unicodeLength(s1) + " Unicode characters."); // should be 2
        System.out.println(s2 + " contains " + unicodeLength(s2) + " Unicode characters."); // should be 3
    }

}