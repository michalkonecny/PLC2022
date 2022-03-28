public class A<E>
{
    private E e;
    // private E e = new E(); // BAD

    public <T> void test(T t) { System.out.println("e = " + e + "; t = " + t ); }

    public static void main(String[] args){
      A<Integer> a1 = new A<>();
      A<String> a2 = new A<>();

      a1.e = 1;
      a1.test("hi!");
      a1.test(0);
    }
}
