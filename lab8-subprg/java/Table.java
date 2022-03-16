import java.util.LinkedList;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

public class Table {

    private static abstract class HTMLFragment {
        public abstract int countNodes();
    }

    private static enum HTMLElement {
        TABLE, TBODY, TR, TD
    }

    private static class HTMLFrElement extends HTMLFragment {
        public HTMLElement element;
        public List<HTMLFragment> children;

        public HTMLFrElement(HTMLElement element) {
            this.element = element;
            this.children = new LinkedList<HTMLFragment>();
        }

        public String toString() {
            String result = "";
            result += "<" + element + ">";
            for (HTMLFragment child : children) {
                result += child;
            }
            result += "</" + element + ">";
            return result;
        }

        @Override
        public int countNodes() {
            int result = 1;
            for (HTMLFragment child : children) {
                result += child.countNodes();
            }
            return result;
        }
    }

    private static class HTMLFrText extends HTMLFragment {
        public String text;

        public HTMLFrText(String text) {
            this.text = text;
        }

        public String toString() {
            return text;
        }

        @Override
        public int countNodes() {
            return 1;
        }
    }

    public static HTMLFragment newTextCell(String text){
        HTMLFrElement cell = new HTMLFrElement(HTMLElement.TD);
        cell.children.add(new HTMLFrText(text));
        return cell;
    }

    public static void main(String[] args) {
        HTMLFrElement row =
        new HTMLFrElement(HTMLElement.TR);

        HTMLFragment cell = newTextCell("B");
        // row.children = Arrays.asList(cell, cell, cell);
        row.children = Arrays.asList(newTextCell("B"), newTextCell("B"), newTextCell("B"));
        System.out.println("row = " + row);
        System.out.println("Changing first cell to X.");
        ((HTMLFrText)((HTMLFrElement)(row.children.get(0))).children.get(0)).text = "X";
        System.out.println("row = " + row);


    }
}