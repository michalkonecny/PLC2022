class Piece:
    def __init__(self, name, performer, length_secs): # constructor
        self.name = name
        self.performer = performer
        self.length_secs = length_secs
        self.check()

    def __repr__(self):  # formatting (like toString())
        result = "%s by %s (%.2fs)" % (self.name, self.performer, self.length_secs)
        return result

    def check(self):
        # do some dynamic type checking:
        assert self.name.__class__ == str
        assert self.performer.__class__ == str
        assert self.length_secs.__class__ == type(1.0)
        l = self.length_secs
        assert 0 < l and l < 36000

class Product:
    def __init__(self, name, brand):
        self.name = name
        self.brand = brand
        self.check()

    def __repr__(self):  # formatting (like toString())
        result = "%s by %s" % (self.name, self.brand)
        return result

    def check(self):
        # do some dynamic type checking:
        assert self.name.__class__ == str
        assert self.brand.__class__ == str

class Advert:
    def __init__(self, product, length_secs): # constructor
        self.product = product
        self.length_secs = length_secs
        self.check()

    def __repr__(self):  # formatting (like toString())
        result = "Advert for %s by %s (%.2fs)" % (self.product.name, self.product.brand, self.length_secs)
        return result

    def check(self):
        # do some dynamic type checking:
        assert self.product.__class__ == Product
        assert self.length_secs.__class__ == float
        l = self.length_secs
        assert 0 < l and l < 120

playlist1 = []

def definePlaylist1():
    piece1 = Piece("Moonlight", "C. Arrau", 17*60+26.0)
    piece2 = Piece("Pathetique", "D. Barenboim", 16*60+49.0)
    advert1 = Advert(Product("chocolate", "Yummm"), 15.0)
    playlist1 = [piece1, advert1, piece2]

definePlaylist1()

print("playlist1 = %s" % playlist1)

length1 = sum([ item.length_secs for item in playlist1 ])

print("lengths1 = %s" % length1)

