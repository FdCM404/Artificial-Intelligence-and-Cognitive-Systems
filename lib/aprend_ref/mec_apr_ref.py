# Módulo: mec_apr_ref.py
from typing import List, Optional
from tipos import Estado, Accao
from memoria_esparsa import MemoriaEsparsa
from e_greedy import EGreedy
from aprend_ref import AprendRef


class MecAprendRef:
    def __init__(self, mem_aprend, sel_accao, aprend_ref, accoes):
        self._mem_aprend = mem_aprend
        self._sel_accao = sel_accao
        self._aprend_ref = aprend_ref
        self._accoes = accoes

    def seleccionar_accao(self, s: Estado) -> Accao:
        return self._sel_accao.seleccionar_accao(s)

    def aprender(self, s: Estado, a: Accao, r: float, 
                 sn: Estado, an: Optional[Accao] = None) -> None:
        self._aprend_ref.aprender(s, a, r, sn, an)


"""
    def __init__(self, accoes: List[Accao]):
        # parâmetros padrão
        self._alfa = 0.1
        self._gama = 0.9
        self._epsilon = 0.1
        
        self._mem_aprend = MemoriaEsparsa(valor_omissao=0.0)
        self._sel_accao = EGreedy(self._mem_aprend, accoes, self._epsilon)
        
        # núcleo de aprendizagem
        self._aprend_ref = AprendRef(
            self._mem_aprend, 
            self._sel_accao, 
            self._alfa, 
            self._gama
        )
"""