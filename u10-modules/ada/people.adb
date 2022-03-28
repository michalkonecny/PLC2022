with Text_IO; use Text_IO;

package body People is

    procedure Put_Name(P : Person) is
    begin
        Put(P.name);
    end Put_Name;

    procedure Put_Type(P : Person) is
    begin
        Put("person");
    end Put_Type;

    function New_Person(name : String; age : Natural) return Person is
    begin
        return (name, age);
    end New_Person;

end People;
