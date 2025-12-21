import numpy as np
from func_ativ import FuncAtivacao
from rede_neuronal import RedeNeuronal


def visualizar_grid(grid: np.ndarray, titulo: str = ""):
    # Visualiza uma grid 3x3.
    if titulo:
        print(f"\n{titulo}")
    grid_2d = grid.reshape(3, 3)
    for linha in grid_2d:
        print(" ".join(["X" if x >= 0.5 else "-" for x in linha]))
    print()


def main():
    # Seed para reprodutibilidade
    np.random.seed(42)
    
    print("=" * 80)
    print("ALGORITMO DE RETROPROPAGAÇÃO")
    print("Exemplo: Tarefa de reconhecimento de barras verticais")
    print("Pretende-se reconhecer barras verticais numa matriz 3x3")
    print("=" * 80)
    
    # Dimensionamento da rede
    print("\nDimensionamento da rede:")
    print("Número de camadas escondidas: 1")
    print("Dimensão da camada de entrada: 9 ")
    print("Dimensão da camada escondida: 3")
    print("Dimensão da camada de saída: 1")
    print("\nForma da rede = [9, 3, 1]")
    
    print("\nParâmetros:")
    print("Taxa de aprendizagem: 0.5")
    print("Erro máximo: 0.05")
    print("Função de activação: tanh")
    
    # Criar rede neuronal
    forma = [9, 3, 1]
    rede = RedeNeuronal(forma, FuncAtivacao.tanh)
    
    # Preparar dados de treino
    print("\n" + "=" * 80)
    print("EXEMPLOS DE TREINO")
    print("=" * 80)
    
    # Dados de treino
    # Saídas: 0.00 (sem barra) e 1.00 (com barra)
    entradas = []
    saidas = []
    
    # Grid vazio (sem barra) - saída 0.00
    entradas.append([0, 0, 0, 0, 0, 0, 0, 0, 0])
    saidas.append([0.0])
    
    # Barra coluna 0 - saída 1.00
    entradas.append([1, 0, 0, 1, 0, 0, 1, 0, 0])
    saidas.append([1.0])
    
    # Barra coluna 1 - saída 1.00
    entradas.append([0, 1, 0, 0, 1, 0, 0, 1, 0])
    saidas.append([1.0])
    
    # Barra coluna 2 - saída 1.00
    entradas.append([0, 0, 1, 0, 0, 1, 0, 0, 1])
    saidas.append([1.0])
    
    # Linha horizontal superior - saída 0.00
    entradas.append([1, 1, 1, 0, 0, 0, 0, 0, 0])
    saidas.append([0.0])
    
    # Linha horizontal centro - saída 0.00
    entradas.append([0, 0, 0, 1, 1, 1, 0, 0, 0])
    saidas.append([0.0])
    
    # Linha horizontal inferior - saída 0.00
    entradas.append([0, 0, 0, 0, 0, 0, 1, 1, 1])
    saidas.append([0.0])
    
    X_treino = np.array(entradas, dtype=float)
    Y_treino = np.array(saidas, dtype=float)
    
    # Codificação dos dados de treino
    print("\nCodificação dos dados de treino:")
    print("entradas = [")
    for i, entrada in enumerate(X_treino):
        entrada_str = ", ".join([f"{int(x)}" for x in entrada])
        print(f"  [{entrada_str}],")
        visualizar_grid(entrada, f"Exemplo {i}:")
    print("]")
    print(f"\nsaidas = {[int(s[0]) for s in saidas]}")
    
    # Treinar a rede
    print("\n" + "=" * 80)
    print("TREINAMENTO DA REDE")
    print("=" * 80)
    
    taxa_aprendizado = 0.5
    momento = 0.0
    epocas = 10000
    erro_maximo = 0.05
    
    print(f"\nIniciando treinamento com {epocas} épocas...")
    print(f"Taxa de aprendizado: {taxa_aprendizado}")
    print(f"Momento: {momento}")
    print(f"Erro máximo desejado: {erro_maximo}")
    
    historico = rede.treinar(
        X_treino, 
        Y_treino, 
        epocas=epocas,
        taxa_aprendizado=taxa_aprendizado,
        momento=momento,
        verbose=True
    )
    
    # Resultados
    print("\n" + "=" * 80)
    print("RESULTADOS")
    print("=" * 80)
    
    erro_final = historico[-1]
    print(f"\nerro: {erro_final:.6f}")
    
    print("\nPrevisões no conjunto de treino:")
    predicoes = rede.prever(X_treino)
    print("saidas = [", end="")
    for i, pred in enumerate(predicoes):
        if i > 0:
            print(", ", end="")
        print(f"{pred[0]:.5f}", end="")
    print("]")
    
    # Análise de desempenho
    print("\n" + "=" * 80)
    print("ANÁLISE DE DESEMPENHO NO CONJUNTO DE TREINO")
    print("=" * 80)
    
    corretos = 0
    for i, (entrada, saida_esperada, pred) in enumerate(zip(X_treino, Y_treino, predicoes)):
        # Classificação: >0.5 = barra (1), <=0.5 = sem barra (0)
        pred_bin = 1 if pred[0] > 0.5 else 0
        esperado = int(saida_esperada[0])
        correto = pred_bin == esperado
        corretos += correto
        
        visualizar_grid(entrada, f"Exemplo {i} - Esperado: {esperado}, Previsto: {pred[0]:.3f} ({'Y' if correto else 'N'})")
    
    acuracia = (corretos / len(X_treino)) * 100
    print(f"\nAcurácia: {acuracia:.1f}% ({corretos}/{len(X_treino)} corretos)")
    
    # Dados de teste - Verificação da capacidade de generalização
    print("\n" + "=" * 80)
    print("DADOS DE TESTE - Verificação da capacidade de generalização da rede neuronal")
    print("=" * 80)
    
    # Dados de teste
    testes_entrada = []
    testes_saida_esperada = []
    
    # Teste 1: Barra vertical esquerda
    testes_entrada.append([1, 0, 0, 1, 0, 0, 1, 0, 0])
    testes_saida_esperada.append(1)
    
    # Teste 2: Barra vertical meio
    testes_entrada.append([0, 1, 0, 0, 1, 0, 0, 1, 0])
    testes_saida_esperada.append(1)
    
    # Teste 3: Barra vertical direita
    testes_entrada.append([0, 0, 1, 0, 0, 1, 0, 0, 1])
    testes_saida_esperada.append(1)
    
    # Teste 4: Grid parcialmente preenchida (padrão xadrez superior)
    testes_entrada.append([1, 0, 1, 0, 1, 0, 0, 0, 0])
    testes_saida_esperada.append(0)
    
    # Teste 5: Duas barras verticais parciais
    testes_entrada.append([1, 0, 1, 0, 0, 0, 1, 0, 1])
    testes_saida_esperada.append(0)
    
    # Teste 6: Linha horizontal superior
    testes_entrada.append([1, 1, 1, 0, 0, 0, 0, 0, 0])
    testes_saida_esperada.append(0)
    
    # Teste 7: Grid vazia
    testes_entrada.append([0, 0, 0, 0, 0, 0, 0, 0, 0])
    testes_saida_esperada.append(0)
    
    X_teste = np.array(testes_entrada, dtype=float)
    Y_teste = np.array(testes_saida_esperada)
    
    print("\nTestes:")
    predicoes_teste = rede.prever(X_teste)
    
    corretos_teste = 0
    for i, (entrada, esperado, pred) in enumerate(zip(X_teste, Y_teste, predicoes_teste)):
        pred_bin = 1 if pred[0] > 0.5 else 0
        correto = pred_bin == esperado
        corretos_teste += correto
        
        visualizar_grid(entrada, f"Teste {i+1} - Esperado: {esperado}, Previsto: {pred[0]:.2f} ({'Y' if correto else 'N'})")
    
    acuracia_teste = (corretos_teste / len(X_teste)) * 100
    print(f"\nPrecisao nos testes: {acuracia_teste:.1f}% ({corretos_teste}/{len(X_teste)} corretos)")
    
    print("\n" + "=" * 80)
    print("FIM DO ALGORITMO")
    print("=" * 80)


if __name__ == "__main__":
    main()