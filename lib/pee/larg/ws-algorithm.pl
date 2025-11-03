% WS - Width search / BFS - Breadth-First Search
% Procura em Largura

% 
% A clausula 'ActionTaken' corresponde ao operador (ação)
% findall()
%

% Primeiro predicado:
bfs_search(Paths, FinalPath) :-
    Paths = [CurrPath | OtherPaths],
    Path = [CurrState-ActionTaken|_],
    findall()

% Quinto predicado:
% Se o estado atual for o objetivo, a solucao é encontrada
bfs_search([Path|_], Path) :-
    Path = [CurrState-_|_],
    goal(CurrState).




% procura_larg(Caminhos,CaminhoFinal):-
%     Caminhos = [Caminho|RestoCaminhos],
%     Caminho = [Estado-Operador|_],
%     format('→ Explorando: ~w (operador: ~w)~n', [Estado, Operador]),
%     findall(CaminhoSuc,
%             sucessor(Caminho,Caminhos,CaminhoSuc),
%             CaminhosSuc
%     ),
%     length(CaminhosSuc, N),
%     format('  Gerados ~w sucessores~n', [N]),
%     append(RestoCaminhos,CaminhosSuc,NovoCaminhos),
%     procura_larg(NovoCaminhos,CaminhoFinal).
% 
% sucessor([No|RestoCaminho],Caminhos,CaminhoSuc):-
%     No = Estado-_,
%     transicao(Estado,EstadoSuc,Operador),
%     \+ explorado(EstadoSuc,Caminhos),
%     CaminhoSuc = [EstadoSuc-Operador , No | RestoCaminho].
% 
% explorado(Estado, Caminhos):-
%     member(Caminho,Caminhos),
%     member(Estado-_, Caminho).
% 
% resolver(EstadoInicial, Solucao):-
%     format('~n=== PROCURA EM LARGURA ===~nInicio: ~w~n~n', [EstadoInicial]),
%     procura_larg([[EstadoInicial-none]],Caminho),
%     reverse(Caminho,Solucao).


