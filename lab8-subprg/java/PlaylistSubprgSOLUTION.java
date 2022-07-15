import java.util.List;

import java.util.Arrays;

public class PlaylistSubprgSOLUTION {

    // --------------------------------------------------
    // -- Record type Product
    // --------------------------------------------------

    public static class Product {
        public final String name;
        public final String brand;

        public Product(String name, String brand) {
            this.name = name;
            this.brand = brand;
        }

        @Override
        public String toString() {
            return String.format("%s by %s", name, brand);
        }
    }

    // --------------------------------------------------
    // -- Union type Item
    // --------------------------------------------------

    public static abstract class Item {
        public final float length_secs;

        public Item(float length_secs) {
            this.length_secs = length_secs;
        }
    }

    public static class Piece extends Item {
        public final String name;
        public final String performer;

        public Piece(String name, String performer, float length_secs) {
            super(length_secs);
            this.name = name;
            this.performer = performer;
        }

        @Override
        public String toString() {
            return String.format("%s by %s (%.1fs)", name, performer, length_secs);
        }
    }

    public static class Advert extends Item {
        public final Product product;

        public Advert(Product product, float length_secs) {
            super(length_secs);
            this.product = product;
        }

        @Override
        public String toString() {
            return String.format("Advert for %s (%.1fs)", product.toString(), length_secs);
        }
    }

    // --------------------------------------------------
    // -- class PlaylistProgress
    // --------------------------------------------------

    public static class PlaylistProgress {
        private final List<Item> items;
        private int index;

        public PlaylistProgress(List<Item> items, int index) {
            this.items = items;
            this.index = index;
        }

        public PlaylistProgress(List<Item> items) {
            this(items, 0);
        }

        public Item getCurrentItem(){
            return items.get(index);
        }

        public void shiftToNextItem() throws EndOfPlaylist {
            if (index+1 >= items.size()) {
                throw new EndOfPlaylist();
            }
            index++;
        }

        public class EndOfPlaylist extends Exception {

        }

        public float getRemainingLength() {
            float result = 0f;
            for (int i = index; i < items.size(); i++) {
                result = result + items.get(i).length_secs;
            }
            return result;
        }
    }

    /**
     * @param playlist
     * @return The length of the first two items in the playlist
     * @throws PlaylistProgress.EndOfPlaylist
     */
    public static float getPlaylistLengthTwoItems(List<Item> playlist) throws PlaylistProgress.EndOfPlaylist {
        PlaylistProgress progress = new PlaylistProgress(playlist);
        // TASK: Is the expression below referentially transparent?
        float result = 0;
        result += progress.getCurrentItem().length_secs;
        progress.shiftToNextItem();
        result += progress.getCurrentItem().length_secs;
        return result;
    }

    private static float twice(float x) {
        return x + x;
    }

    /**
     * @param playlist
     * @return The length of playlist
     */
    public static float getPlaylistLength(List<Item> playlist) {
        float result = 0f;
        for (Item item : playlist) {
            result = result + item.length_secs;
        }
        return result;
    }

    /**
     * Helper class for simulating reference and copy-in/copy-out passing of float
     * parameters.
     */
    public static class FloatHolder {
        public float x;

        public FloatHolder(float x) {
            this.x = x;
        }
    }

    /**
     * Add to the (simulated) reference parameter "result" the overall length of
     * "playlist".
     * 
     * @param playlist
     * @param result
     */
    public static void getPlaylistLength_ReferencePassing(List<Item> playlist, FloatHolder result,
            FloatHolder resultNoAds) {
        for (Item item : playlist) {
            result.x = result.x + item.length_secs;
            if (!(item instanceof Advert)) {
                resultNoAds.x = resultNoAds.x + item.length_secs;
            }
        }
    }

    /**
     * Add to the (simulated) copy-in/copy-out parameter "result" the overall length
     * of "playlist".
     * 
     * @param playlist
     * @param result
     */
    public static void getPlaylistLength_CopyInCopyOutPassing(List<Item> playlist, FloatHolder result,
            FloatHolder resultNoAds) {
        // TASK: complete this method, simulating copy-in/copy-out parameter passing
        float temp1 = result.x;
        float temp2 = resultNoAds.x;
        for (Item item : playlist) {
            temp1 = temp1 + item.length_secs;
            if (!(item instanceof Advert)) {
                temp2 = temp2 + item.length_secs;
            }
        }
        result.x = temp1;
        resultNoAds.x = temp2;
    }

    public static void main(String[] args) {
        // throws PlaylistProgress.EndOfPlaylist {
        // TASK: remove the above throws declaration and handle the exception properly

        Piece piece1 = new Piece("Moonlight", "C. Arrau", 17 * 60 + 26f);
        Piece piece2 = new Piece("Pathetique", "D. Barenboim", 16 * 60 + 49f);
        Advert advert1 = new Advert(new Product("Bounty", "Mars"), 15.0f);

        List<Item> playlist1 = Arrays.asList(piece1, advert1, piece2);

        System.out.printf("playlist1 = %s\n", playlist1);
        System.out.printf("getPlaylistLength(playlist1) = %.2f\n",
                getPlaylistLength(playlist1));
        try {
            System.out.printf("getPlaylistLengthTwoItems(playlist1) = %.2f\n",
                    getPlaylistLengthTwoItems(playlist1));
        } catch (PlaylistProgress.EndOfPlaylist e1) {
            ; // ignore this exception
        }

        System.out.println();

        FloatHolder length1_Ref = new FloatHolder(0f);
        FloatHolder length1NoAds_Ref = new FloatHolder(0f);
        getPlaylistLength_ReferencePassing(playlist1, length1_Ref, length1NoAds_Ref);
        System.out.printf("length1_Ref = %.2f, length1NoAds_Ref = %.2f\n",
                length1_Ref.x, length1NoAds_Ref.x);
                
        System.out.println();

        FloatHolder length1_Copy = new FloatHolder(0f);
        FloatHolder length1NoAds_Copy = new FloatHolder(0f);
        getPlaylistLength_CopyInCopyOutPassing(playlist1, length1_Copy, length1NoAds_Copy);
        System.out.printf("length1_Copy = %.2f, length1NoAds_Copy = %.2f\n",
                length1_Copy.x, length1NoAds_Copy.x);
                
        System.out.println();

        FloatHolder length1A_Ref = new FloatHolder(0f);
        getPlaylistLength_ReferencePassing(playlist1, length1A_Ref, length1A_Ref);
        System.out.printf("length1A_Ref = %.2f\n", length1A_Ref.x);
        FloatHolder length1A_Copy = new FloatHolder(0f);
        getPlaylistLength_CopyInCopyOutPassing(playlist1, length1A_Copy, length1A_Copy);
        System.out.printf("length1A_Copy = %.2f\n", length1A_Copy.x);

        System.out.println();

        PlaylistProgress progress = new PlaylistProgress(playlist1);
        while (true) {
            try {
                float remainingLength = progress.getRemainingLength();
                System.out.printf("Next item = %s \n", progress.getCurrentItem());
                System.out.printf("  remaining play time = %.2f \n", remainingLength);
                progress.shiftToNextItem();
            } catch (PlaylistProgress.EndOfPlaylist e) { // SOLUTION
                break;
            }
        }
    }
}