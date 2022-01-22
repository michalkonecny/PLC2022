import java.util.stream.*;

class CircleFP {

  public static void main(String[] args) {
    int size = Integer.parseInt(args[0]);
    CircleFP c = new CircleFP(size);
    System.out.println(c.circleLines());
  }

  public CircleFP(int size) {
    this.size = size;
  }

  private int size;

  private String circleLines(){
    return
      IntStream.rangeClosed(1, size).boxed()
        .map(i -> circleLine(i))
        .collect(Collectors.joining("\n"));
  }

  private String circleLine(int i){
    return
      IntStream.rangeClosed(1, 2*size).boxed()
        .map(jj -> circleChar(i,jj))
        .collect(Collectors.joining());
  }

  private String circleChar(int i, int jj)
  {
    return shouldPaint(i,jj) ? "*" : " ";
  }

  private Boolean shouldPaint(int i, int jj){
    int j = jj/2;
    return shouldPaintS(size,i,j);
  }

  private Boolean shouldPaintS(int s, int i, int j){
    return Math.abs (Math.pow(i,2) + Math.pow(j,2) - Math.pow(s,2)) <= s+1;
  }
}
