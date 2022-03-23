-- Author: mik
with start_stop0;
use start_stop0;

with Ada.Text_IO;
use Ada.Text_IO;

procedure start_stop_test0 is
begin
    Put("main starting");
    delay 10.0;
    Put("main finishing");
end start_stop_test0;
