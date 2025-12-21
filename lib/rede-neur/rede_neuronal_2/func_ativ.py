import numpy as np

class FuncAtivacao:

    @staticmethod
    def sigmoid(x: float) -> float:
        # Produz um valor de activação no intervalo [0, 1]
        return 1 / (1 + np.exp(-x))

    @staticmethod
    def sigmoid_derivada(x: float) -> float:
        # Derivada da função sigmoid
        s = FuncAtivacao.sigmoid(x)
        return s * (1 - s)

    @staticmethod
    def relu(x: float) -> float:
        # Funcao ReLU (Rectified Linear Unit)
        return max(0, x)

    @staticmethod
    def relu_derivada(x: float) -> float:
        # Derivada da função ReLU
        return 1 if x > 0 else 0

    @staticmethod
    def tanh(x: float) -> float:
        # Funcao tanh (hiperbolica)
        return np.tanh(x)

    @staticmethod
    def tanh_derivada(x: float) -> float:
        # Derivada da função tanh: 1 - tanh(x)^2
        return 1 - np.tanh(x) ** 2

    @staticmethod
    def linear(x: float) -> float:
        # Funcao linear (identidade)
        return x

    @staticmethod
    def linear_derivada(x: float) -> float:
        # Derivada da função linear
        return 1

    @staticmethod
    def obter_derivada(phi: callable) -> callable:
        # Retorna a função derivada correspondente à função de ativação
        if phi == FuncAtivacao.sigmoid:
            return FuncAtivacao.sigmoid_derivada
        elif phi == FuncAtivacao.relu:
            return FuncAtivacao.relu_derivada
        elif phi == FuncAtivacao.tanh:
            return FuncAtivacao.tanh_derivada
        elif phi == FuncAtivacao.linear:
            return FuncAtivacao.linear_derivada
        else:
            raise ValueError("Função de ativação desconhecida")