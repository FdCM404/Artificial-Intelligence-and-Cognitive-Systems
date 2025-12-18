% DFS - Depth First Search 
% Algoritmo de Procura em Profundidade

% O Nó será representado através do seu 'Estado' e do 'Operador'
% Estado - Posição atual no grafo
% Operador - acao que levou ao estado presente (none para o estado inicial)
%
% No: Estado - Operador

% O caminho será uma clausula que representa uma lista de nós: [Estado-Operador | RestoCaminho]
%	O primeiro elemento é o NÓ mais recente (top-of-stack)
%	Os restantes elementos sao os nós anteriores (já expandidos)

% Primeiro predicado: Caso base - Se o estado atual for o objetivo, a solucao é encontrada.
dfs_search(CurrPath, CurrPath) :-
	CurrPath = [CurrState-_|_],
	goal(CurrState).

% Segundo predicado: Caso geral - Expande o nó e explora imediatamente
dfs_search(CurrPath, FinalPath) :-
	expand_current_node(CurrPath, PathWithNewNode), % Gera UM sucessor
	dfs_search(PathWithNewNode, FinalPath).		% Explora-o imediatamente

% Terceiro predicado:
% 	Usa a clausula "expand_current_node" para encontrar um estado sucessor possivel
% 	Extrai o estado atual do nó (no top-of-stack)
% 	Retorna um sucessor de cada vez
% 		Cria um novo caminho com o sucessor adicionado no inicio
% 		Este novo caminho "NovoCaminho" é o que será explorado a seguir
%
% 		ActionTaken => Operador
%
expand_current_node([CurrNode|PrevNodes], NewPath) :-
	CurrNode = CurrState-_,
	transition(CurrState, NextState, ActionTaken),
	\+ already_visited(NextState, [CurrNode|PrevNodes]),
	NewPath = [NextState-ActionTaken, CurrNode | PrevNodes].

% Quarto predicado:
% Verifica se um estado ja foi visitado no caminho atual para previnir ciclos
already_visited(State, PathSoFar) :-
	member(State-_, PathSoFar).

% Quinto predicado:
% Inicia a procura e retorna a solucao na ordem correta.
solve(InitState, Solution):-
	dfs_search([InitState-start], PathReversed),
	reverse(PathReversed, Solution).
