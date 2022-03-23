-- Author: Michal Konecny
with Ada.Text_IO;
use  Ada.Text_IO;
with Ada.Float_Text_IO;
use  Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
use  Ada.Integer_Text_IO;

package body playlistmixer is

    -- The "body" of the package, only the executable code here.
    -- Definitions of types and other details are in file playlistmixer.ads.

    -- A mini auxiliary protected object to avoid threads printing one over another
    protected body print_semaphore is
        entry Wait_For_Printing_Access when not printing
        is begin
            printing := True;
        end Wait_For_Printing_Access;
        procedure Done_Printing is
        begin
            printing := False;
        end Done_Printing;
    end print_semaphore;

    protected body playlist is
        procedure Add(item : item_type) is
        begin
            items_size := items_size + 1;
            items(item_index_type(items_size)) := item;
            length := length + item.length;
            length_changed := True;
        end Add;

        procedure Shuffle(i : Integer) is
            temp : items_array_type := items;
            r : item_index_type;
            ropp : item_index_type;
        begin
            if items_size > 1 then
                r := item_index_type(1 + (i mod (Integer(items_size) - 1)));
                ropp := item_index_type(items_size) - r;
                for j in 1..r loop
                    items(j + ropp) := temp(j);
                end loop;
                for j in (r+1)..item_index_type(items_size) loop
                    items(j-r) := temp(j);
                end loop;
            end if;
        end Shuffle;

        function Get_length return Float is
        begin
            return length;
        end Get_length;

        entry Wait_Until_New_Length(new_length : out Float) 
        when length_changed is
        begin
            new_length := length;
            length_changed := False;
        end Wait_Until_New_Length;

        procedure Put_With_Prefix(prefix : String) is
        begin
            Put(prefix);
            Put("[");
            for j in 1..item_index_type(items_size) loop
                if j > 1 then Put(", "); end if;
                Put_Item(items(j));
            end loop;
            Put("] (");
            Put(length, 0, 2, 0);
            Put_Line(")");
        end Put_With_Prefix;
    end playlist;

    procedure Put_item (item : item_type) is
    begin
        Put("Item ");
        Put(item.id, 0);
        Put(" (");
        Put(item.length, 0, 2, 0);
        Put(")");
    end Put_item;

    task body Adder_task is
        next_id : Integer := 1;        
    begin
        loop
            playlist.Add ((id => next_id, length => Float(13 + 7*(next_id mod 4))));
            print_semaphore.Wait_For_Printing_Access;
            playlist.Put_With_Prefix("adder: ");
            print_semaphore.Done_Printing;
            next_id := next_id + 1;
            delay 1.0;
        end loop;
    end Adder_task;

    task body Mixer_task is
        i : Integer := 1;
    begin
        loop
            playlist.Shuffle(i);
            print_semaphore.Wait_For_Printing_Access;
            playlist.Put_With_Prefix("mixer: ");
            print_semaphore.Done_Printing;
            i := i + 1;
            delay 1.0/3.0;
        end loop;
    end Mixer_task;

    task body Length_change_watcher_task is
        length : Float := 0.0;
    begin
        loop
            playlist.Wait_Until_New_Length(length);
            print_semaphore.Wait_For_Printing_Access;
            Put_Line("length updated");
            print_semaphore.Done_Printing;
        end loop;
    end Length_change_watcher_task;

end playlistmixer;
