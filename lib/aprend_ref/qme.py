from q_learning import QLearning
from aprend_ref import *
from mem_exp import MemoriaExperiencia
from experiencia import Experiencia

class QME(QLearning):
    
    def __init__(self, mem_aprend: MemoriaAprend, sel_accao: SelAccao, alfa: float, gama: float, num_sim: int, dim_max: int):
        super().__init__(mem_aprend, sel_accao, alfa, gama)
        self.num_sim = num_sim
        self.memoria_experiencia = MemoriaExperiencia(dim_max)
    
    def aprender(self, s, a, r, sn):
        super().aprender(s, a, r, sn)
        e = (s, a, r, sn)
        self.memoria_experiencia.actualizar(e)
        self.simular()
    
    def simular(self):
        amostras = self.memoria_experiencia.amostrar(self.num_sim)
        for (s, a, r, sn) in amostras:
            super().aprender(s, a, r, sn)