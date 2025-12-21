#TODO TESTES PARA OUTROS ALGORITMOS DE APRENDIZAGEM / REVER PARTE DAS RECOMPENSAS

from ambiente_labirinto import AmbienteLabirinto
from memoria_esparsa import MemoriaEsparsa
from e_greedy import EGreedy
from q_learning import QLearning
from tipos import Estado, Accao
from typing import Optional

def teste_amb_lab():
    # Teste de Q-Learning no labirinto 9x9 
    
    # Iniciar os parametros de teste
    print("A iniciar parâmetros...")
    alfa = 0.1          # Taxa de aprendizagem
    gama = 0.99         # Fator de desconto
    epsilon = 0.2       # Taxa de exploração
    num_episodios = 500 # Número de episódios
    max_passos = 50     # Máximo de passos por episódio
    
    # Iniciar ambiente
    print("A criar ambiente...")
    ambiente = AmbienteLabirinto()
    accoes = ambiente.obter_accoes()
    
    # Iniciar agente
    print("A iniciar agente Q-Learning...")
    mem_aprend = MemoriaEsparsa(valor_omissao=0.0)
    sel_accao = EGreedy(mem_aprend, accoes, epsilon)
    agente = QLearning(mem_aprend, sel_accao, alfa, gama)
    
    # Treina agente
    print(f"A treinar agente durante {num_episodios} episódios...\n")
    
    episodios_sucesso = 0
    historico_recompensas = []
    
    for episodio in range(num_episodios):
        estado_atual = ambiente.reiniciar()
        recompensa_total = 0
        sucesso = False
        
        for passo in range(max_passos):
    # Agente seleciona ação
            accao = sel_accao.seleccionar_accao(estado_atual)
            
            # Ambiente executa ação
            proximo_estado, recompensa, terminado = ambiente.executar_accao(accao)
            
            # Agente aprende
            agente.aprender(estado_atual, accao, recompensa, proximo_estado)
            
            recompensa_total += recompensa
            estado_atual = proximo_estado
            
            if terminado:
                sucesso = True
                break
        
        if sucesso:
            episodios_sucesso += 1
        
        historico_recompensas.append(recompensa_total)
        
        # Mostrar progresso
        if (episodio + 1) % 30 == 0:
            media_recompensas = sum(historico_recompensas[-30:]) / 30
            print(f"Episódio {episodio + 1}/{num_episodios} - "
                  f"Sucessos: {episodios_sucesso} - "
                  f"Média recompensas (últimos 30): {media_recompensas:.2f}")
    
    print(f"\n{'='*60}")
    print(f"Treinamento completo!")
    print(f"Total de sucessos: {episodios_sucesso}/{num_episodios}")
    print(f"Taxa de sucesso: {(episodios_sucesso/num_episodios)*100:.2f}%")
    print(f"{'='*60}\n")
    
    # Mostra politicas
    print("Extraindo política aprendida...\n")
    politica = _extrair_politica(mem_aprend, sel_accao, ambiente)
    
    # Mostra politicas e labirinto
    print("Visualizando labirinto com política:")
    ambiente.visualizar(politica)
    
    # Teste final (com política greedy pura)
    print("Teste final com e-greedy (melhor ação por estado)...\n")
    
    estado_atual = ambiente.reiniciar()
    caminho = [estado_atual]
    estados_visitados = {estado_atual: 1}
    
    for passo in range(max_passos):
        # Usar max_accao para greedy puro (sem exploração)
        accao = sel_accao.max_accao(estado_atual)
        proximo_estado, _, terminado = ambiente.executar_accao(accao)
        caminho.append(proximo_estado)
        
        # Contar visitas ao estado
        if proximo_estado in estados_visitados:
            estados_visitados[proximo_estado] += 1
        else:
            estados_visitados[proximo_estado] = 1
        
        # Detectar loop (se um estado é visitado mais de 5 vezes)
        if estados_visitados[proximo_estado] > 5:
            print(f"Aviso: Agente preso num loop ... {proximo_estado}") # So para debug
            break
        
        estado_atual = proximo_estado
        
        if terminado:
            break
    
    print(f"Caminho encontrado ({len(caminho)-1} passos):")
    print(f"Início: {caminho[0]} → Fim: {caminho[-1]}")
    print(f"Chegou ao destino: {caminho[-1] == ambiente.estado_final}")
    
    if len(caminho) <= 30:
        print(f"Trajetória: {' → '.join([str(pos) for pos in caminho])}")
    else:
        print(f"Trajetória (primeiros 15 passos): {' → '.join([str(pos) for pos in caminho[:15]])}")
        print(f"               ... (últimos 15 passos): {' → '.join([str(pos) for pos in caminho[-15:]])}")
    print()

def _extrair_politica(mem_aprend, sel_accao, ambiente):

    politica = {}
    
    for i in range(ambiente.tamanho):
        for j in range(ambiente.tamanho):
            if ambiente.pos_valida(i, j):
                estado = (i, j)
                # Obter melhor ação para este estado (sem aleatoriedade)
                accoes = ambiente.obter_accoes()
                
                if not accoes:
                    continue
                
                # Encontrar a ação com maior Q-value
                melhor_accao = accoes[0]
                melhor_valor = mem_aprend.Q(estado, accoes[0])
                
                for accao in accoes[1:]:
                    valor = mem_aprend.Q(estado, accao)
                    if valor > melhor_valor:
                        melhor_valor = valor
                        melhor_accao = accao
                
                politica[estado] = melhor_accao
    
    return politica

if __name__ == "__main__":
    teste_amb_lab()
