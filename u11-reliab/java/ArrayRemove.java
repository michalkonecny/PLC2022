public class ArrayRemove
{
    
    
    public static int arrayRemove(int[] array, int pos)
    {
        // check a precondition:
        assert 0 < pos && pos < array.length :
        		"arrayRemove: pre-condition failed";

        // remember the original array so that we can check post-conditions:
        int[] originalArray = array.clone();
        
        int result;
        
        // the result is the element to be removed:
        result = array[pos];
        
        // shift all elements after pos one position left:
        int i;
        for ( i = pos; i < array.length - 1; i++ )
        {
            assert i >= pos : "arrayRemove: i < pos";
            array[i] = array[i + 1];
//            if ( i < pos )
//            { 
//                System.out.println("arrayRemove: i < pos!");
//                System.exit(0);
//            }
        }
        
        // the last element becomes zero:
        array[i] = 0;

        // check some post-conditions:
        assert array[array.length - 1] == 0:
    		"arrayRemove: post-condition failed";
        
        assert pos + 1 == array.length
        	   || array[pos] == originalArray[pos + 1]:
        	"arrayRemove: post-condition failed";
        
        return result;
    }
    
    // a unit test but in the wrong place - 
    // cannot be easily hidden from other code
    // cannot be easily automatically executed
    private static void testArrayRemove1()
    {
        // a mini unit test
        
        // setup:
        int[] array = new int[] { 4, 3, 2, 1 };
        
        // run the tested method:
        int removeResult = arrayRemove(array, 1);
        
        // state expected results
        int[] arrayAfterRemove = new int[] { 4, 2, 1, 0 };
        int expectedRemoveResult = 3;
        
        // check the expected result:
        assert expectedRemoveResult == removeResult :
            "arrayRemove failed test 1!";

        // check the expected effect on the array:
        for (int i = 0; i < 4; i++ )
        {
            assert array[i] == arrayAfterRemove[i] : 
                "arrayRemove failed test 1!";
        }
        
        System.out.println("arrayRemove passed test 1");
    }
  
    private static void testArrayRemove2()
    {
        // a mini unit test
        
        // setup:
        int[] array = new int[] { 2, 1 };
        
        boolean passed = false;
        
        // run the tested method:
        try 
        {
        	arrayRemove(array, 3); // should raise exception
        }
        catch(Exception e)
        {
            System.out.println("arrayRemove passed test 2");
            passed = true;
        }
        
        if (! passed )
        	System.out.println("arrayRemove failed test 2");
    }
  
    public static void main(String[] args)
    {
        testArrayRemove1();
        testArrayRemove2();
    }
}