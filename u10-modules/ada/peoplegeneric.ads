generic
    NameSize : Integer; -- for each size, we get a new version of this package
    type T is private; -- for each type, we get a new version of this package
    with procedure Put_T(info : T); -- for each procedure with this signature, we get a new version of this package
package PeopleGeneric is

    type Person is private; 

    function New_Person(name : String; age : Natural; info : T) return Person;
    procedure Put_Name(P : Person);
    procedure Put_Type(P : Person);
    procedure Put_Info(P : Person);

private
    -- We are hiding the Person record structure, making it an abstract data type -- see 10.5.
    type Person is tagged
        record
            name : String(1..NameSize);
            age : Natural;
            info : T;
        end record;
end PeopleGeneric;
