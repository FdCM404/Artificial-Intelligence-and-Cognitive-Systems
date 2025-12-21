import math

class Activacao:
    """Classe base para funções de activação."""
    
    def f(self, x):
        """Função de activação."""
        raise NotImplementedError
    
    def df(self, x):
        """Derivada da função de activação."""
        raise NotImplementedError


class TanH(Activacao):
    def f(self, x):
        return math.tanh(x)
    
    def df(self, x):
        return 1 - math.tanh(x) ** 2
