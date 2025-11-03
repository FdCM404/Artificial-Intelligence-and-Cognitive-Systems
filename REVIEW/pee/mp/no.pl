% Modulo Nó: Define o formato do nó e operações relacionadas
% Um nó é representado como Estado-Operador, onde:
%Formato do nó: Estado-NoAntecessor-Operador-Profundidade-G
%NoAntecessor - Nó pai
%Operador - Operador que gerou o nó
% Profundidade - Profundidade do nó na árvore de procura
% G - Custo acumulado do caminho até ao nó
% Load core modules

% Cria um nó inicial a partir do estado inicial
no(Estado-none-none-0-0,Estado).
    
% Cria um novo nó a partir do nó antecessor, do operador que gerou o nó e do custo de transição
% Profundidade é a profundidade do nó antecessor + 1?
no(Estado-NoAnt-Operador-Profundidade-G, Estado, NoAnt, Operador, CustoTrans):-
    no_prof(NoAnt, ProfundidadeAnt),
    no_g(NoAnt, GAnt),
    Profundidade is ProfundidadeAnt + 1,
    G is GAnt + CustoTrans.

% Extrai o estado do nó
no_estado(Estado-_-_-_-_, Estado).
% Extrai o nó antecessor
no_ant(_-NoAntecessor-_-_-_, NoAntecessor).
% Extrai o operador que gerou o nó
no_oper(_-_-Operador-_-_, Operador).
% Extrai a profundidade do nó
no_prof(_-_-_-Profundidade-_, Profundidade).
% Extrai o custo acumulado do nó
no_g(_-_-_-_-G, G).




