% Procura de Custo uniforme
:- consult(bsf_search).

check_func(Node, F):-
    node_g(Node, G),
    F = G.