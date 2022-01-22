with Ada.Command_Line;
use Ada.Command_Line;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Text_IO;
use Text_IO;

procedure Circle is

  size : Integer;

  procedure SetSize is
    last : Integer;
  begin
    size := 15;
    -- Get(Argument(1),size,last);
  end SetSize;

  function ShouldPaint(i,jj : Integer) return Boolean;

  function CircleLine(i : Integer) return String is
    result : String(1..(2*size));
  begin
    for jj in 1..(2*size) loop
      if ShouldPaint(i,jj) then
        result(jj) := '*';
      else
        result(jj) := ' ';
      end if;
    end loop;
    return result;
  end CircleLine;

  function ShouldPaintS(s,i,jj : Integer) return Boolean;

  function ShouldPaint(i,jj : Integer) return Boolean is
  begin
    return ShouldPaintS(size,i,jj);
  end ShouldPaint;

  function ShouldPaintS(s,i,jj : Integer) return Boolean is
    j : Integer := jj/2;
  begin
    return abs (i**2 + j**2 - s**2) <= s+1;
  end ShouldPaintS;

begin
  SetSize;
  for i in 1..size loop
    Put_Line(CircleLine(i));
  end loop;
end Circle;
