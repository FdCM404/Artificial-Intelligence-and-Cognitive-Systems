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
%   Garante que o novo estado nao foi explorado antes (verifca com explored/2).
%
% ------------------------------------------------

% Primeiro predicado:
% Se o estado atual for o objetivo, a solucao é encontrada
bfs_search([Path|_], Path) :-
    Path = [CurrState-_|_], % Unifica CurrState com o estado atual do caminho
    goal(CurrState).

% Depois da primeira iteraçao completa ja com a obtençao dos NextPaths (no caso, 0_to_1 e 0_to_2) ele vai extrair 
% o primeiro caminho da lista, expandilo e adiciona ao fim da lista dos oldpaths
% Segundo predicado:
bfs_search(Paths, FinalPath) :-

    Paths = [OldPath | OtherPaths],
    OldPath = [CurrState-ActionTaken|_],
    format("1ST : Current State ~w with Action ~w~n", [CurrState, ActionTaken]), % So para debug
    format("1ST : Old Path ~w~n", [OldPath]), % So para debug

% Gera todas as solucoes possiveis apenas para o currState onde se encontra.
% Gera todas as solucoes possiveis de sucessor([0-_],[], X)]) e guarda na lista X
    findall(NextPath, sucessor(OldPath, OtherPaths, NextPath), NextPaths), % OldPath unificado com o valor do CurrState (1* iteraçao)
    % format("1ST : Next Paths ~w~n", [NextPaths]), % So para debug

    length(NextPaths, N),

    append(OtherPaths, NextPaths, NewPaths), % primeira iter: unifica NextPaths com newPaths
    % format("2ND : New Paths ~w~n", [NewPaths]), % So para debug
    bfs_search(NewPaths, FinalPath).

% Terceiro predicado:
sucessor([Node|RestOfPath], Paths, NewPath) :-
    Node = CurrState-_,
    format("3RD : Node ~w and CurrState ~w~n", [Node, CurrState]), % So para debug
    transition(CurrState, NextState, ActionTaken), % "Do estado atual posso ir para o seguinte atraves da açao"
    \+ explored(NextState, Paths), % Negaçao por falha, sera sucessful na primeira iteraçao (devido ao "\+")
    NewPath = [NextState-ActionTaken, Node | RestOfPath],
    format("3RD : New Path ~w~n", [NewPath]). % So para debug

% Quarto predicado:
explored(State, Paths) :-
    member(Path, Paths),
    member(State-_, Path).
% Vai falhar na primeira iteraçao se o objetivo nao estiver no primeiro caminho. 
% No caso do ws-testing.pl ha de aparecer que o estado 1 nao foi explorado ainda (apos ele entrar no predicado sucessor/3 e verificar o facto encontrado na transiçao 0->1)

% Quinto predicado:
%   Cada caminho é uma lista de pares Estado-Ação.
%   No iniciao nao ha acao, entao é "start"
solve(InitState, Solution) :-
    bfs_search([[InitState-Start]], PathReversed),
    reverse(PathReversed, Solution).


