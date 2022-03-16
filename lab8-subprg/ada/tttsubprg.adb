with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;


procedure tttSubprg is

    type Cell_Value_T is
        (X, O, B);

    -- function to help formatting CellValues
    function Format_Cell_Value(cell_value : Cell_Value_T) return String
    is begin
        case cell_value is
            when X => return "X";
            when O => return "O";
            when B => return ".";
        end case;
    end Format_Cell_Value;

    type Row_Num_T is new Integer range 1..3;
    type Col_Num_T is new Integer range 1..3;

    type Row_T is
        array (Col_Num_T) of Cell_Value_T; 
        -- indices are elements of type Col_Num_T (ie numbers 1..3)
        -- elements are cell values
    type Board_T is
        array (Row_Num_T) of Row_T; 
        -- indices are elements of type Row_Num_T (ie numbers 1..3)
        -- elements are rows

    -- display a board to the terminal:
    procedure Put_Board(board : Board_T) is
        -- Put_Row is an inner procedure - visible only inside Put_Board
        -- display a row to the terminal:
        procedure Put_Row(row : Row_T) is
        begin
            for col_n in Col_Num_T loop -- for each value in the type Col_Num_T
                Put(Format_Cell_Value(row(col_n)));
            end loop;
            Put_Line("");
        end Put_Row;
    begin
        for row_n in Row_Num_T loop -- for each value in the type Row_Num_T
            Put_Row(board(row_n));
        end loop;
    end Put_Board;
    
    -- update a cell value in a board:
    procedure Update_Board
        (board : in out Board_T; 
         row_n : Row_Num_T; -- "in" by default
         col_n : Col_Num_T; -- "in" by default
         cell_value : in Cell_Value_T;
         old_cell_value : out Cell_Value_T)
    is
    begin
        old_cell_value := board(row_n)(col_n);
        board(row_n)(col_n) := cell_value;
    end Update_Board;
    
    board1 : Board_T;
    old_cell_value : Cell_Value_T;
begin
    board1 := ((X,X,O),(O,B,X),(O,B,B));
    Put_Board(board1);
    Update_Board(board1, 2, 2, X, old_cell_value);
    -- alternative with explicit formal - actual parameter mapping
    Update_Board(board => board1, row_n => 2, col_n => 2, 
        cell_value => X, old_cell_value => old_cell_value);
    Put_Board(board1);
end tttSubprg;

