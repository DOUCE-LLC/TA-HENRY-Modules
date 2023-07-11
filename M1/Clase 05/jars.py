class Jars:

    # Creamos las 2 jarras
    def __init__(self):
        self.jar5 = 0
        self.jar3 = 0
        print(self.jar3, self.jar5)

    # Llenar la jarra de 3 litros
    def jar3_fill(self):
        self.jar3 = 3
        print(self.jar3, self.jar5)

    # Llenar la jarra de 5 litros
    def jar5_fill(self):
        self.jar5 = 5
        print(self.jar3, self.jar5)

    # Vaciar la jarra de 3 litros
    def jar3_drop(self):
        self.jar3 = 0
        print(self.jar3, self.jar5)

    # Vaciar la jarra de 5 litros
    def jar5_drop(self):
        self.jar5 = 0
        print(self.jar3, self.jar5)

    # Verter el contenido de la jarra de 3 litros en la de 5 litros
    def jar3_to_jar5(self):
        if (self.jar5 + self.jar3 <= 5):
            self.jar5 = self.jar5 + self.jar3
            self.jar3 = 0
        elif (self.jar5 + self.jar3 >= 8):
            self.jar3 = 3
            self.jar5 = 5
            print('Las jarras ya estan llenas')
        else:
            jar_sum = self.jar5 + self.jar3
            rest = jar_sum - 5
            self.jar5 = 5
            self.jar3 = rest
        print(self.jar3, self.jar5)
            
    # Verter el contenido de la jarra de 5 litros en la de 3 litros
    def jar5_to_jar3(self):
        jar_sum = self.jar5 + self.jar3
        rest = jar_sum - 3
        self.jar3 = 3
        self.jar5 = rest
        print(self.jar3, self.jar5)

    def restart(self):
        self.jar3 = 0
        self.jar5 = 0
        print(self.jar3, self.jar5)