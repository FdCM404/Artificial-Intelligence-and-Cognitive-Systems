from aprend_ref import *
from q_learning import QLearning
from modelo_tr import ModeloTR
 
class DynaQ(QLearning):

    def __init__(self, mem_aprend: MemoriaAprend, sel_accao: SelAccao, alfa: float, gama: float, num_sim: int):
        super().__init__(mem_aprend, sel_accao, alfa, gama)
        self.num_sim = num_sim
        self.modelo = ModeloTR()

    def aprender(self, s: Estado, a: Accao, r: float, sn: Estado):
        super().aprender(s, a, r, sn)
        self.modelo.actualizar(s, a, r, sn)
        self.simular()

    def simular(self):
        for _ in range(self.num_sim):
            s, a, r, sn = self.modelo.amostrar()
            super().aprender(s, a, r, sn)