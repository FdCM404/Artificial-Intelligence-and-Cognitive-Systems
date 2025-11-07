% Explored States 

:- consult(node).

% Implementacao da dos estados explorados.
% Utiliza a biblioteca de hash tables do SWI-Prolog para implementar uma tabela de hash.

% 1 PREDICADO: Cria uma hash table vazia
explored_init(Explored):-
    ht_new(Explored). 

% 2 PREDICADO: % Cria uma hash table vazia e insere o nó
explored_init(Explored,Node):- 
    explored_init(Explored),
    explored_insert(Explored,Node).

% 3 PREDICADO: Verifica se o nó está na tabela de explorados
explored_get(Explored, Node, NodeExp):-
    node_state(Node, State),
    ht_get(Explored, State, NodeExp).

% 4 PREDICADO: Insere o nó na hash table
explored_insert(Explored,Node):-
    node_state(Node, State),
    ht_put(Explored, State, Node).

% 5 PREDICADO: Verifica se o nó já foi explorado
explored_check(Node,Explored):-
    explored_get(Explored,Node,NodeExp), % Verifica se o nó está na tabela de explorados
    node_g(Node, G),
    node_g(NodeExp, GExp),
    G >= GExp. % Se o custo do nó for maior ou igual ao custo do nó explorado, considera-o explorado

% 6 PREDICADO: Enumera os nos explorados
% ht_gen(+HT, ?Key, ?Value) : "True when Key-Value is in HT. Pairs are enumerated on backtracking using the hash table order."
explored_enumerate(Explored, Node):-
    ht_gen(Explored, Node, _).

% 7 PREDICADO: Mostra os nós explorados (para debug)
explored_show(Explored):-
    forall(explored_enumerate(Explored, Node)),
    format('Explored Node: ~w~n', [Node]).
