% Procura sofrega
% Nao tem conta o custo do percurso explorado
% Minimizaçao de custo local
:- consult(bsf_search).

% Escolhe o nó que parece mais próximo do objetivo, segundo uma estimativa (h(n)).
check_func(Node, F) :-
    node_state(Node, State),
    heuristic(State, H),
    F = H.