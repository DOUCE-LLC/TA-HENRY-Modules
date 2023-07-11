print('\nDiseñar una clase que permita trabajar con un árbol binario y que contenga los métodos: \n insertaVal: para insertar un dato \n buscaVal: que devuelva True o False si existe o no un dato \n verVal: que imprima por pantalla los valores del árbol \nNota: Se puede utilizar la recursividad \n')

class Node():

    def __init__(self, d):
        self.d = d
        self.l = None
        self.r = None

class Tree():

    def __init__(self):
        self.raiz = None

    def insertVal(self):
        d = Node(d)

        if (self.raiz == None):
            self.raiz = d
        else:
            puntero = self.raiz
            if (puntero.l == None):
                puntero.l = d
            elif (puntero.r == None):
                puntero.r = d

    def searchVal(self, s):
        if (s):
            return True
        else:
            return False

    def seeVal(self, s):
        if (s):
            print(s)
        else:
            print('No existe el nodo.')