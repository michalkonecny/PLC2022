with Ada.Text_IO; use Ada.Text_IO;

with ArrayRemove; use ArrayRemove;

procedure ArrayRemoveTest is

    A : IntArray;
    
    procedure Setup is
    begin
        A := (4,3,2,1);
    end Setup;
    
    generic 
        type T is private;
    procedure AssertEqual(value1 : T; value2 : T; message : String);
    
    procedure AssertEqual(value1 : T; value2 : T; message : String) is
    begin
        if (value1 /= value2) then
            Put(message);
        end if;
    end AssertEqual;

    procedure AssertEqualInteger is new AssertEqual(Integer);
    procedure AssertEqualIntArray is new AssertEqual(IntArray);
            
    procedure Test1 is
        Result : Integer;
        ExpectedResult : constant Integer := 2;
        ExpectedFinalArrayState : IntArray := (4,3,1,0);
    begin
        Setup;
        ArrayRemove.ArrayRemove(A,2,Result); -- assign to Result
        AssertEqualInteger(Result, ExpectedResult, "ArrayRemove: wrong result");
        AssertEqualIntArray(A, ExpectedFinalArrayState, "ArrayRemove: wrong effect on array");
    end Test1;
    
    procedure Test2 is
        Result : Integer;
    begin
        Setup;
        ArrayRemove.ArrayRemove(A,5,Result);
        Put("ArrayRemove: did not raise Constraint_Error");
    exception  
        when Constraint_Error =>
            -- Put("ArrayRemove: did raise Constraint_Error");
            null;
    end Test2;
    
begin
    Test1;
    Test2;
end ArrayRemoveTest;
