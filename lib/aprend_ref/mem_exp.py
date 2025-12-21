from random import choice, sample
from experiencia import Experiencia

class MemoriaExperiencia:
    
    def __init__(self, dim_max):
        self.dim_max = dim_max
        self.memoria = []
    
    def actualizar(self, e):
        if len(self.memoria) == self.dim_max:
            self.memoria.pop(0)
        self.memoria.append(e)
    
    def amostrar(self, n: int):
        n_amostras = min(n, len(self.memoria))
        return sample(self.memoria, n_amostras)
