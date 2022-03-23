-- Author: Michal Konecny

package playlistmixer is

    -- The API of the package, no executable code here
    -- The remaining details are in file playlistmixer.adb.

    type item_type is record
        id : Integer;
        length : Float;
    end record;

    procedure Put_Item (item : item_type);

    max_items : constant Integer := 10;
    type items_size_type is new Integer range 0..max_items;
    type item_index_type is new Integer range 1..max_items;
    type items_array_type is array(item_index_type) of item_type;

    protected print_semaphore is
        entry Wait_For_Printing_Access;
        procedure Done_Printing;
    private
        printing : Boolean;
    end print_semaphore;

    protected playlist is
        procedure Add(item : item_type);
        procedure Shuffle(i : Integer);
        entry Wait_Until_New_Length(new_length : out Float);
        procedure Put_With_Prefix(prefix : String);
    private
        function Get_length return Float;
        items : items_array_type;
        items_size : items_size_type := 0;
        length : float := 0.0;
        length_changed : Boolean := False;
    end playlist;

    task Adder_task;
    task Mixer_task;
    task Length_change_watcher_task;

end playlistmixer;
