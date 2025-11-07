% Best Search First (BSF) implementation (PT - Melhor Primeiro)
:- consult(base_search).
% Metodo de procura que utiliza uma avaliaçao de estado baseada no custo para atingir cada estado a partir
% do estado inicial. 
% Utiliza um funcao de custo f(n) >= 0. Pode ser uma estimativa do custo da solucao atraves do nó "n"
% Utiliza uma fronteira ordenada para explorar os nós com menor custo primeiro.

% 1 PREDICADO:
% Cria nó inicial
% Inicia fronteira com prioridade
% Incia nós explorados

init_search(InitState, Frontier, Explored):-
    node_create(InitNode, InitState), % Cria o nó atraves do predicado node_create
    frontier_init(Frontier, InitNode), % Cria a fronteira atravse do predicado frontier_init
    explored_init(Explored, InitNode). % Initialize explored nodes

% 2 PREDICADO:
% Enquanto a fronteira não estiver vazia
    % Remove primeiro nó da fronteira
    % Se o nó for solução, devolve a solução

bsf_search(Frontier, Explored, FinalNode):-
    frontier_get(Frontier, Node, RestFrontier), % Obtem nó da fronteira
    (end_search(Node) -> FinalNode = Node % Verifica se o nó é solução e se for, devolve o nó final
        ;
        continue_search(Node, RestFrontier, Explored, FinalNode) % Se não for, continua a procura
    ).  

% 3 PREDICADO:
% Caso o nó nao seja a soluçao:
        % Expande o nó
        % por cada nó sucessor:
            % Obter estado do nó
            % Se o nó ainda nao foi explorado OU se for melhor:
                % Junta nó aos explorados
                % Junta nó à fronteira
                
continue_search(Node, Frontier, Explored, FinalNode):-
    expand_node(Node, Successor), % Expande o nó
    insert_sucessors(Successor, Frontier, NewFrontier, Explored, NewExplored), % Memoriza os sucessores na fronteira e nos explorados
    bsf_search(NewFrontier, NewExplored, FinalNode).

end_search(Node):-
    node_state(Node, State),
    goal(State). % Verifica se o estado do nó é o objetivo

solve(InitState, Solution):-
    init_search(InitState, Frontier, Explored),
    bsf_search(Frontier, Explored, FinalNode),
    solve(FinalNode,Solution).