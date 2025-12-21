from ambiente_labirinto import AmbienteLabirinto
from memoria_esparsa import MemoriaEsparsa
from e_greedy import EGreedy
from qme import QME

def testar_qme():

    # Iniciar o ambiente 
    ambiente = AmbienteLabirinto()
    accoes = ambiente.obter_accoes()  # lista de ações disponíveis

    # Parâmetros do QME 
    alfa = 0.5
    gama = 0.9
    epsilon = 0.2
    num_sim = 20
    dim_max = 300
    num_episodios = 200

    # Memória e seletor de ação 
    mem_aprend = MemoriaEsparsa()
    sel_accao = EGreedy(mem_aprend, accoes, epsilon)

    # Agente QME 
    agente = QME(mem_aprend, sel_accao, alfa, gama, num_sim, dim_max)

    print("\n=== TREINO QME ===\n")
    recompensas_totais = []

    for ep in range(num_episodios):
        estado = ambiente.reiniciar()
        terminado = False
        total_recompensa = 0
        
        while not terminado:
            # Seleção da ação
            accao = sel_accao.seleccionar_accao(estado)

            # Executa ação no ambiente
            novo_estado, recompensa, terminado = ambiente.executar_accao(accao)

            # Aprendizagem QME
            agente.aprender(estado, accao, recompensa, novo_estado)

            estado = novo_estado
            total_recompensa += recompensa

        recompensas_totais.append(total_recompensa)

        # Log de progresso
        if (ep + 1) % 20 == 0:
            media_ultimos = sum(recompensas_totais[-20:]) / 20
            print(f"Episódio {ep+1}/{num_episodios} | Recompensa média últimos 20: {media_ultimos:.2f}")

    # --- Construção da política final ---
    politica = {}
    for i in range(ambiente.tamanho):
        for j in range(ambiente.tamanho):
            estado = (i, j)
            try:
                politica[estado] = sel_accao.max_accao(estado)
            except:
                pass

    # --- Visualização ---
    ambiente.visualizar(politica)
    print("Treino QME concluído.\n")

if __name__ == "__main__":
    testar_qme()
