import java.util.*;

class PlaylistTree {
    public static abstract class Item {
        public abstract int countItems();
    }

    public static class Piece extends Item {
        public final float length_secs;
        public final String name;
        public final String performer;

        public Piece(String name, String performer, float length_secs) {
            this.name = name;
            this.performer = performer;
            this.length_secs = length_secs;
        }

        @Override
        public String toString() {
            return String.format("%s by %s (%.1fs)", name, performer, length_secs);
        }

        @Override
        public int countItems() {
            return 1;
        }
    }

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

    public static class Advert extends Item {
        public final float length_secs;
        public final Product product;

        public Advert(Product product, float length_secs) {
            this.length_secs = length_secs;
            this.product = product;
        }

        @Override
        public String toString() {
            return String.format("Advert for %s (%.1fs)", product.toString(), length_secs);
        }

        @Override
        public int countItems() {
            return 1;
        }
    }

    public static class PlayList extends Item {
        public List<Item> items;

        public PlayList(List<Item> items) {
            this.items = items;
        }

        @Override
        public String toString() {
            return items.toString();
        }

        @Override
        public int countItems() {
            int result = 0;
            // TASK 6.2.(b)


            return result;
        }

        void addItemAtStartDeep(Item item) {
            Item item1 = items.get(0); // get the first item
            if (item1 instanceof PlayList) { // check if it is a sub-list
                // if, so, recurse to this sub-list:
                PlayList item1AsPlayList = (PlayList) item1; // cast to get access to PlayList methods
                item1AsPlayList.addItemAtStartDeep(item); // recursive call
            } else {
                items.add(0, item); // add the item to the beginning of the list
            }
        }
    }

    public static void main(String[] args) {
        // object constructors
        Item piece1 = new Piece("Moonlight", "C. Arrau", 17 * 60 + 26f);
        Item piece2 = new Piece("Pathetique", "D. Barenboim", 16 * 60 + 49f);
        Item advert1 = new Advert(new Product("chocolate", "Yummm"), 15.0f);
        Item advert2 = new Advert(new Product("crisps", "Yummm"), 15.0f);

        List<Item> items1 = new ArrayList<>(Arrays.asList(new Item[] { piece1, piece2 }));
        PlayList playList1 = new PlayList(items1);
        System.out.println("playList1 = " + playList1);
        System.out.println();
        System.out.printf("playList1.countItems() = %d\n", playList1.countItems());
        System.out.println();

        List<Item> items2 = new ArrayList<>(Arrays.asList(new Item[] { playList1, advert1, playList1 }));
        PlayList playList2 = new PlayList(items2);
        System.out.println("playList2 = " + playList2);
        System.out.println();
        System.out.printf("playList2.countItems() = %d\n", playList2.countItems());
        System.out.println();

        System.out.println("calling playList2.addItemAtStartDeep(advert2)");
        System.out.println();
        playList2.addItemAtStartDeep(advert2);
        System.out.println("playList2 = " + playList2);
        System.out.println();
        System.out.printf("playList2.countItems() = %d\n", playList2.countItems());
        System.out.println();

    }

}
