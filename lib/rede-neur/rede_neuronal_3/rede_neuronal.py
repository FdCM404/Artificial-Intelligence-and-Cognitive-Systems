import numpy as np
from typing import List
from func_ativ import Activacao


class Neuronio:
    """Neurónio artificial com pesos, bias e função de ativação."""

    def __init__(self, d: int, phi: Activacao):
        """
        Inicializa o neurónio.
        
        Args:
            d: Dimensão de entrada (número ligações de entrada)
            phi: Função de activação (objeto Activacao)
        """
        self.d = d
        self.phi = phi
        # Inicialização dos pesos
        limite = np.sqrt(1.0 / d)
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
        Baseado no pseudocódigo: h = w·x + b; y = φ(h); y' = dφ(h)/dh
        
        Args:
            x: Vector de entradas
            
        Returns:
            y: Saída do neurónio
        """
        self.h = np.dot(self.w, x) + self.b
        self.y = self.phi.f(self.h)
        self.y_prime = self.phi.df(self.h)
        return self.y

    def adaptar(self, delta: float, y_n_minus_1: np.ndarray, alpha: float, beta: float):
        """
        Adapta pesos e pendor com momento.
        Baseado no pseudocódigo:
            Δw = -α·y'·δ·y^(n-1) + β·Δw onde y'·δ já vem calculado
            w = w + Δw
            Δb = -α·y'·δ + β·Δb onde y'·δ já vem calculado
            b = b + Δb
        
        Args:
            delta: Componente de propagação do erro (y'·δ já aplicado)
            y_n_minus_1: Vector de saída da camada anterior n-1
            alpha: Taxa de aprendizagem α
            beta: Factor de momento β
        """
        # Variação dos pesos com momento (delta já tem y' aplicado)
        delta_w_novo = alpha * delta * y_n_minus_1 + beta * self.delta_w
        self.w = self.w + delta_w_novo
        self.delta_w = delta_w_novo
        
        # Variação do pendor com momento (delta já tem y' aplicado)
        delta_b_novo = alpha * delta + beta * self.delta_b
        self.b = self.b + delta_b_novo
        self.delta_b = delta_b_novo


class CamadaDensa:
    """Camada densa de neurónios."""

    def __init__(self, d_e: int, d_s: int, phi: Activacao):
        """
        Inicializa a camada densa.
        
        Args:
            d_e: Dimensão de entrada
            d_s: Dimensão de saída
            phi: Função de activação (objeto Activacao)
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
        Baseado no pseudocódigo: for j = 1 to d_s: neuronios[j].adaptar(δ^n[j], y^(n-1), α, β)
        
        Args:
            delta_n: Vector de erro de saída da camada n (δ^n)
            y_n_minus_1: Vector de saída da camada anterior n-1 (y^(n-1))
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

    def __init__(self, forma: List[int], phi: Activacao):
        """
        Inicializa a rede neuronal.
        
        Args:
            forma: Lista com dimensões de cada camada [d_entrada, d_hidden1, ..., d_saida]
            phi: Função de activação (objeto Activacao)
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
        Baseado no pseudocódigo: y = x; for camada in camadas: y = camada.propagar(y)
        
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
        Baseado no pseudocódigo: return [y_k^n - y_k for k = 1 to |y|]
        
        Args:
            y_n: Vector de treino de saída (y desejado)
            y: Vector de saída gerado pela rede (y previsto)
            
        Returns:
            Vector de diferença [y_n - y]
        """
        return y_n - y

    def retropropagar(self, delta_n: np.ndarray, alpha: float, beta: float):
        """
        Retropropaga erro pelas camadas da rede.
        Baseado no pseudocódigo das imagens:
            δ^0 = δ^N
            for n = N to 2 step -1:
                y^(n-1) = camadas[n-1].y
                d^n = camadas[n].d_s
                camadas[n].adaptar(δ^n, y^(n-1), α, β)
                δ^(n-1)[j] = Σ[neuron^n[l].w_j * δ^n[l] for l = 1 to d^(n-1)]
                δ^n = δ^(n-1)
        
        Args:
            delta_n: Vector de variação do erro de saída (δ^N já com derivada)
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
                
                # Para cada neurônio j da camada anterior
                for j in range(len(delta_n_minus_1)):
                    soma = 0.0
                    # Somar: Σ[neuron^n[l].w_j * δ^n[l] for l]
                    for l in range(camada_atual.d_s):
                        soma += camada_atual.neuronios[l].w[j] * delta_n[l]
                    # Aplicar derivada: δ^(n-1)[j] = soma * y'^(n-1)[j]
                    delta_n_minus_1[j] = soma * camada_anterior.y_prime[j]
                
                delta_n = delta_n_minus_1

    def adaptar(self, x: np.ndarray, y: np.ndarray, alpha: float, beta: float):
        """
        Adapta parâmetros da rede.
        Baseado no pseudocódigo:
            y^N = propagar(x)
            δ^N = delta_saida(y^N, y)
            retropropagar(δ^N, α, β)
            ε = |δ^N|²
        
        Args:
            x: Vector de treino de entrada
            y: Vector de treino de saída
            alpha: Taxa de aprendizagem
            beta: Factor de momento
            
        Returns:
            Erro médio de saída
        """
        # Propagar entrada
        y_n = self.propagar(x)
        
        # Calcular erro de saída (y_desejado - y_previsto)
        erro = self.delta_saida(y, y_n)
        
        # Aplicar derivada da função de ativação da camada de saída
        camada_saida = self.camadas[-1]
        delta_n = erro * camada_saida.y_prime
        
        # Retropropagar erro
        self.retropropagar(delta_n, alpha, beta)
        
        # Calcular erro médio: ε = (1/K) * Σ(δ_k)²
        epsilon = (1 / len(erro)) * np.sum(erro ** 2)
        return epsilon

    def treinar(self, X: np.ndarray, Y: np.ndarray, epocas: int, erro_max: float,
                taxa_aprend: float, momento: float = 0.0):
        """
        Treina a rede neuronal.
        Baseado no pseudocódigo:
            for n_epocas:
                ε = 0
                for x ∈ X, y ∈ Y:
                    ε_x = adaptar(x, y, α, β)
                    ε = max(ε, ε_x)
                if ε ≤ ε_max:
                    break
        
        Args:
            X: Matriz de entradas
            Y: Matriz de saídas desejadas
            epocas: Número de épocas
            erro_max: Erro máximo tolerado
            taxa_aprend: Taxa de aprendizado (α)
            momento: Factor de momento (β)
            
        Returns:
            Histórico de erros por época
        """
        historico_erro = []
        
        for epoca in range(epocas):
            erro_total = 0.0
            
            # Iterar sobre todas as amostras
            for x, y in zip(X, Y):
                epsilon = self.adaptar(x, y, taxa_aprend, momento)
                erro_total += epsilon
            
            # Calcular erro médio
            erro_medio = erro_total / len(X)
            historico_erro.append(erro_medio)
            
            # Verificar se erro máximo foi atingido
            if erro_medio <= erro_max:
                break
        
        return historico_erro

    def prever(self, X: np.ndarray) -> np.ndarray:
        """
        Faz previsões.
        Baseado no pseudocódigo: Y = [propagar(x) for x ∈ X]
        
        Args:
            X: Matriz de entradas
            
        Returns:
            Matriz de previsões
        """
        predicoes = []
        for x in X:
            predicoes.append(self.propagar(x))
        return np.array(predicoes)

    def __repr__(self) -> str:
        return f"Rede Neuronal (forma={self.forma}, camadas={len(self.camadas)})"
