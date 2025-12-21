from aprend_ref import *
from typing import Optional

class QLearning(AprendRef):

    def aprender(self, s: Estado, a: Accao, r: float, sn: Estado, an: Optional[Accao] = None) -> None:
        
        an = self._sel_accao.max_accao(sn)

        qsa = self._mem_aprend.Q(s,a)

        qsnan = self._mem_aprend.Q(sn, an)

        q = qsa + self._alfa * (r + self._gama * qsnan - qsa)

        self._mem_aprend.actualizar(s, a, q)