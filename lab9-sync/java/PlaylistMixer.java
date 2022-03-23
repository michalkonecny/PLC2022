import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class PlaylistMixer {

    private static class Item {

        public final int id;
        public final float length;

        public Item(int id, float length) {
            this.id = id;
            this.length = length;
        }

        @Override
        public String toString() {
            return String.format("Item %d (%.2f)", id, length);
        }
    }

    private static class Playlist {

        private List<Item> items = new ArrayList<>();
        private float length = 0f;

        public synchronized void add(Item item) { 
            // TASK: complete


        }

        public synchronized void shuffle(int i) {
            if (items.size() > 1) {
                int r = 1 + (i % (items.size() - 1));
                List<Item> newItems = new LinkedList<>();
                newItems.addAll(items.subList(r, items.size()));
                newItems.addAll(items.subList(0, r));
                items = newItems;
                notifyAll();
            }
        }

        public synchronized void printWithPrefix(String prefix) {
            System.out.printf("%s%s (%.2f)\n", prefix, items, length);
        }

        public synchronized float waitUntilNewLength(float current_length) { 
            // TASK: complete
            sleep(100); // remove this line




            return length;
        }
    }

    /**
     * A global variable pointing at an instance of Playlist.
     * This object is shared among several threads.
     */
    private static Playlist playlist = new Playlist();

    private static void sleep(int millis) {
        try {
            Thread.sleep(millis);
        } catch (InterruptedException e) {
            // deliberately ignoring
        }
    }

    private static class Adder implements Runnable {
        public void run() {
            int id = 1;

            while (true) {
                playlist.add(new Item(id, 13 + 7 * (id % 4)));
                playlist.printWithPrefix("adder: ");
                sleep(1000);
                id = id + 1;
            }
        }
    }

    private static class Mixer implements Runnable {
        public void run() {
            int i = 1;

            while (true) {
                playlist.shuffle(i);
                playlist.printWithPrefix("mixer: ");
                sleep(1000/3);
                i = i + 1;
            }
        }
    }

    private static class Length_Change_Watcher implements Runnable {
        public void run() {
            float current_length = 0f;
            while (true) {
                current_length = playlist.waitUntilNewLength(current_length);
                System.out.println("length changed");
            }
        }
    }

    public static void main(String[] args) {
        System.out.println("main starting");

        try {
            // start other threads:
            new Thread(new Adder()).start();
            new Thread(new Mixer()).start();
            new Thread(new Length_Change_Watcher()).start();

            Thread.sleep(4000); // 4 seconds
        } catch (InterruptedException e) {
        } // can ignore this exception

        System.out.println("main finishing");
        System.exit(0);
    }

}
