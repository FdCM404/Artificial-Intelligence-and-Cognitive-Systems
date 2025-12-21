from enum import Enum


class Accao(Enum):
    ESQ = 'left'
    DIR = 'right'


class Ambiente:
    def __init__(self, posicao_inicial, r_max=1):
        self.ambiente = ['-', '.', '.', '.', '.', '.', '+']
        self.posicao_agente = posicao_inicial
        self.posicao_inicial = posicao_inicial
        self.r_max = r_max
    
    @property
    def dim_amb(self):
        return len(self.ambiente)
    
    def reiniciar(self):
        self.mover_agente(self.posicao_inicial)
        return self.posicao_agente
    
    def actual(self, accao):
        posicao = self.posicao_agente
        if accao == Accao.ESQ:
            posicao -= 1
        elif accao == Accao.DIR:
            posicao += 1
        if posicao >= 0 and posicao < self.dim_amb:
            self.mover_agente(posicao)
    
    def observar(self):
        return self.posicao_agente, self.reforco(self.posicao_agente)
    
    def mover_agente(self, posicao):
        self.posicao_agente = posicao
    
    def reforco(self, posicao):
        elemento = self.ambiente[posicao]
        if elemento == '+':
            r = self.r_max
        elif elemento == '-':
            r = -self.r_max
        else:
            r = 0
        return r
    
    def mostrar(self):
        for posicao in range(self.dim_amb):
            if posicao == self.posicao_agente:
                print('A', end='')
            else:
                print(self.ambiente[posicao], end='')
        print()
    
    def mostrar_politica(self, politica):
        print("\nPolítica:")
        for s in range(self.dim_amb):
            accao = politica.get(s)
            print(accao)
        print()
    
    def mostrar_valor(self, valor):
        print("\nValor:")
        for s in range(self.dim_amb):
            vs = valor.get(s)
            print(vs)
        print()
