import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors; // Java 8 and above

public class PlaylistVars {

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

    public static void main(String[] args) {

        Piece piece1 = new Piece("Moonlight", "C. Arrau", 17 * 60 + 26f);
        Piece piece2 = new Piece("Pathetique", "D. Barenboim", 16 * 60 + 49f);
        Advert advert1 = new Advert(new Product("Bounty", "Mars"), 15.0f);

        List<Item> playlist1 = Arrays.asList(new Item[] { piece1, advert1, piece2 });
        System.out.printf("playlist1 = %s\n", playlist1);

        // calculate the overall length of playlist1:
        Float length1 = 0f; // TASK: related to the scope of variable "length1"
        for (final Item item : playlist1) { // TASK: related to the lifetimes of the variable "item"
            length1 = length1 + item.length_secs;
        }

        System.out.printf("length1 = %.2f", length1);

        System.out.println();
   }
}