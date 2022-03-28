with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with PeopleGeneric;

procedure UsePeopleGeneric is
    procedure Put_Integer(i : Integer) is
    begin
        Put(i,0);
    end Put_Integer;

    package People20 is new PeopleGeneric(NameSize => 20, T => Integer, Put_T => Put_Integer);
    use People20;
    friend : Person;
begin
    friend := New_Person(name => "John Smith          ", age => 72, info => 1111);
    Put("My friend ");
    Put_Name(friend);
    Put(" info = ");
    Put_Info(friend);
end UsePeopleGeneric;
