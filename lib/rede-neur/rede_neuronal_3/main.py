import numpy as np
import matplotlib.pyplot as plt
from rede_neuronal import RedeNeuronal
from func_ativ import TanH

# Dados de treino e de teste
entradas = np.array([[0,0], [0,1], [1,0], [1,1]])
saidas = np.array([[0], [1], [1], [0]])

# Parâmetros de estudo
FORMA = [2, 2, 1]
TAXA_APREND = 0.2
MOMENTO = 0.01
EPOCAS = 1000
ERRO_MAX = 0.05
FUNC_ACTIV = TanH()

# Configurar rede
rede = RedeNeuronal(FORMA, FUNC_ACTIV)

# Treinar rede
historico = rede.treinar(entradas, saidas, EPOCAS, ERRO_MAX, TAXA_APREND, MOMENTO)

# Prever após treino
previsao = rede.prever(entradas)
print("Previsão resultante:")
print(previsao)

# Desenhar gráfico do erro
plt.figure(figsize=(8, 6))
plt.plot(historico)
plt.xlabel('Época')
plt.ylabel('Erro')
plt.title('Evolução do processo de aprendizagem')
plt.grid(True)
plt.show()
