import sys

class Circle:
    def __init__(self, size):
        self.size = size
    def circleLine(self, i):
        result = ""
        for jj in range(1,2*self.size+1):
            if self.shouldPaint(i,jj):
                result += "*"
            else:
                result += " "
        return result
    def shouldPaint(self,i,jj):
        def shouldPaintS(s,i,j): # local function
            return abs (i**2 + j**2 - s**2) <= s+1
        return shouldPaintS(self.size,i,jj/2)

def main():
    # size = int(sys.argv[1])
    size = 15
    c = Circle(size)
    for i in range(1,size+1):
        print(c.circleLine(i))

main() # interpreter, now that you know what main is, execute it!
