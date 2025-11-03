:-consult(procura_mp).
%algoritmo de procura A*
avaliar(No,F):-
    no_g(No, G),
    no_estado(No, Estado),
    heuristica(Estado, H),
    F is G + H.