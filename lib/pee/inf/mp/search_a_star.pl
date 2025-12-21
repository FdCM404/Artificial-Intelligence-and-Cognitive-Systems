% Procura A*
% f(n) = g(n) + h(n)
%
:-consult(bsf_search).

check_func(Node, F):-
    node_g(Node, G),
    node_state(Node, State),
    heuristic(State, H),
    % F = G + H.
    F is G + H.

% "Parecido ao dijkstra mas usa um heuristica para dizer que estamos mais prox do obj"
