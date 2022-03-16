strings = \
    ["hi dear", "referential", "hippie", "hilariousness"]

print("all: ", strings)
        
def isLong(s):
    return len(s) > 10

print("filter long: ", filter(isLong, strings))
        
def startsWithHi(s):
    return s.startswith("hi")

print("filter hi: ", filter(startsWithHi, strings))
        
print("filter hi+long (1): ", filter (lambda s: isLong(s) & startsWithHi(s), strings))
        
def filterTwo(cond1, cond2, alist):
    def cond1ANDcond2(s):
        return cond1(s) & cond2(s)
    return filter(cond1ANDcond2, alist)

print("filter hi+long (2): ", filterTwo(isLong, startsWithHi, strings))
        
fns = [isLong, startsWithHi, isLong]

def fnAcceptsHilarious(fn):
    return fn("hilarious") == True

def findOKfns(fnOK, fnList):
    return filter(fnOK, fnList)
    
print("ok fns: ",
    len(
        findOKfns(fnAcceptsHilarious,
            [isLong, # not ok, hilarious is not long enough
             startsWithHi, # ok
             lambda x: True, # ok, accepts anything
             lambda x: False, # not ok, rejects everything
             lambda x: x == "hilarious" # ok, obviously
            ]
        )
    ))

