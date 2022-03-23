-- Author: mik

package start_stop is

    type ST is  (RUNNING, PAUSED);
    
    protected state is
        procedure Set(new_st : ST);
        entry WaitUntilNotPaused;
    private
        cur_st : ST;
    end state;
    
    task print_numbers is
        entry Start;        
        entry Finish;
    end print_numbers;
    
    task switch_on_off is
        entry Start;
        entry Finish;
    end switch_on_off;
    
end start_stop;
