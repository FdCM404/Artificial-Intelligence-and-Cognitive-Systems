:- consult(node).
:- consult(frontier).
:- consult(exp_states).
:- consult(solution).

expand_node(Node, Successors):-
    findall(NextNode, successor(Node, NextNode), Successors). % Finds all successors of the node

successor(Node, NextNode):-
    node_state(Node, CurrState),
    transition(CurrState, NextState, Operator, ActionCost), 
    node_create(NextNode, NextState, Node, Operator, ActionCost). % Creates the successor node

% 3 PREDICADO: Objetivo de filtrar e adicionar os sucessores validos à fronteira, evitando 
%               explorar estados redundantes ou subótimos, otimizando a procura.
insert_sucessors([], Frontier, Frontier, _). % Se não houver sucessores, a fronteira mantém-se igual

% 4 PREDICADO
insert_sucessors([NextNode|NextNodes], Frontier, NewFrontier, Explored):-
    explored(NextNode, Explored), % Verifica se o nó sucessor já foi explorado
    insert_sucessors(NextNodes, Frontier, NewFrontier, Explored).

% 5 PREDICADO
insert_sucessors([NextNode|NextNodes], Frontier, NewFrontier, Explored):-
    check_func(NextNode, F), % Avalia se o nó sucessor deve ser adicionado à fronteira
    frontier_insert(Frontier, F, NextNode, FrontierNext), % Insere o nó sucessor na fronteira
    explored_insert(Explored, NextNode), 
    insert_sucessors(NextNodes, FrontierNext, NewFrontier, Explored).

% 5 PREDICADO: Verifica se o nó já foi explorado
explored_check(Node,Explored):-
    explored_get(Explored,Node,NodeExp), % Verifica se o nó está na tabela dos nos explorados
    node_g(Node, G),
    node_g(NodeExp, GExp),
    G >= GExp. % Se o custo do nó for maior ou igual ao custo do nó explorado, considera-o explorado