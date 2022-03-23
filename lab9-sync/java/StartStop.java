/**
  Example toy multi-threaded program.

  Three threads communicate via the shared object `state'.
**/
public class StartStop
{
    private enum ST {RUNNING, PAUSED, FINISHING};

    /**
     * A protected instance of enum class ST.
     * The get method blocks the calling thread
     * if state is PAUSED until it is changed.
     * The set method cannot override FINISHING state.
     */
    private static class State
    {
        private ST st = ST.PAUSED;

        /**
         * Return the current state.
         * Block the calling thread if the state is PAUSED
         * until it is not PAUSED.
         *
         * @return current state (but never PAUSED)
         */
        public synchronized ST waitUntilNotPaused()
        throws InterruptedException
        {
            // wait until not paused:
            while( st == ST.PAUSED )
            {
                this.wait();
            }

            return st;
        }

        /**
         * Change state to a new value but
         * <b>only if</b> the original state is not FINISHING.
         * <br/>
         * A FINISHING state is a signal to all threads to terminate
         * and this effect cannot be reversed.
         *
         * @param st = new state value.
         */
        public synchronized void set(ST st)
        {
            // if finishing, do not change state:
            if (this.st != ST.FINISHING )
            {
                this.st = st;
                // notify all who wait for a change of state:
                this.notifyAll();
            }
        }

    }

    /**
     * A global variable pointing at an instance of State.
     * This serves to synchronise all threads in the system.
     */
    private static State state = new State();

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
                while (state.waitUntilNotPaused() != ST.FINISHING)
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

                while (state.waitUntilNotPaused() != ST.FINISHING)
                {
                    state.set(ST.PAUSED);
                    Thread.sleep(1000);
                    state.set(ST.RUNNING);
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

            state.set(ST.RUNNING);
            Thread.sleep(10000); // 10 seconds
            // Thread.sleep(10); // 10 milliseconds
            state.set(ST.FINISHING);
        }
        catch (InterruptedException e) {} // can ignore this exception

        System.out.println("main finishing");
    }

}
