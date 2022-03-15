typedef struct
{
  int age;
  float salary;
} person;


typedef struct
{
  int age;
  float salary;
} individual;

typedef person individual2;

typedef int bint;

int main(int argc, char *argv[])
{
    
    person a_p = { 60, 45000};
    individual b_i = { 60, 45000};
    individual2 b_i2 = { 60, 45000};
    //a_p = b_i; //error: structural equivalence does not apply to record types
    a_p = b_i2;
    
    int a = 1;
    bint b = 2;
    a = b; // OK - structural equivalence used for primitive types
    
    return 0;
}
