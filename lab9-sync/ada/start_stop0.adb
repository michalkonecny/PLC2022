-- Author: mik
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

package body start_stop0 is

    task body print_numbers is
        n : Integer := 0;
    begin
        Put_Line("print_numbers starting");
        loop
            -- print n
            Put(n); Put_Line("");
            -- increment n
            n := n + 1;
            -- delay for 200 ms:
            delay 0.2; -- or timeout
        end loop;
        Put_Line("print_numbers finishing");
    end print_numbers;

    task body switch_on_off is
    begin
        Put_Line("switch_on_off starting");
        loop
            Put("Resume!");
            delay 1.0;
            Put("Pause!");
            delay 1.0;
        end loop;
        Put_Line("switch_on_off finishing");
    end switch_on_off;

begin
	null;
end start_stop0;
