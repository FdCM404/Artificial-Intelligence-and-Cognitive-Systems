% Este modulo tem como objetivo de definir como apresentamos o "nó".

% Node = State-ActionTaken

% Definiçao nova do nó (procura informada):

    % Node = State-PreviousNode-ActionTaken-Depth-G
        % State - Estado atual do nó
        % PreviousNode - Nó pai
        % ActionTaken - Ação que gerou o nó (operador)
        % Depth - Profundidade do nó na árvore de procura
        % G - Custo acumulado do caminho até ao nó

% 1 PREDICADO: Cria um nó inicial a partir do "CurrentState" (ou do estado inicial)
node_create(CurrState-none-none-0-0, CurrState).

% 2 PREDICADO: Cria um novo nó a partir do nó antecessor, do operador que gerou o nó e do custo da açao (operador)
            % A Profundidade é calculada com um incremento em relaçao à profundidade do nó anterior
node_create(CurrState-PrevNode-ActionTaken-Depth-G, CurrState, PrevNode, ActionTaken, ActionCost):-
    node_depth(PrevNode, PrevDepth),
    node_g(PrevNode, PrevG),
    Depth is PrevDepth + 1,
    G is PrevG + ActionCost.

% 3 PREDICADO: Extrai o estado do nó
node_state(CurrState-_-_-_-_, CurrState).

% 4 PREDICADO: Extrai o nó antecessor
node_prev(_-PrevNode-_-_-_, PrevNode).

% 5 PREDICADO: Extrai o operador que gerou o nó
node_action(_-_-ActionTaken-_-_, ActionTaken).

% 6 PREDICADO: Extrai a profundidade do nó
node_depth(_-_-_-Depth-_, Depth).

% 7 PREDICADO: Extrai o custo acumulado do nó
node_g(_-_-_-_-G, G).
