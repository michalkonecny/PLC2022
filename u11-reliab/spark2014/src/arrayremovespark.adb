-- Author: mik

package body ArrayRemoveSpark 
with SPARK_Mode
is
    
   procedure ArrayRemove
     (a : in out IntArray; 
      pos : in Integer;
      result : out Integer)
   is
      ix : ArrayIndex;
   begin
      ix := ArrayIndex(pos);
      result := a(ix);
      
      for i in ix .. (ArrayIndex'Last - 1) loop
         a(i) := a(i + 1);
      end loop;
        
      a(a'last) := 0;
        
      arrayRemoveCount := arrayRemoveCount + 1;
   end ArrayRemove;
   
begin
    arrayRemoveCount := 0;    
end ArrayRemoveSpark;
