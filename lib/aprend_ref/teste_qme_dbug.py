from ambiente_labirinto import AmbienteLabirinto
from memoria_esparsa import MemoriaEsparsa
from e_greedy import EGreedy
from qme import QME
import random

def testar_qme_debug():

    # Inicialização do ambiente
    ambiente = AmbienteLabirinto()
    accoes = ambiente.obter_accoes()  # lista de ações disponíveis

    # Parâmetros QME 
    alfa = 0.5
    gama = 0.9
    epsilon = 0.2
    num_sim = 20
    dim_max = 300
    num_episodios = 50  # menos episódios para debug rápido

    # Memória e seletor de ação 
    mem_aprend = MemoriaEsparsa()
    sel_accao = EGreedy(mem_aprend, accoes, epsilon)

    # Agente QME
    agente = QME(mem_aprend, sel_accao, alfa, gama, num_sim, dim_max)

    print("\n=== QME ===\n")
    recompensas_totais = []

    for ep in range(num_episodios):
        estado = ambiente.reiniciar()
        terminado = False
        total_recompensa = 0
        passos = 0

        print(f"\n--- Episódio {ep+1} ---\n")

        while not terminado:
            passos += 1

            # Seleção de ação com debug
            r_rand = random.random()
            accao = sel_accao.seleccionar_accao(estado)
            if r_rand < sel_accao._epsilon:
                print(f"[DEBUG] Explorar (r={r_rand:.2f}) -> ação escolhida: {accao}")
            else:
                print(f"[DEBUG] Aproveitar (r={r_rand:.2f}) -> ação escolhida: {accao}")

            # Executar ação no ambiente
            novo_estado, recompensa, terminado = ambiente.executar_accao(accao)
            print(f"[DEBUG] Estado atual: {estado} | Novo estado: {novo_estado} | Recompensa: {recompensa:.2f} | Terminado: {terminado}")

            # Atualização Q + experiência replay
            q_antigo = mem_aprend.Q(estado, accao)
            agente.aprender(estado, accao, recompensa, novo_estado)
            q_novo = mem_aprend.Q(estado, accao)
            print(f"[DEBUG] Q({estado},{accao}): {q_antigo:.2f} -> {q_novo:.2f}")

            # Debug experience replay
            amostra = agente.memoria_experiencia.amostrar(5)
            print(f"[DEBUG] Replay: {len(amostra)} experiências amostradas")
            for (s, a, r, sn) in amostra:
                print(f"        s={s}, a={a}, r={r:.2f}, sn={sn}")

            total_recompensa += recompensa
            estado = novo_estado

        recompensas_totais.append(total_recompensa)
        print(f"[DEBUG] Episódio {ep+1} concluído | Passos: {passos} | Recompensa total: {total_recompensa:.2f}")

    # Construção da política final 
    politica = {}
    for i in range(ambiente.tamanho):
        for j in range(ambiente.tamanho):
            estado = (i, j)
            try:
                politica[estado] = sel_accao.max_accao(estado)
            except:
                pass

    
    ambiente.visualizar(politica)
    print("=== QME CONCLUÍDO ===\n")

if __name__ == "__main__":
    testar_qme_debug()
