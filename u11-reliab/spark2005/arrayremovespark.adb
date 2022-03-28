-- Author: mik

package body ArrayRemoveSpark is
    
    arrayRemoveCount : Integer := 0;
    
    procedure ArrayRemove
            (a : in out IntArray; 
             pos : in Integer;
             result : out Integer)
    is
        ix : ArrayIndex;
    begin
        ix := ArrayIndex(pos);
        result := a(ix);
        
        for i in ArrayIndex loop
            --# assert
            --#    (Integer(i) <= pos)
            --#     or 
            --#    (a(ArrayIndex(pos)) = a~(ArrayIndex(pos + 1)));
                    if (i > ix and i < ArrayIndex'Last) then
                a(i) := a(i + 1);
            end if;
        end loop;
        
        a(a'last) := 0;
        
        arrayRemoveCount := arrayRemoveCount + 1;
    end ArrayRemove;
    
begin
    null;
end ArrayRemoveSpark;
