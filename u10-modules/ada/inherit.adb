with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Text_IO;
use Text_IO;

procedure Inherit is

    type Person is tagged 
        record
            name : String(1..5);
            age : Natural;
        end record;
    
    type Student is new Person with
        record
            year : Natural;
        end record;
    
    type Employee is new Person with
        record
            salary : Natural;
        end record;
    
    procedure Put_Name(P : Person'Class) is
    begin
        Put(P.name);
    end Put_Name;
    
    procedure Put_Type(P : Person) is
    begin
        Put("person");
    end Put_Type;
    
    procedure Put_Type(P : Student) is
    begin
        Put("student");
    end Put_Type;
    
    S : Student := ("bob  ",21, 2);
    P : Person := ("joe  ", 8);
    E : Employee := ("rick ", 31, 50000);
begin
    Put_Name(E); Put_Line("");
    -- Put_Type(E); Put_Line(""); -- ERROR
    Put_Type(S); Put_Line("");
    Put_Type(P); Put_Line("");
end Inherit;
