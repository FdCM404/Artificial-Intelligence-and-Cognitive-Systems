# Módulo: memoria_esparsa.py
from typing import Dict, Tuple
from interface import MemoriaAprend
from tipos import Estado, Accao

class MemoriaEsparsa(MemoriaAprend):
    
    def __init__(self, valor_omissao: float = 0.0):
        
        self._valor_omissao = valor_omissao
        
        self._memoria = {} #: dict[tuple[Estado, Accao], float] = {}

    def actualizar(self, s: Estado, a: Accao, q: float) -> None:
        self._memoria[(s, a)] = q

    def Q(self, s: Estado, a: Accao) -> float:
        # Retorna o valor guardado ou o valor de omissão se a chave não existir
        return self._memoria.get((s, a), self._valor_omissao)
    
    def obter_mem(self):
        return self._memoria