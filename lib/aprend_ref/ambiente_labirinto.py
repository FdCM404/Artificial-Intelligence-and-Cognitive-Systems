class AmbienteLabirinto:

    
    def __init__(self):
        self.tamanho = 10
        self.estado_inicial = (0, 0)
        self.estado_final = (9, 9)
        self.estado_atual = self.estado_inicial
        self.labirinto = self._criar_labirinto()
        self.accoes = ['cima', 'baixo', 'esquerda', 'direita']
    
    def _criar_labirinto(self):
        # Cria um labirinto 9x9 com paredes (1) e caminhos (0)
        labirinto = [
            [0, 1, 1, 1, 1, 1, 1, 1, 1, 1],  # 0
            [0, 0, 0, 0, 1, 1, 1, 1, 1, 1],  # 1
            [1, 1, 1, 0, 1, 0, 0, 0, 0, 1],  # 2
            [1, 1, 1, 0, 1, 0, 1, 1, 0, 1],  # 3
            [1, 1, 1, 0, 0, 0, 1, 1, 0, 1],  # 4
            [1, 1, 1, 1, 1, 0, 0, 0, 0, 1],  # 5
            [1, 1, 1, 1, 1, 1, 1, 1, 0, 1],  # 6
            [1, 1, 1, 1, 1, 1, 1, 1, 0, 1],  # 7
            [1, 1, 1, 1, 1, 1, 1, 1, 0, 0],  # 8
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 0],  # 9
        ]
        return labirinto
#        labirinto = [
#            [0, 0, 1, 1, 1],  # 0
#            [1, 0, 1, 0, 1],  # 1
#            [1, 0, 0, 0, 1],  # 2
#            [1, 1, 1, 0, 1],  # 3
#            [1, 1, 1, 0, 0],  # 4
#        ]
#        return labirinto
 
    def pos_valida(self, linha, coluna):
        # Verifica se a posição é válida (dentro dos limites e não é parede)
        if linha < 0 or linha >= self.tamanho or coluna < 0 or coluna >= self.tamanho:
            return False
        return self.labirinto[linha][coluna] == 0
    
    def executar_accao(self, accao):
        # Executa uma ação e retorna o novo estado, recompensa e se terminou
        linha, coluna = self.estado_atual
        
        # Calcular nova posição
        if accao == 'cima':
            nova_linha, nova_coluna = linha - 1, coluna
        elif accao == 'baixo':
            nova_linha, nova_coluna = linha + 1, coluna
        elif accao == 'esquerda':
            nova_linha, nova_coluna = linha, coluna - 1
        elif accao == 'direita':
            nova_linha, nova_coluna = linha, coluna + 1
        else:
            nova_linha, nova_coluna = linha, coluna
        
        # Verificar se é válido
        if self.pos_valida(nova_linha, nova_coluna):
            self.estado_atual = (nova_linha, nova_coluna)
            
            # Recompensa
            if self.estado_atual == self.estado_final:
                recompensa = 100  # Recompensa por alcançar o objetivo
                terminado = True
            else:
                recompensa = -0.1  # Pequena penalidade por cada passo
                terminado = False
        else:
            # Colisao com parede
            recompensa = -1  # Penalidade moderada por colidir
            terminado = False
        
        return self.estado_atual, recompensa, terminado
    
    def reiniciar(self):
        # Reinicia o ambiente ao estado inicial
        self.estado_atual = self.estado_inicial
        return self.estado_atual
    
    def obter_accoes(self):
        # Retorna as ações possíveis
        return self.accoes
    
    def obter_estado(self):
        # Retorna o estado atual
        return self.estado_atual
    
    def visualizar(self, politica=None):
        # Visualiza o labirinto com o agente e com a politica adotada
        print("\n" + "="*50)
        print("Labirinto 10x10")
        print("="*50)
        
        for i in range(self.tamanho):
            linha = ""
            for j in range(self.tamanho):
                if (i, j) == self.estado_inicial:
                    linha += " S "  # Start
                elif (i, j) == self.estado_final:
                    linha += " F "  # Final
                elif (i, j) == self.estado_atual:
                    linha += " A "  # Agent
                elif self.labirinto[i][j] == 1:
                    linha += " # "  # Wall
                elif politica and (i, j) in politica:
                    accao = politica[(i, j)]
                    if accao == 'cima':
                        linha += " ↑ "
                    elif accao == 'baixo':
                        linha += " ↓ "
                    elif accao == 'esquerda':
                        linha += " ← "
                    elif accao == 'direita':
                        linha += " → "
                    else:
                        linha += " . "
                else:
                    linha += " . "
            print(linha)
        print("="*50 + "\n")
