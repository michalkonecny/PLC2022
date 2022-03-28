// here using JUnit 4
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class ArrayRemoveTest 
{

	private int[] array;

	@Before
	public void setUp() throws Exception 
	{
        array = new int[] { 4, 3, 2, 1 };
	}

	/**
	 * Test method for {@link ArrayRemove#arrayRemove(int[], int)}.
	 */
	@Test
	public final void testArrayRemove1() 
	{
        // run the tested method:
        int removeResult = ArrayRemove.arrayRemove(array, 1);
        
        // state expected results
        int expectedRemoveResult = 3;
        int[] arrayAfterRemove = new int[] { 4, 2, 1, 0 };
        
        // check the expected result:
        assertEquals
        	(
        			"arrayRemove failed test 1!",
        			expectedRemoveResult, 
        			removeResult
        	);

        // check the expected effect on the array:
        for (int i = 0; i < 4; i++ )
        {
        	assertEquals
        		(
        				"arrayRemove failed test 1!",
        				array[i], 
        				arrayAfterRemove[i]
        		);
        }
	}

	/**
	 * Test method for {@link ArrayRemove#arrayRemove(int[], int)}.
	 */
	@Test(expected=IndexOutOfBoundsException.class)
	public final void testArrayRemove2() 
	{
        // run the tested method:
		ArrayRemove.arrayRemove(array, 5); // should raise exception
	}
}
