-- Author: mik
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

package body start_stop is

    protected body state is
        procedure Set(new_st : ST) is
        begin
            cur_st := new_st;
        end Set;
        
        entry WaitUntilNotPaused when cur_st /= PAUSED is
        begin
            null;
        end WaitUntilNotPaused;
    end state;
    
    task body print_numbers is
        n : Integer := 0;
    begin
        -- wait for start signal
        accept Start; -- rendezvous
        Put_Line("print_numbers starting");
        loop
            -- wait till not paused
            state.WaitUntilNotPaused;
            -- print n
            Put(n); Put_Line("");
            -- increment n
            n := n + 1;
            -- delay for 200 ms and listen for finish signal
            select
                accept Finish; -- rendezvous
                exit; -- get out of the loop
            or
                delay 0.2; -- or timeout
            end select;
        end loop;
        Put_Line("print_numbers finishing");
    end print_numbers;
    
    task body switch_on_off is
    begin
        accept Start;
        Put_Line("switch_on_off starting");
        loop
            state.set(RUNNING);
            select
                accept Finish;
                exit;
            or
                delay 1.0;
            end select;
            state.set(PAUSED);
            select
                accept Finish;
                exit;
            or
                delay 1.0;
            end select;
        end loop;
        Put_Line("switch_on_off finishing");
    end switch_on_off;
    
begin
	null;
end start_stop;
