with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Text_IO;
use Text_IO;

procedure Flow
is

    function Distance(Flow1 : Float; Flow2 : Float)
        return Float
    is
    begin
        return abs(Flow1 - Flow2);
    end Distance;
    
    -- AdjustDistribution attempts to change the values
    -- of the parameters if they are quite close together
    -- so that they are more apart.
    -- Nevertheless, the sum of the values stays the same.
    procedure AdjustDistribution
        (Flow1 : in out Float; Flow2 : in out Float) 
    is
        Average : Float;
    begin
        if Distance(Flow1, Flow2) < 5.0 then
            Average := (Flow1 + Flow2)/2.0;
            Flow1 := Average + 10.0 * (Flow1 - Average) - 1.0;
            Flow2 := Average + 10.0 * (Flow2 - Average) + 1.0;
        end if;
    end AdjustDistribution;
    
begin
    declare
        F1, F2, F3 : Float;
        
        procedure Put_F1F2F3 is
        begin
            Put("F1 = ");
            Put(F1,0,0,0);
            Put("; F2 = ");
            Put(F2,0,0,0);
            Put("; F3 = ");
            Put(F3,0,0,0);
            Put_Line("");
        end Put_F1F2F3;
        
    begin
        F1 := 0.0;
        F2 := 0.0;
        F3 := 1.0;
        
        Put_F1F2F3;
        AdjustDistribution(F1, F2);
        Put_F1F2F3;
        AdjustDistribution(F2, F3);
        Put_F1F2F3;
        AdjustDistribution(F2, F2);  -- this looks bad...what actually happens?
        Put_F1F2F3;
    end;
end Flow;
