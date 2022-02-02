with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Text_IO;
use Text_IO;

procedure Overflow is

    function GetPositiveInteger(varName : String) return Positive is
        Result : Positive;
        HaveResult : Boolean := False;
        Input : String(1..1024) := (others => ' ');
        Last : Natural;
    begin
    -- function body
        while not HaveResult loop
            Put("Input a positive integer ");
            Put(varName);
            Put(" = ");
            begin
                Get_Line(Input, Last); -- both Input and Last assigned
                Get(Input, Result, Last); -- Result assigned
                HaveResult := True;
            exception when DATA_ERROR | CONSTRAINT_ERROR =>
                Put_Line("Not a positive integer, try again.");
            end;
        end loop;
        return Result;
    end GetPositiveInteger;

    subtype My_Num1 is Integer range 1..1000000;
    type My_Num2 is range 1..1000000;

    function Power(N : in Positive; M : in Natural) return My_Num2 is
        ns : My_Num2 := 1;
    begin
        for I in 1 .. M loop
            ns := ns * My_Num2(N);
        end loop;
        return ns;
    end Power;

    function Power_FP(N : in Float; M : in Natural) return Float is
        ns : Float := 1.0;
    begin
        for I in 1 .. M loop
            ns := ns * N;
        end loop;
        return ns;
    end Power_FP;

    function Geom_FP(N : in Float; M : in Natural) return Float is
        geom_sum : Float := 1.0;
        ns_inv : Float := 1.0;
    begin
        for I in 1 .. M loop
            ns_inv := ns_inv / N;
            geom_sum := geom_sum + ns_inv;
        end loop;
        return geom_sum;
    end Geom_FP;

    N,M,T : Positive;

begin
    N := GetPositiveInteger("n");
    M := GetPositiveInteger("m");
    T := GetPositiveInteger("task (1=floating-point n^m; 2=integer n^m; 3=floating-point 1+1/n+1/n^2+...+1/n^m)");
    case T is
        when 1 => Put(Power_FP(Float(N),M));
        when 2 => Put(Integer(Power(N,M)));
        when 3 => Put(Geom_FP(Float(N),M));
        when others => Put("illegal task");
    end case;
end Overflow;
