package People is

    type Person is private;
    function New_Person(name : String; age : Natural) return Person;
    procedure Put_Name(P : Person);
    procedure Put_Type(P : Person);

private
    -- We are hiding the Person record structure, making it an abstract data type -- see 10.5.
    type Person is tagged
        record
            name : String(1..20);
            age : Natural;
        end record;
end People;
