#include <stdio.h>
#include <stdlib.h>

typedef enum {TABLE, TBODY, TR, TD } HTMLElement;

typedef struct
{ 
    HTMLElement element;
    int childrenNumber;
    struct HTMLFR * children;
      // incomplete struct, completion below
      // (struct HTMLFR = HTMLFragment)
}
HTMLFrElement; // the new record type

typedef struct
{
    char * text;
}
HTMLFrText;

typedef union
{
    HTMLFrElement frElement; // either this
    HTMLFrText ftText; // or this (a string)
}
HTMLFRUnion;

typedef enum {FRElem, FRText} HTMLFRRepr;

typedef struct HTMLFR // struct named for completion of above
{
    HTMLFRRepr repr; // discriminant
    HTMLFRUnion content; // the union
} 
HTMLFragment;

HTMLFragment * makeTable(char *** rows)
{
    HTMLFragment * table; // pointer type
    
    // allocate space for the record:
    table = malloc(sizeof(HTMLFragment));

    // initialise the table element record:
    // (* table) is the memory cell pointed to by table
    (*table).repr = FRElem;
    (*table).content.frElement.element = TABLE;
    (*table).content.frElement.childrenNumber = 1;
    
    // create the child element - tbody
    HTMLFragment * tbody;
    tbody = malloc(sizeof(HTMLFragment));
    // put tbody into the children list of table
    (*table).content.frElement.children = tbody;
    
    // initialise tbody record... etc.
    (*tbody).content.frElement.element = TBODY;
    (*tbody).content.frElement.childrenNumber = 0; // TODO
    
    // TODO: add all rows to tbody
    // need to count the rows first
    // then allocate space for children array
    // then create tr elements one by one and put pointers
    //  to them in the children array
    // each tr element will have its own td children...
    
    // working with tree structures in C is a nightmare
    
    return table;
}

int countNodes(HTMLFragment * fragment)
{
    int result = 1;
    
    if ( (*fragment).repr == FRElem )
    {
        HTMLFrElement element = (*fragment).content.frElement;
        int i;
        HTMLFragment * childPtr = element.children;
        for ( i = 0; i < element.childrenNumber; i++ )
        {
            result = result + countNodes(childPtr);
            childPtr = childPtr + 1; // pointer shift
        }
    }
    
    return result;
}

char rows1[2][4][4] =
     {{"X","X","O",0},{"O","B","X",0},{"O","B","B",0},0};

int main(int argc, char *argv[])
{
    int n = countNodes(makeTable(&rows1));
    printf("countNodes = %d\n", n);
    return 0;
}
