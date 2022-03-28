-- Author: mik

package ArrayRemove is
    
    type ArrayIndex is range 0..3;
    type IntArray is array(ArrayIndex) of Integer;
    
    procedure ArrayRemove
            (a : in out IntArray;
            pos : in Integer; 
            result : out Integer);
    
end ArrayRemove;
