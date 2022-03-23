/**
  Example toy multi-threaded program.

  This preliminary version is incomplete.  It shows how to create threads
  but the threads do not communicate with each other.
**/
public class StartStop0
{

    /**
     * Process that prints numbers 1,2,3... etc
     * to the standard output but can be paused or
     * terminated by setting the global variable state.
     */
    private static class PrintNumbers implements Runnable
    {
        private int n = 1;

        public void run()
        {
            System.out.println("PrintNumbers starting");

            try
            {
                while (true)
                    //recall that waitUntilNotPaused() will return
                    //the current state as soon as it is not PAUSED.
                {
                    System.out.println(n);
                    n++;
                    Thread.sleep(200);
                }
            }
            catch (InterruptedException e) {} // can ignore this exception

            System.out.println("PrintNumbers finishing");
        }
    }

    /**
     * Process that keeps switching the state from PAUSE to RUNNING and vice versa.
     */
    private static class SwitchOnOff implements Runnable
    {

        public void run()
        {
            System.out.println("SwitchOnOff starting");

            try
            {
                Thread.sleep(1000);

                while (true)
                {
                    System.out.println("Pause!");
                    Thread.sleep(1000);
                    System.out.println("Resume!");
                    Thread.sleep(1000);
                }
            }
            catch (InterruptedException e) {} // can ignore this exception

            System.out.println("SwitchOnOff finishing");
        }

    }

    public static void main(String[] args)
    {
        System.out.println("main starting");

        try
        {
            // start other threads:
            new Thread(new PrintNumbers()).start();
            // new Thread(new PrintNumbers()).start();

            new Thread(new SwitchOnOff()).start();

            Thread.sleep(10000); // 10 seconds
        }
        catch (InterruptedException e) {} // can ignore this exception

        System.out.println("main finishing");
    }

}
