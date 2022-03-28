/* 
 * Copyright: Jack Taylor 2015
 * Used for CS2130 with author's permission.
 */

#include <iostream>
#include <string>

template <typename T>
struct Person
{
	Person(std::string n, int a, T i) : name(n), age(a), info(i) {}
	std::string name;
	int age;
	T info;
};

template <typename T>
class PeopleGeneric
{
public:
	PeopleGeneric(int name_size);
	Person<T> new_person(std::string name, int age, T info);
	void put_name(Person<T> p);
	void put_info(Person<T> p);
	void put_type(Person<T> p);
	void put_t(T info);
private:
	int name_size;
};