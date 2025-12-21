# Módulo: aprend_ref.py
from abc import abstractmethod
from interface import MemoriaAprend, SelAccao
from tipos import Estado, Accao

class AprendRef:
    def __init__(self, mem_aprend: MemoriaAprend, sel_accao: SelAccao, alfa: float, gama: float):
        self._mem_aprend = mem_aprend
        self._sel_accao = sel_accao
        self._alfa = alfa
        self._gama = gama

    @abstractmethod
    def aprender(self, s: Estado, a: Accao, r: float, sn: Estado, an=None):
        pass
