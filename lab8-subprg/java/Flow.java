public class Flow
{
    public static String formatF1F2F3(float f1, float f2, float f3)
    {
        return
          "f1 = " + f1 + ", f2 = " + f2 + ", f3 = " + f3;
    }

    //      The new record type is needed
    //      so that the two results
    //      of adjustDistribution can be returned together.
    //
    //      adjustDistribution is a method inside this
    //      class so that parameter passing is simpler
    private static class FlowPair
    {
        public float a = 0;
        public float b = 0;
        
        public FlowPair(float a, float b)
        {
            this.a = a;
            this.b = b;
        }
        
        public void adjustDistribution()
        {
            if ( Math.abs(a - b) < 5 )
            {
                float average = (a + b)/2;
                a = average + 10 * (a - average) - 1;
                b = average + 10 * (b - average) + 1;
            }
        }
    }

    public static void main(String[] args)
    {
        float f1, f2, f3;
        f1 = 0; f2 = 0; f3 = 1;
        
        System.out.println(formatF1F2F3(f1,f2,f3));
        
        // 8.3.(c) TASK:
        //    Write code that is analogous to
        //    lines 34-39 in flow.cpp except
        //    that it simulates *copy-in copy-out* passing
        //    of formal parameters parameters flow1 and flow2 
        //    to method adjustDistribution.
    }
}
