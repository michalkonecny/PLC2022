/* 
 * Copyright: Jack Taylor 2015
 * Used for CS2130 with author's permission.
 */

#include "peoplegeneric.h"
int main()
{
	PeopleGeneric<int> people20(20);
	Person<int> _friend = people20.new_person("John Smith", 72, 1111); //friend is a keyword in C++
	std::cout << "My friend ";
	people20.put_name(_friend);
	std::cout << " info = ";
	people20.put_info(_friend);
	std::cin.get();
	return 0;
}