with Text_IO; use Text_IO;
with People; use People;

procedure UsePeople is
    friend : Person;
begin
    friend := New_Person(name => "John Smith          ", age => 72);
    Put("My friend ");
    Put_Name(friend);
end UsePeople;
