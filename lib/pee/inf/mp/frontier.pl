% Frontier (PT- Fronteira de Exploração)

% Implementacao da fronteira.
% Utiliza a biblioteca de heaps do SWI-Prolog para implementar uma fila de prioridade

% 1 PREDICADO: 
% Recorre ao uso do singleton_heap(?Heap, ?Key, ?Value) : "True if Heap is a heap with the single elem Key-Value"
frontier_init(Frontier, Node):-
    singleton_heap(Frontier,0, Node). % Inicializa a fronteira com o nó inicial e prioridade 0

% 2 PREDICADO: get_from_heap(?Heap0, ?Key, ?Value, -Heap)
frontier_get(Frontier, Node, RestFrontier):-
    get_from_heap(
        Frontier,
        _,
        Node,
        RestFrontier).

% 3 PREDICADO: add_to_heap(+Heap0, +Key, ?Value, -Heap): "Adds Value with priority Key to Heap0, constructing a new heap in Heap."
% O objetivo do predicado é inserir um nó na fronteira com uma prioridade dada pela função de avaliação Function.
frontier_insert(Frontier, Function, Node, NewFrontier):-
    add_to_heap(Frontier, Function, Node, NewFrontier).
