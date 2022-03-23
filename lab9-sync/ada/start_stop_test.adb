-- Author: mik
with start_stop;
use start_stop;

with Ada.Text_IO;
use Ada.Text_IO;

procedure start_stop_test is
begin
    Put_Line("main starting");
    print_numbers.Start;
    switch_on_off.Start;
    delay 10.0;
    print_numbers.Finish;
    switch_on_off.Finish;
    Put_Line("main finishing");
end start_stop_test;
