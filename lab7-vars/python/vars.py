import sys # needed for IO

def printA():
    print("a = %d" % a) # using a global variable before its declaration
            # OK because python variables are non-linearly scoped

def setA():
    # print a # ERROR - using local variable before initialisation
    # print b # ERROR - global name 'b' is not defined
    a = 2 # declaring a local variable

def setAglobal():
    global a
    a = 2 # assigning a global variable

def tryPrintA():
    a = 3 # declaring a local variable
    printA() # printing the global a, not the one above

print("test1: setA()")
setA()
# print a # ERROR - variable "a" local to setA
# printA() # ERROR - global name 'a' is not defined

# print("test2: tryPrintA()")
# tryPrintA() # ERROR - global name 'a' is not defined

print("test3: a=1; printA()")
a = 1
printA() # prints 1

print("test4: tryPrintA()")
tryPrintA() # prints 1, not 3

print("test5: setA(); print(a)")
setA() # no effect (variable "a" in setA is local)
print("a = %d" % a) # prints 1

print("test6: setAglobal(); print(a)")
setAglobal() # sets a to 2
print("a = %d" % a) # prints 2
