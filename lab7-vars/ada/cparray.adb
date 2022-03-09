with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Text_IO;
use Text_IO;

procedure CpArray is

    type IntArray is array(1..100) of Integer;
    
    A : IntArray := (others => 0); -- all elements are 0
    B : IntArray := (others => 1); -- all elements are 1
    
begin
    Put("A(1) = "); Put(A(1)); Put_Line("");
    Put("B(1) = "); Put(B(1)); Put_Line("");
    
    Put_Line("A := B;");
    A := B; -- copying all 100 elements
    
    Put("A(1) = "); Put(A(1)); Put_Line("");
    Put("B(1) = "); Put(B(1)); Put_Line("");
    
    Put_Line("A(1) := 7;");
    A(1) := 7; -- no effect on B
    
    Put("A(1) = "); Put(A(1)); Put_Line("");
    Put("B(1) = "); Put(B(1)); Put_Line("");
end CpArray;