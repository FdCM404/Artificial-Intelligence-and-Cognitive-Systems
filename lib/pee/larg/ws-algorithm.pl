% WS - Width search / BFS - Breadth-First Search
% Procura em Largura


% A clausula 'ActionTaken' corresponde ao operador (ação)
% findall(+Template, +Goal, -Bag): Cria uma lista Bag com todas as instâncias de Template que satisfazem Goal. 
%   Unificando variáveis conforme necessário. Sucede com uma lista vazia se Goal nao tiver soluçoes.

% No BFS temos uma lista de caminhos (Paths - fronteira de exploração). 
% Cada caminho representa uma sequencia de estados percorridos desde o estado inicial até o estado atual.

%                                           EXPLICAÇAO DO PRIMEIRO PREDICADO:
% "Pega no primeiro caminho da fronteira, expande-o, adiciona os caminhos sucessores ao fim da fronteira e continua."

% Paths = [OldPath | OtherPaths], :
%   Paths é a lista de caminhos ainda por explorar.   
%   O primeiro caminho (OldPath) é o mais antigo porque o BFS assemelha-se uma fila (FIFO).
%   OtherPaths são os restantes caminhos na "fila"
% 
% Tendo em conta o grafo do slide "Raciocinio Automatica PT2" pex: Path[2-right, 0-none] entao State=2 e ActionTaken=right

% A clausula findall(---) é usada para gerar todos os novos caminhos sucessores que saem do estado atual.
% O predicado sucessor/3:
%   Usa as regras transition/3 para descobrir os estados seguintes.
%   Cria um novo caminho (NextPath) adicionando o novo estado ao inicio do caminho atual.

% Primeiro predicado:
bfs_search(Paths, FinalPath) :-

    Paths = [OldPath | OtherPaths],
    Path = [CurrState-ActionTaken|_],
    % format("1ST : Current State ~w with Action ~w~n", [CurrState, ActionTaken]), % So para debug

    findall(NextPath, sucessor(OldPath, OtherPaths, NextPath), NextPaths),

    length(NextPaths, N),

    append(OtherPaths, NextPaths, NewPaths),

    bfs_search(NewPaths, FinalPath).

% Segundo predicado:
sucessor([Node|RestOfPath], Paths, NewPath) :-
    Node = CurrState-_,
    transition(CurrState, NextState, ActionTaken),
    \+ explored(NextState, Paths),
    NewPath = [NextState-ActionTaken, Node | RestOfPath].


% Terceiro predicado:
explored(State, Paths) :-
    member(Path, Paths),
    member(State-_, Path).


% Quarto predicado:
solve(InitState, Solution) :-
    bfs_search([[InitState-start]], PathReversed),
    reverse(PathReversed, Solution).


% Quinto predicado:
% Se o estado atual for o objetivo, a solucao é encontrada
bfs_search([Path|_], Path) :-
    Path = [CurrState-_|_],
    goal(CurrState).