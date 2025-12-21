import numpy as np
from typing import Callable, List
from func_ativ import FuncAtivacao


class Neuronio:
    # Neurónio artificial com pesos, bias e função de ativação

    def __init__(self, d: int, phi: Callable[[float], float]):
        """
        Inicializa o neurónio.
        
        Args:
            d: Dimensão de entrada (número ligações de entrada)
            phi: Função de activação
        """
        self.d = d
        self.phi = phi
        limite = np.sqrt(1.0 / d) # Inicialização com valores menores para evitar saturação
        self.w = np.random.uniform(-limite, limite, d)
        self.b = np.random.uniform(-limite, limite)
        self.delta_w = np.zeros(d)
        self.delta_b = 0.0
        self.h = 0.0
        self.y = 0.0
        self.y_prime = 0.0

    def propagar(self, x: np.ndarray) -> float:
        """
        Propaga entradas gerando a saída do neurónio e a respectiva derivada.
        
        Args:
            x: Vector de entradas
            
        Returns:
            y: Saída do neurónio
        """
        self.h = np.dot(self.w, x) + self.b
        self.y = self.phi(self.h)
        phi_derivada = FuncAtivacao.obter_derivada(self.phi)
        self.y_prime = phi_derivada(self.h)
        return self.y

    def adaptar(self, delta: float, y_n_minus_1: np.ndarray, alpha: float, beta: float):
        """
        Adapta pesos das ligações de entrada e pendor interno.
        
        Args:
            delta: Componente de propagação do erro de saída do neurónio
            y_n_minus_1: Vector de saída da camada anterior n-1
            alpha: Taxa de aprendizagem
            beta: Factor de momento
        """
        # Nota: o delta já vem com o sinal correto (erro * derivada)
        # A fórmula é: w = w - alpha * delta * x
        delta_w_novo = alpha * delta * y_n_minus_1 + beta * self.delta_w
        self.w = self.w + delta_w_novo
        self.delta_w = delta_w_novo
        
        delta_b_novo = alpha * delta + beta * self.delta_b
        self.b = self.b + delta_b_novo
        self.delta_b = delta_b_novo


class CamadaDensa:
    """Camada densa de neurónios."""

    def __init__(self, d_e: int, d_s: int, phi: Callable[[float], float]):
        """
        Inicializa a camada densa.
        
        Args:
            d_e: Dimensão de entrada
            d_s: Dimensão de saída
            phi: Função de activação
        """
        self.d_e = d_e
        self.d_s = d_s
        self.phi = phi
        self.neuronios = [Neuronio(d_e, phi) for _ in range(d_s)]

    @property
    def y(self) -> np.ndarray:
        """Vector de saída da camada."""
        return np.array([neuronio.y for neuronio in self.neuronios])

    @property
    def y_prime(self) -> np.ndarray:
        """Vector de derivadas da camada."""
        return np.array([neuronio.y_prime for neuronio in self.neuronios])

    def propagar(self, x: np.ndarray) -> np.ndarray:
        """
        Propaga entrada através da camada.
        
        Args:
            x: Vector de entrada
            
        Returns:
            Vector de saída da camada
        """
        return np.array([neuronio.propagar(x) for neuronio in self.neuronios])

    def adaptar(self, delta_n: np.ndarray, y_n_minus_1: np.ndarray, alpha: float, beta: float):
        """
        Adapta pesos e pendores dos neurónios da camada.
        
        Args:
            delta_n: Vector de erro de saída da camada n
            y_n_minus_1: Vector de saída da camada anterior n-1
            alpha: Taxa de aprendizagem
            beta: Factor de momento
        """
        for j in range(self.d_s):
            self.neuronios[j].adaptar(delta_n[j], y_n_minus_1, alpha, beta)


class CamadaEntrada:
    """Representa a camada de entrada da rede neuronal."""

    def __init__(self, d_s: int):
        """
        Inicializa a camada de entrada.
        
        Args:
            d_s: Dimensão de saída (igual à dimensão de entrada)
        """
        self.d_s = d_s
        self.y = np.zeros(d_s)

    def propagar(self, x: np.ndarray) -> np.ndarray:
        """
        Propaga entrada através da camada.
        
        Args:
            x: Vector de entrada
            
        Returns:
            Vector de saída da camada (cópia da entrada)
        """
        self.y = x.copy()
        return self.y


class RedeNeuronal:
    """Representa uma rede neuronal artificial com suporte a retropropagação."""

    def __init__(self, forma: List[int], phi: Callable[[float], float]):
        """
        Inicializa a rede neuronal.
        
        Args:
            forma: Lista com dimensões de cada camada [d_entrada, d_hidden1, ..., d_saida]
            phi: Função de activação
        """
        self.forma = forma
        self.phi = phi
        self.camadas = []
        n = len(forma)
        
        # Camada de entrada
        d_s_1 = forma[0]
        camada_1 = CamadaEntrada(d_s_1)
        self.camadas.append(camada_1)
        
        # Camadas densas
        for i in range(1, n):
            d_e_n = forma[i - 1]
            d_s_n = forma[i]
            camada_n = CamadaDensa(d_e_n, d_s_n, phi)
            self.camadas.append(camada_n)

    def propagar(self, x: np.ndarray) -> np.ndarray:
        """
        Propaga entrada através da rede (forward pass).
        
        Args:
            x: Vector de entrada
            
        Returns:
            Vector de saída da rede
        """
        saida = x
        for camada in self.camadas:
            saida = camada.propagar(saida)
        return saida

    def delta_saida(self, y_n: np.ndarray, y: np.ndarray) -> np.ndarray:
        """
        Calcula a perda de saída da rede.
        
        Args:
            y_n: Vector de treino de saída
            y: Vector de saída gerado pela rede
            
        Returns:
            Vector de diferença [y_n - y for k = 1 to |y|]
        """
        return y_n - y

    def retropropagar(self, delta_n: np.ndarray, alpha: float, beta: float):
        """
        Retropropaga erro pelas camadas da rede, excepto a camada de entrada.
        
        Args:
            delta_n: Vector de variação do erro de saída da rede (já com derivada aplicada)
            alpha: Taxa de aprendizagem
            beta: Factor de momento
        """
        n = len(self.camadas)
        
        # Processar camadas de trás para frente (exceto camada de entrada)
        for i in range(n - 1, 0, -1):
            camada_atual = self.camadas[i]
            y_n_minus_1 = self.camadas[i - 1].y
            
            # Adaptar camada atual
            camada_atual.adaptar(delta_n, y_n_minus_1, alpha, beta)
            
            # Calcular delta para a camada anterior (se não for a camada de entrada)
            if i > 1:
                camada_anterior = self.camadas[i - 1]
                delta_n_minus_1 = np.zeros(camada_anterior.d_s)
                
                for j in range(len(delta_n_minus_1)):
                    soma = 0.0
                    for l in range(camada_atual.d_s):
                        soma += camada_atual.neuronios[l].w[j] * delta_n[l]
                    delta_n_minus_1[j] = soma * camada_anterior.y_prime[j]
                
                delta_n = delta_n_minus_1

    def adaptar(self, x: np.ndarray, y: np.ndarray, alpha: float, beta: float):
        """
        Adapta parâmetros da rede.
        
        Args:
            x: Vector de treino de entrada
            y: Vector de treino de saída
            alpha: Taxa de aprendizagem
            beta: Factor de momento
        """
        # Propagar entrada
        y_n = self.propagar(x)
        
        # Calcular erro de saída (y_desejado - y_previsto)
        erro = self.delta_saida(y, y_n)
        
        # Aplicar derivada da função de ativação da camada de saída
        # delta = erro * f'(h) onde f' é a derivada da função de ativação
        camada_saida = self.camadas[-1]
        delta_n = erro * camada_saida.y_prime
        
        # Retropropagar erro
        self.retropropagar(delta_n, alpha, beta)
        
        # Calcular e retornar erro médio de saída (MSE)
        epsilon = (1 / len(erro)) * np.sum(erro ** 2)
        return epsilon

    def treinar(self, X: np.ndarray, Y: np.ndarray, epocas: int, 
                taxa_aprendizado: float, momento: float = 0.0, verbose: bool = True):
        """
        Treina a rede neuronal usando retropropagação.
        
        Args:
            X: Matriz de entradas (N x d_entrada)
            Y: Matriz de saídas desejadas (N x d_saida)
            epocas: Número de épocas de treinamento
            taxa_aprendizado: Taxa de aprendizado (alpha)
            momento: Factor de momento (beta)
            verbose: Se True, imprime o erro em cada época
        """
        historico_erro = []
        
        for epoca in range(epocas):
            erro_total = 0.0
            
            # Iterar sobre todas as amostras
            for x, y in zip(X, Y):
                epsilon = self.adaptar(x, y, taxa_aprendizado, momento)
                erro_total += epsilon
            
            # Calcular erro médio
            erro_medio = erro_total / len(X)
            historico_erro.append(erro_medio)
            
            if verbose and (epoca + 1) % max(1, epocas // 10) == 0:
                print(f"Época {epoca + 1}/{epocas} - Erro Médio: {erro_medio:.6f}")
        
        return historico_erro

    def prever(self, X: np.ndarray) -> np.ndarray:
        """
        Faz previsões para um conjunto de entradas.
        
        Args:
            X: Matriz de entradas (N x d_entrada)
            
        Returns:
            Matriz de previsões (N x d_saida)
        """
        predicoes = []
        for x in X:
            predicoes.append(self.propagar(x))
        return np.array(predicoes)

    def __repr__(self) -> str:
        return f"Rede Neuronal (forma={self.forma}, camadas={len(self.camadas)})"