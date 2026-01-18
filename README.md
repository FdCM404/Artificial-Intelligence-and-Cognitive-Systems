### **Estrutura do Repositório**

**1. Lógica Simbólica e Procura (Prolog):**
   
  - Procura em Espaço de Estados: Implementações de algoritmos de procura cega e informada, como Custo Uniforme, Greedy, A* e o algoritmo adaptativo RTAA*.

  - Optimização Heurística: Resolução dos problemas do Caixeiro Viajante (CV) e das N-Rainhas utilizando Hill-Climbing (HC) e Hill-Climbing com Reinícios Aleatórios (HCR).

**2. Aprendizagem por Reforço (Python)**

  - Algoritmos de Diferença Temporal: Implementação de SARSA e Q-Learning para navegação autónoma.

  - Modelos Adaptativos: Extensões Dyna-Q (integrando um modelo de mundo TR) e Q-Learning com Memória de Experiência (QME) para acelerar a convergência em ambientes complexos.

**3. Redes Neuronais Artificiais (Python)**

  - Arquitetura: Redes Multicamadas (MLP) com suporte para funções de activação Sigmoid, TanH e ReLU.

  - Treino: Algoritmo de retropropagação (backpropagation) com aplicação de factor de momento para estabilizar a descida do gradiente.


### **Requisitos e Instalação**

  - SWI-Prolog (v8.x ou superior): Para os módulos de procura e optimização.

  - Python (v3.8 ou superior): Para os módulos de aprendizagem.


### **Como Executar**

**Procura e Optimização (Prolog):**
  - Inicie o SWI-Prolog na directoria do problema relevante: ```swipl -s test_a_star.pl```
  - Execute o predicado de teste: ```?- run.```

**Aprendizagem e Redes Neuronais (Python):**
 - Navegue até à directoria do algoritmo pretendido e execute o script principal: ```python3 main.py```

### **Análise de Resultados:**

O projeto validou a eficácia dos algoritmos em cenários distintos:

  - Navegação: O algoritmo A* garantiu o caminho óptimo de custo 84.18 no labirinto 2D.

  - Aprendizagem: O Dyna-Q demonstrou uma taxa de sucesso de 98.60% no labirinto 10x10, superando os métodos puramente temporais pela utilização de planeamento interno.

  - Redes Neuronais: A rede convergiu para o erro máximo de 0.05 em aproximadamente 370 épocas para o problema XOR.
