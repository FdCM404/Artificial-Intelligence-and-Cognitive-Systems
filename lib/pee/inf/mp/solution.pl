% solution search file
:- consult(node).

% 1 PREDICADO: solution(+Node, )
solution(Node, Solution) :-
    solution_get(Node, [], Solution).

% 2 PREDICADO: solution_get(+Node, +Path, -Solution)
% Neste caso, se nao existir nó antecessor
solution_get(Node, Path, Path) :-
    node_prev(Node, none),
    !.

% 3 PREDICADO : solution_get(+Node, +Path, -Solution)
solution_get(Node, Path, Solution) :-
    node_prev(Node, PrevNode), % Extrai o nó antecessor
    node_state(PrevNode, PrevState), % Extrai o estado do nó antecessor
    node_action(Node, ActionTaken), % Extrai o operador que gerou o nó
    NewPath = [PrevState-ActionTaken|Path], % Adiciona o estado e operador ao caminho
    solution_get(PrevNode, NewPath, Solution). % Chama recursivamente para o nó antecessor