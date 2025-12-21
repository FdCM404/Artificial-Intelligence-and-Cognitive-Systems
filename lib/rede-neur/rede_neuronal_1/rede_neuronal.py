import numpy as np
from typing import Callable, List

class Neuronio:
    
    # Representa um neurónio artificial com pesos, bias e função de ativação.
    
    def __init__(self, d: int, phi: Callable[[float], float]):
        self.d = d
        self.phi = phi
        self.w = np.random.uniform(-1, 1, d)
        self.b = np.random.uniform(-1, 1)
        self.h = 0.0
        self.y = 0.0

    def propagar(self, x: np.ndarray) -> float:
        self.h = np.dot(x, self.w) + self.b
        self.y = self.phi(self.h)
        return self.y

class CamadaDensa:
    
    # Camada densa (fully connected) de neurónios.
    
    def __init__(self, d_e: int, d_s: int, phi: Callable[[float], float]):
        self.d_e = d_e
        self.d_s = d_s
        self.phi = phi
        self.neuronios = [Neuronio(d_e, phi) for _ in range(d_s)]

    @property
    def y(self) -> List[float]:
        return [neuronio.y for neuronio in self.neuronios]

    def propagar(self, x: np.ndarray) -> np.ndarray:
        y = np.array([neuronio.propagar(x) for neuronio in self.neuronios])
        return y

class CamadaEntrada:
    
    # Representa a camada de entrada da rede neuronal
    
    def __init__(self, d_s: int):
        self.d_s = d_s
        self.y = np.zeros(d_s)

    def propagar(self, x: np.ndarray) -> np.ndarray:
        self.y = x.copy()
        return self.y

class RedeNeuronal:
    
    # Representa uma rede neuronal artificial completa.
    
    def __init__(self, forma: List[int], phi: Callable[[float], float]):
        self.forma = forma
        self.phi = phi
        self.camadas = []
        n = len(forma)
        d_s_1 = forma[0]
        camada_1 = CamadaEntrada(d_s_1)
        self.camadas.append(camada_1)
        for i in range(1, n):
            d_e_n = forma[i - 1]
            d_s_n = forma[i]
            camada_n = CamadaDensa(d_e_n, d_s_n, phi)
            self.camadas.append(camada_n)

    def propagar(self, x: np.ndarray) -> np.ndarray:
        saida = x
        for camada in self.camadas:
            saida = camada.propagar(saida)
        return saida

    def __repr__(self) -> str:
        return f"Rede Neuronal (forma={self.forma}, camadas={len(self.camadas)})"
