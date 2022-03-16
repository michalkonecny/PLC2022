with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;


procedure aliasing is

    N : constant := 3;

    type Vector is array (1..N) of Integer;

    procedure Add_Vectors (V1, V2 : in Vector; V_Sum : out Vector) is
    begin
        for I in V_Sum'Range loop -- for every index of the array
            V_Sum(I) := V1(I) + V2(I); -- add the i'th elements
        end loop;
    end Add_Vectors;

    procedure Add_Vectors (V1, V2, V3 : in Vector; V_Sum : out Vector) is
    begin
        Add_Vectors(V1, V2, V_Sum); -- add first two
        Add_Vectors(V_Sum, V3, V_Sum); -- add the third
        -- beware: if V_Sum and V3 are aliasing, V3 is overwritten
        --         in the first addition with the sum of V1 and V2!
    end Add_Vectors;

    -- the above versions may work if the compiler uses copy parameter passing
    -- (GNAT uses reference parameter passing and thus it fails)
    
    -- the following version will work irrespective of the passing method:

    procedure Add_Vectors_Corrected (V1, V2, V3 : in Vector; V_Sum : out Vector) is
        Temp : Vector;
    begin
        Add_Vectors(V1, V2, Temp); -- add first two
        Add_Vectors(Temp, V3, V_Sum); -- add the third
    end Add_Vectors_Corrected;

    type Vector_R is tagged record
            -- tagged records are tagged with intrinsic type information
            -- and are always stored by reference (almost like
            -- Java objects)
        v : Vector;
    end record;
    
    -- the following version will always use passing by reference:

    procedure Add_Vectors_R (V1, V2 : in Vector_R; V_Sum : out Vector_R) is
    begin
        for I in V_Sum.v'Range loop -- for every index of the array
            V_Sum.v(I) := V1.v(I) + V2.v(I); -- add the i'th elements
        end loop;
    end Add_Vectors_R;

    procedure Add_Vectors_R (V1, V2, V3 : in Vector_R; V_Sum : out Vector_R) is
    begin
        Add_Vectors_R(V1, V2, V_Sum); -- add first two
        Add_Vectors_R(V_Sum, V3, V_Sum); -- add the third
        -- beware: if V_Sum and V3 are aliasing, V3 is overwritten
        --         in the first addition with the sum of V1 and V2!
    end Add_Vectors_R;

    A,B,C : Vector;
    AR,BR,CR : Vector_R;

begin
    A := (1,1,1);
    B := (2,2,2);
    C := (4,4,4);
    
    -- thy to add the three and store the result in C
    Add_Vectors(A,B,C,C);
    
    -- print the first elements of the vectors to see what happened
    Put("Using Vector: ");
    Put(A(1)); -- should be 1
    Put(B(1)); -- should be 2
    Put(C(1)); -- should be 1+2+7 = 10 but may be 1+2+(1+2) = 6
    Put_Line("");
    
    -- now try the same with guaranteed reference parameter passing
    A := (1,1,1);
    B := (2,2,2);
    C := (4,4,4);
    
    AR := (v => A);
    BR := (v => B);
    CR := (v => C);
    
    -- thy to add the three and store the result in CR
    Add_Vectors_R(AR,BR,CR,CR);
    -- print the first elements of the vectors to see what happened
    Put("Using Vector_R: ");
    Put(AR.v(1)); -- should be 1
    Put(BR.v(1)); -- should be 2
    Put(CR.v(1)); -- should be 1+2+7 = 10 but is 1+2+(1+2) = 6
    Put_Line("");
end aliasing;
