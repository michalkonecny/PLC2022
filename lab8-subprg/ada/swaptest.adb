with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;


procedure aliasing is

    N : constant := 3;

    type Vector is array (1..N) of Integer;

    procedure Swap(V1, V2 : in out Vector) is
        Tmp : Vector;
    begin
        Tmp := V1;
        V1 := V2; -- assigns also to the actual parameter
        V2 := Tmp; -- assigns also to the actual parameter
    end Swap;

    A, B : Vector;
begin
    A := (1,1,1);
    B := (2,2,2);
    swap(A,B);
    Put(A(1));
    Put(B(2));
end aliasing;