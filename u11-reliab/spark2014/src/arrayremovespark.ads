-- Author: mik

package ArrayRemoveSpark
with SPARK_Mode, Elaborate_Body,
  Initializes => (arrayRemoveCount)
is
    type ArrayIndex is range 0..3;
    type IntArray is array(ArrayIndex) of Integer;
    
    arrayRemoveCount : Integer;
   
    procedure ArrayRemove
     (a : in out IntArray;
      pos : in Integer; 
      result : out Integer)
     with 
     Global => 
         (In_Out => arrayRemoveCount),
     Depends => 
       ((a, result) => (a,pos),
        arrayRemoveCount => arrayRemoveCount),
     
     Pre => 
       pos >= Integer(IntArray'First)
     and
       pos <= Integer(IntArray'Last)
     and
       arrayRemoveCount < Integer'Last,
         
     Post => 
       pos = Integer(IntArray'Last)
     or else
       a(ArrayIndex(pos)) = a'Old(ArrayIndex(pos + 1));
end ArrayRemoveSpark;
