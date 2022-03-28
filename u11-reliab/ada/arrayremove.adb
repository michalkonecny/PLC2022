-- Author: mik

package body ArrayRemove is

    procedure ArrayRemove
        (a : in out IntArray; 
         pos : in Integer; 
         result : out Integer)
    is
        ix : ArrayIndex := ArrayIndex(pos);
                            -- type casting
    begin
        result := a(ix);
                
                
        for i in ix..(a'last - 1) loop
        -- iterate i from ix 
        -- to the second last index of the array
            a(i) := a(i + 1);
        end loop;
        
        a(a'last) := 0; -- set the last element of the array
    end ArrayRemove;
    
begin
	null;
end ArrayRemove;
