# Módulo: e_greedy.py
import random
from typing import List
from interface import SelAccao, MemoriaAprend
from tipos import Estado, Accao

class EGreedy(SelAccao):
    def __init__(self, mem_aprend: MemoriaAprend, accoes: List[Accao], epsilon: float):
        self._mem_aprend = mem_aprend
        self._accoes = accoes  
        self._epsilon = epsilon

    def max_accao(self, s: Estado) -> Accao:
        # Baralhar para garantir aleatoriedade em empates
        accoes_shuffled = self._accoes.copy()
        random.shuffle(accoes_shuffled)
        
        # Escolher a ação com maior Q
        return max(accoes_shuffled, key=lambda a: self._mem_aprend.Q(s,a))

    def aproveitar(self, s: Estado):
        return self.max_accao(s)

    def explorar(self):
        return random.choice(self._accoes)

    def seleccionar_accao(self, s: Estado):
        if random.random() > self._epsilon:
            return self.aproveitar(s)
        else:
            return self.explorar()
        
