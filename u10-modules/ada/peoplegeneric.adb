with Text_IO; use Text_IO;

package body PeopleGeneric is

    procedure Put_Name(P : Person) is
    begin
        Put(P.name);
    end Put_Name;

    procedure Put_Info(P : Person) is
    begin
        Put_T(P.info);
    end Put_Info;

    procedure Put_Type(P : Person) is
    begin
        Put("person");
    end Put_Type;

    function New_Person(name : String; age : Natural; info : T) return Person is
    begin
        return (name, age, info);
    end New_Person;

end PeopleGeneric;
