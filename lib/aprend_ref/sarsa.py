from typing import Optional
from aprend_ref import *

class SARSA(AprendRef):

    def aprender(self, s: Estado, a: Accao, r: float, sn: Estado, an: Optional[Accao] = None):
        
        qsa = self._mem_aprend.Q(s,a)
        
        qsnan = 0

        if an is not None:
            qsnan = self._mem_aprend.Q(sn, an)

        q = qsa + self._alfa * (r + self._gama * qsnan - qsa)

        self._mem_aprend.actualizar(s, a, q)