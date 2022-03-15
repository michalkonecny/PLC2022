#include <stdio.h>
#include <stdlib.h>

// Leaf node records:

typedef struct
{
    char *name;
    char *performer;
    float length;
} Piece;

typedef struct
{
    char *name;
    char *brand;
} Product;

typedef struct
{
    Product product;
    float length;
} Advert;

typedef struct
{
    struct ITEM *items;
    int number_of_items;
} PlayList;

// The union type of Piece, Advert and a sub-playlist (for nested playlists):

typedef union
{
    Piece piece;
    Advert advert;
    PlayList * sublist;
} ItemUnion;

typedef enum
{
    PIECE,
    ADVERT,
    SUBLIST
} ItemVariant;

typedef struct ITEM
{
    ItemVariant variant;
    ItemUnion content;
} Item;

// Item constructors:

Item *newPiece(char *name, char *performer, float length)
{
    Item *result = malloc(sizeof(Item));
    (*result).variant = PIECE;           // initialise discriminant
    (*result).content.piece.name = name; // initialise content
    (*result).content.piece.performer = performer;
    (*result).content.piece.length = length;
    return result;
}

Item *newAdvert(char *name, char *brand, float length)
{
    Item *result = malloc(sizeof(Item));
    (*result).variant = ADVERT; // initialise discriminant
    (*result).content.advert.product.name = name;
    (*result).content.advert.product.brand = brand;
    (*result).content.advert.length = length;
    return result;
}

PlayList *newPlayList(Item *items, int number_of_items)
{
    PlayList *result = malloc(sizeof(PlayList));
    result->items = items;
    result->number_of_items = number_of_items;
    return result;
}

Item *newSublist(PlayList * sublist)
{
    Item *result = malloc(sizeof(Item));
    (*result).variant = SUBLIST; // initialise discriminant
    (*result).content.sublist = sublist;
    return result;
}

// Counting items in a playlist (and recursively for its sub-playlists):

int countItems(PlayList * list)
{
    int result = 0;

    for (int i = 0; i < list->number_of_items; i++)
    {
        Item *currentItem = list->items + i;
        if ((*currentItem).variant == SUBLIST)
        {
            result = result + countItems((*currentItem).content.sublist);
        }
        else
        {
            result = result + 1;
        }
    }

    return result;
}

void printPlayList(PlayList * playlist); // A declaration; full definition comes later

void printItem(Item *item)
{
    Piece piece;
    Advert advert;
    switch (item->variant)
    {
    case PIECE:
        piece = item->content.piece;
        printf("%s performed by %s (%.2fs)", piece.name, piece.performer, piece.length);
        break;

    case ADVERT:
        advert = item->content.advert;
        printf("Advert for %s by %s (%.2fs)", advert.product.name, advert.product.brand, advert.length);
        break;

    case SUBLIST:
        printPlayList(item->content.sublist);
        break;

    default:
        break;
    }
}

void printPlayList(PlayList * playlist)
{
    printf("[");
    for (int i = 0; i < playlist->number_of_items; i++)
    {
        if (i > 0)
        {
            printf(", ");
        }
        printItem(playlist->items + i);
    }
    printf("]");
}

int main(int argc, char *argv[])
{
    Item *piece1 = newPiece("Moonlight", "C. Arrau", 17 * 60 + 26);
    Item *piece2 = newPiece("Pathetique", "D. Barenboim", 16 * 60 + 49);
    Item *advert1 = newAdvert("chocolate", "Yummm", 15);
    // Item *advert2 = newAdvert("crisps", "Yummm", 15);

    printf("piece1 = ");
    printItem(piece1);
    printf("\n");

    Item items1[2];
    items1[0] = *piece1;
    items1[1] = *piece2;

    PlayList * playList1 = newPlayList(items1, 2);

    printf("playList1 = ");
    printPlayList(playList1);
    printf("\n");
    printf("\n");

    printf("countItems(playList1) = %d\n", countItems(playList1));

    Item items2[3];
    items2[0] = *newSublist(playList1);
    items2[1] = *advert1;
    items2[2] = *newSublist(playList1);

    PlayList * playList2 = newPlayList(items2, 3);

    printf("\n");
    printf("playList2 = ");
    printPlayList(playList2);
    printf("\n");
    printf("\n");

    printf("countItems(playList2) = %d\n", countItems(playList2));

    return 0;
}
