% Melhor-primeiro parcial

% 1. Estado_Atual = Estado_Inicial
% 2. Enquanto não for objetivo:
%    a) Gera TODOS os sucessores do estado atual
%    b) Avalia cada sucessor
%    c) Escolhe o MELHOR sucessor
%    d) Se melhor que atual → move-se para ele
%    e) Senão → PARA (máximo local)

:- consult(bsf_search).

solve(InitState, Explored, FinalNode, MaxDepth):-
    get_max_depth(MaxDepth),
    init_search(InitState, Frontier, Explored),
    bsf_search(Frontier, Explored, FinalNode).

get_max_depth(MaxDepth):-
    retractall(max_depth(_)),
    assert(max_depth(MaxDepth)).

end_search(Node):-
    max_depth(MaxDepth),
    node_depth(Node, Depth),
    Depth > MaxDepth.