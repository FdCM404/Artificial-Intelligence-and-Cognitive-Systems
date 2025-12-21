import numpy as np
from pt1.func_ativ import FuncAtivacao
from pt1.rede_neuronal import RedeNeuronal

# Exemplo de uso
if __name__ == "__main__":
    # Criar uma rede com 3 entradas, 2 camadas ocultas (4 e 3 neurónios) e 1 saída
    forma = [3, 4, 3, 1]
    rede = RedeNeuronal(forma, FuncAtivacao.sigmoid)

    print(f"Rede criada: {rede}")
    print(f"Número de camadas: {len(rede.camadas)}")

    # Testar propagação
    entrada = np.array([0.5, -0.3, 0.8])
    saida = rede.propagar(entrada)

    print(f"\nEntrada: {entrada}")
    print(f"Saída: {saida}")