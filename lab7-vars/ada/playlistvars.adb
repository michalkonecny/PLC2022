with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;     use Ada.Float_Text_IO;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure PlayListVars is

    type Product_Type is record
        name : Unbounded_String;
        brand : Unbounded_String;
    end record;

    procedure Put_Product (p : Product_Type) is
    begin
        Put (To_String (p.name));
        Put(" by ");
        Put (To_String (p.brand));
    end Put_Product;

    type Piece_Length_Type is new Float range 0.0..36000.0;
    type Advert_Length_Type is new Float range 0.0..120.0;

    type Item_Variant_Type is (PIECE, ADVERT);

    type Item_Type(item_variant : Item_Variant_Type) is record
        case item_variant is
        when PIECE =>
            name        : Unbounded_String;
            performer   : Unbounded_String;
            piece_length_secs : Piece_Length_Type;
        when ADVERT =>
            product   : Product_Type;
            ad_length_secs : Advert_Length_Type;
        end case;
    end record;

    procedure Put_Item (i : Item_Type) is
    begin
        case i.item_variant is
        when PIECE =>
            Put (To_String (i.name));
            Put (" performed by ");
            Put (To_String (i.performer));
            Put (" (");
            Put (Float(i.piece_length_secs), aft => 1, exp => 0);
            Put ("s)");
        when ADVERT =>
            Put ("Advert for ");
            Put_Product (i.product);
            Put (" (");
            Put (Float(i.ad_length_secs), aft => 1, exp => 0);
            Put ("s)");
        end case;
    end Put_Item;

    type Item_Pointer is access Item_Type; -- Ada poiter type, can ignore this, not learning outcome in PLC
    type PlayList_Type is array(1..3) of Item_Pointer;


    piece1 : Item_Pointer := new Item_Type' -- like malloc(sizeof(Item_Type))
       (item_variant => PIECE,
        name => To_Unbounded_String ("Moonlight"),
        performer => To_Unbounded_String ("C. Arrau"),
        piece_length_secs => 17.0*60.0+26.0
       );
    piece2 : Item_Pointer := new Item_Type'
       (item_variant => PIECE,
        name => To_Unbounded_String ("Pathetique"),
        performer => To_Unbounded_String ("D. Barenboim"),
        piece_length_secs => 16.0*60.0+49.0
       );
    advert1 : Item_Pointer := new Item_Type'
       (item_variant => ADVERT,
        product => (name => To_Unbounded_String ("chocolate"), brand => To_Unbounded_String ("Yummm")),
        ad_length_secs => 15.0
       );


    playlist1 : PlayList_Type := (1 => piece1, 2 => advert1, 3 => piece2);

    length1 : Float;
    item : Item_Pointer;
begin
    Put_Item (piece1.all); -- "all" follows the pointer
    Put_Line ("");
    Put_Item (piece2.all);
    Put_Line ("");
    Put_Item (advert1.all);
    Put_Line ("");

    length1 := 0.0;
    for i in playlist1'Range loop
        item := playlist1(i);
        case item.all.item_variant is
        when PIECE =>
            length1 := length1 + item.all.piece_length_secs; -- TASK: fix compiler error
        when ADVERT =>
            length1 := length1 + item.all.ad_length_secs; -- TASK: fix compiler error
        end case;
    end loop;

    Put("length1 = ");
    Put(length1, 1, 1, 0); -- formatting a Float
end PlayListVars;
