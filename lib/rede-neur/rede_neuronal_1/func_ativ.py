import numpy as np

class FuncAtivacao:

    @staticmethod
    def sigmoid(x: float) -> float:
        """
        - Produz um valor de activação no intervalo [0, 1]
        - Função diferenciável 
        """
        return 1 / (1 + np.exp(-x))

    @staticmethod
    def relu(x: float) -> float:
        # Funcao ReLU (Rectified Linear Unit)
        return max(0, x)

    @staticmethod
    def tanh(x: float) -> float:
        # Funcao tanh (hiperbolica)
        return np.tanh(x)

    @staticmethod
    def linear(x: float) -> float:
        # Funcao linear (identidade)
        return x