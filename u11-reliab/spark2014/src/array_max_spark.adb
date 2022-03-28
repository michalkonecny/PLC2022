-- Author: mik

package body Array_Max_Spark 
with SPARK_Mode
is
    
   procedure Array_Max
     (a : in IntArray;
      result : out Integer)
   is
   begin
      result := a(0);
      
      for ix in ArrayIndex loop
         if a(ix) > result then result := a(ix); end if;
      end loop;
   end Array_Max;
   
begin
    Null;
end Array_Max_Spark;
