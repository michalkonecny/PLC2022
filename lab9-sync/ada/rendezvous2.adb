-- Author: mik
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure rendezvous is

    task A is
        entry Add(N : in Integer; R : out Integer);
    end A;
    
    task body A is
        Sum : Integer := 0;
    begin
        loop
            accept Add(N : in Integer; R : out Integer) 
            do
                Sum := Sum + N;
                R := Sum;
            end; -- the calling task in now released
        end loop;
    end A;
    
    I : Integer;
    Serial : Integer;
    
    procedure Put_I_Serial is
    begin
        Put("I = "); Put(I);
        Put("; Serial = "); Put(Serial); 
        Put_Line("");
    end Put_I_Serial;
    
begin
    A.Add(1,I,Serial); -- I = 1, Serial = 1
    Put_I_Serial;
    A.Add(1,I,Serial); -- I = 2, Serial = 2
    Put_I_Serial;
    A.Add(9,I,Serial); -- I = 11, Serial = 3
    Put_I_Serial;
    A.Add(1,I,Serial); -- I = 12, Serial = 4
    Put_I_Serial;
end rendezvous;
