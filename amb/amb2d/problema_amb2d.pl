:-consult('amb/simul_amb').
transicao(Estado, NovoEstado, Accao, CustoTrans):-
    transicao_valida(Estado, NovoEstado, Accao),
    distancia(Estado, NovoEstado, CustoTrans).

inicio(Estado):-
    posicao_inicial(Estado).

objectivo(Estado):-
    alvos([Estado|_]).

heuristica(Estado, H):-
    objectivo(EstadoObjetivo),
    distancia(Estado, EstadoObjetivo, H).