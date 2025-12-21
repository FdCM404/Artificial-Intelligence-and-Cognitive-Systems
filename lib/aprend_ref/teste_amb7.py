from ambiente7 import Ambiente, Accao
from memoria_esparsa import MemoriaEsparsa
from e_greedy import EGreedy
from sarsa import SARSA
from q_learning import QLearning
from mec_apr_ref import MecAprendRef
from typing import Optional
import random

def run_teste(algoritmo="SARSA", n_episodios=50, max_passos=100, seed=0, posicao_inicial=3):
    
    random.seed(seed)

    ambiente = Ambiente(posicao_inicial)
    accoes = [Accao.ESQ, Accao.DIR]
    mem_esparsa = MemoriaEsparsa(0)
    e_greedy = EGreedy(mem_esparsa, accoes, epsilon=0.1)

    if algoritmo.upper() == "SARSA":
        aprend_ref = SARSA(mem_esparsa, e_greedy, 0.1, 0.9)
    elif algoritmo.upper() == "QLEARNING":
        aprend_ref = QLearning(mem_esparsa, e_greedy, 0.1, 0.9)
    else:
        raise ValueError("Algoritmo desconhecido: use SARSA ou QLEARNING")

    mec_aprend_ref = MecAprendRef(mem_esparsa, e_greedy, aprend_ref, accoes)

    passos_por_episodio = []
    recompensas_por_episodio = []

    for ep in range(n_episodios):
        s = ambiente.reiniciar()
        a = mec_aprend_ref.seleccionar_accao(s)
        recompensa_acumulada = 0.0
        passos = 0
        objetivo = False
        while not objetivo:
            ambiente.actual(a)
            sn, r = ambiente.observar()
            recompensa_acumulada += r
            passos += 1
            objetivo = (r != 0)
            if objetivo:
                mec_aprend_ref.aprender(s, a, r, sn, None)
                break
            an = mec_aprend_ref.seleccionar_accao(sn)
            mec_aprend_ref.aprender(s, a, r, sn, an)
            s, a = sn, an

        passos_por_episodio.append(passos)
        recompensas_por_episodio.append(recompensa_acumulada)

    print(f"\nAlgoritmo: {algoritmo}")
    print(f"Episódios: {n_episodios}, Max passos por episódio: {max_passos}")
    print(f"Passos médio: {sum(passos_por_episodio) / len(passos_por_episodio):.1f}")
    print(f"Recompensa média: {sum(recompensas_por_episodio) / len(recompensas_por_episodio):.2f}")
    print(f"\nPassos por episódio: {passos_por_episodio}")
    print("\nValores de estado V(s) = max_a Q(s,a):")
    memoria = mec_aprend_ref._mem_aprend
    for estado in range(ambiente.dim_amb):
        v_s = max(memoria.Q(estado, a) for a in accoes)
        melhor_accao = max(accoes, key=lambda a: memoria.Q(estado, a))
        print(f"  V({estado}) = {v_s:.4f}  (ação: {melhor_accao})")

if __name__ == "__main__":
    print("Escolha o algoritmo (SARSA ou QLEARNING): ", end="")
    alg = input().strip().upper()
    if alg not in ("SARSA", "QLEARNING"):
        alg = "SARSA"
    run_teste(algoritmo=alg)