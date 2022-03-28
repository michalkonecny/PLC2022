-- Author: mik

package Array_Max_Spark
with SPARK_Mode, Elaborate_Body
is
    type ArrayIndex is range 0..3;
    type IntArray is array(ArrayIndex) of Integer;
    
    procedure Array_Max
     (a : in IntArray;
      result : out Integer)
     with 
     Depends => 
       ((result) => (a)),
     
     Post => 
           (for all i in ArrayIndex => result >= a(i))
           and
           (for some i in ArrayIndex => result = a(i));
end Array_Max_Spark;

