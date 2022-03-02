import java.util.LinkedList;
import java.util.List;
import java.util.ArrayList;

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

    private static HTMLFragment makeTable(String[][] rows) {
        HTMLFrElement table = new HTMLFrElement(HTMLElement.TABLE);

        HTMLFrElement tbody = new HTMLFrElement(HTMLElement.TBODY);
        table.children.add(tbody);

        for (String[] row : rows) {
            HTMLFrElement tr = new HTMLFrElement(HTMLElement.TR);
            tbody.children.add(tr);

            for (String cellValue : row) {
                HTMLFrElement td = new HTMLFrElement(HTMLElement.TD);
                tr.children.add(td);

                td.children.add(new HTMLFrText(cellValue));
            }
        }

        return table;
    }

    public static void main(String[] args) {
        HTMLFragment htmlBoard1 = makeTable(new String[][] { { "X", "X" },
                { "O", "B" } });

        System.out.println("htmlBoard1.countNodes() = " + htmlBoard1.countNodes());

        // HTMLFrElement row =
        // new HTMLFrElement(HTMLElement.TR);
        // HTMLFrElement cell =
        // new HTMLFrElement(HTMLElement.TD);
        // cell.children.add(new HTMLFrText("B"));
        // row.children.add(cell);
        // row.children.add(cell);
        // row.children.add(cell);
        // System.out.println("row.countNodes() = " + row.countNodes());
    }
}