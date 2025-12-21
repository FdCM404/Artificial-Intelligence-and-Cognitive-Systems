from random import choice

class ModeloTR:

    def __init__(self):
        self.T = {}
        self.R = {}

    def actualizar(self, s, a, r, sn):
        self.T[(s, a)] = sn
        self.R[(s, a)] = r

    def amostrar(self):
        s, a = choice(list(self.T.keys()))
        sn = self.T[(s, a)]
        r = self.R[(s, a)]
        return s, a, r, sn
