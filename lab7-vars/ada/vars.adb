with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Text_IO;
use Text_IO;

procedure Vars is

    procedure Test1 is
        type BInt1 is new Integer;
        subtype BInt2 is Integer;
        B1 : BInt1 := 1;
        B2 : BInt2 := 1;
        A : Integer;
        F : Float;
    begin
--         A := B1; -- illegal - Ada uses "name equivalence"
        A := B2; -- "subtype" here created a type synonym
        A := 1;
        F := Float(A); -- type conversion has to be explicit
    end Test1;
    
    procedure Test2 is
        type ARange is new Integer range 1..10;
        --type BRange is range 1..7;
        subtype BRange is ARange range 1..7;
        B_R : BRange := 6;
        A_R : ARange;
    begin
        A_R := B_R; -- ok, B is subtype of A
        A_R := A_R + 1;
        B_R := A_R; -- Ada resorts to dynamic type checking
    end Test2;
    
    procedure Test3 is
        type ARange is new Integer range 1..10;
        type BRange is new Integer range 1..7;
        --subtype BRange is ARange range 1..7;
        B_R : BRange := 6;
        A_R : ARange;
    begin
        A_R := ARange(B_R); -- safe type cast
        A_R := A_R + 1;
        B_R := BRange(A_R); -- Ada resorts to dynamic type checking
    end Test3;
    
begin
    Test1;
    Test2;
    Test3;
end Vars;
