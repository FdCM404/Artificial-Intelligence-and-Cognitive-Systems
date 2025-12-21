# Interface
from abc import ABC, abstractmethod
from tipos import Estado, Accao


class MemoriaAprend(ABC):

    @abstractmethod
    def actualizar (self, s: Estado, a: Accao, q: float) -> None:
        pass

    @abstractmethod
    def Q(self, s: Estado, a: Accao) -> float:
        pass


class SelAccao(ABC):

    def __init__(self, mem_aprend: MemoriaAprend):
        self._mem_aprend = mem_aprend

    @abstractmethod
    def seleccionar_accao(self, s: Estado) -> Accao:
        pass

    @abstractmethod
    def max_accao(self, s: Estado) -> Accao:
        pass
