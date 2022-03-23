-- Author: Michal Konecny
with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Task_Identification;  
use Ada.Task_Identification;

with playlistmixer;
use  playlistmixer;

procedure playlistmixer_test is
begin
    -- avoid threads printing one over another:
    print_semaphore.Wait_For_Printing_Access;
    Put_Line("main starting");
    print_semaphore.Done_Printing;

    delay 4.0;

    print_semaphore.Wait_For_Printing_Access;
    Put_Line("main finishing");
    print_semaphore.Done_Printing;
    
    Abort_Task (Current_Task); 
    -- This is a hack to stop the program quickly.
    -- Without it the program will wait for the
    -- other threads forever.
    -- A better solution would be to signal these
    -- threads explicitly so that they terminate naturally.

end playlistmixer_test;
