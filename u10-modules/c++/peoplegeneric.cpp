/* 
 * Copyright: Jack Taylor 2015
 * Used for CS2130 with author's permission.
 */

#include "peoplegeneric.h"
template <typename T>
PeopleGeneric<T>::PeopleGeneric(int name_size)
{
	PeopleGeneric::name_size = name_size;
}

template <typename T>
Person<T> PeopleGeneric<T>::new_person(std::string name, int age, T info)
{
	return Person<T>(name, age, info);
}

template <typename T>
void PeopleGeneric<T>::put_name(Person<T> p)
{
	std::cout << p.name;
}

template <typename T>
void PeopleGeneric<T>::put_info(Person<T> p)
{
	put_t(p.info);
}

template <typename T>
void PeopleGeneric<T>::put_type(Person<T> p)
{
	std::cout << "person";
}

template <class T>
void PeopleGeneric<T>::put_t(T info)
{
	std::cout << info;
}

template class PeopleGeneric<int>;