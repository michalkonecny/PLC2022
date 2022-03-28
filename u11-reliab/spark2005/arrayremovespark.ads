-- Author: mik

package ArrayRemoveSpark
--# own arrayRemoveCount : Integer;
--# initializes arrayRemoveCount;
is
    type ArrayIndex is range 0..3;
    type IntArray is array(ArrayIndex) of Integer;
    
    procedure ArrayRemove
            (a : in out IntArray;
            pos : in Integer; 
            result : out Integer);
    --# global in out arrayRemoveCount;
    --# derives a      from   a, pos 
    --#       & result from   a, pos
    --#       & arrayRemoveCount from arrayRemoveCount;
    --# pre pos >= Integer(IntArray'First) and pos <= Integer(IntArray'Last);
    --# post 
    --#    (Integer(IntArray'Last) <= pos)
    --#     or 
    --#    (a(ArrayIndex(pos)) = a~(ArrayIndex(pos + 1)));
end ArrayRemoveSpark;
