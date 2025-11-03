:-consult(procura_mp).
%algoritmo de procura sofrega
avaliar(No,F):-
    no_estado(No, Estado),
    heuristica(Estado, H),
    F = H.
