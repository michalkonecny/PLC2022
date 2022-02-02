with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
use Ada.Numerics;

procedure RangeTypes is

    -- teach Ada how to print values of the Float type:
    package Float_Elementary_Functions is
         new Generic_Elementary_Functions(Float);
    use Float_Elementary_Functions;

--     a : Float := 1.0;
--     b : Float := 2.0;
--     c : Float := -1.0;
--     solution : Float :=
--         (-b + Sqrt(b ** 2.0 - 4.0 * a * c))/(2.0*a);
    
--     type Dial_Reading is
--         delta 1.0 / 10.0 range 0.0 .. 360.0;
--     D1 : Dial_Reading := 0.0;
--     D2 : Dial_Reading := D1 + 0.1;
--     D3 : Dial_Reading := D1 + 0.01;
--     
    type Meter_Reading is digits 15 range 0.0..1.0;
    R1 : Meter_Reading := 0.5;
    R2 : Meter_Reading := R1 + 0.000000000000001; -- R1 < R2
    
    type Digit is range 0..9;
--     type Digit is mod 10;
    Digit1 : Digit := 0;
    Digit2 : Digit;
    
begin
    Digit2 := Digit1 - 1; -- compiler will warn about this
    Put("Digit2 = ");
    Put(Integer(Digit2));
    Put_Line("");

--        if (R1 < R2)
--           then Put("R1 < R2");
--           else Put("not R1 < R2");
--        end if;
end RangeTypes;
