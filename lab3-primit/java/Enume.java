import java.util.Scanner;
import java.util.InputMismatchException;

public class Enume
{
    enum HouseCategory { DETACHED, SEMIDETACHED, TERRACE }

    private static <E extends Enum<E>> E getEnumElement(String elementTypeName, Class<E> elementType)
    {
        boolean haveResult = false;
        E result = null;
        Scanner stdin = new Scanner(System.in);

        while ( ! haveResult )
        {
            System.out.print("Input " + elementTypeName + ": ");
            try
            {
                result = Enum.valueOf(elementType, stdin.next().toUpperCase());
                haveResult = true;
            }
            catch (IllegalArgumentException e)
            {
                System.out.println("Not a valid " + elementTypeName + ".");
                stdin.nextLine(); // skip the invalid input
            }
        }

        return result;
    }

    private static HouseCategory getHouseCategory()
    {
        return getEnumElement("house category", HouseCategory.class);
    }

    public static void main(String[] args)
    {
        HouseCategory hc = getHouseCategory();

        System.out.println("hc = " + hc);

        System.out.println("hc.ordinal() = " + hc.ordinal());

        String code;

        switch (hc)
        {
        case DETACHED:
            code = "D";
            break;
        case SEMIDETACHED:
            code = "S";
            break;
        case TERRACE:
            code = "T";
            break;
        default:
            code = "X";
        }

        System.out.println("code = " + code);
    }
}
