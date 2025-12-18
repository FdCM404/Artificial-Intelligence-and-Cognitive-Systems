:- encoding(utf8).

% Liga o problema do ambiente 2D e a procura BFS/WS (Width Search - Breadth-First Search)
:- consult('problema_amb2d').
:- consult('../../lib/pee/not-inf/width/ws_algorithm').

% --- Wrappers de integração entre o problema e a biblioteca de procura ---
% ws_algorithm usa transition/3; o problema expõe transicao/4
% BFS não usa custo, então ignoramos o 4º argumento
transition(S1, S2, Op) :- transicao(S1, S2, Op, _Cost).

% ws_algorithm espera goal/1; o problema expõe objectivo/1
goal(S) :- objectivo(S).

% --- Runner simples para testar no ambiente ---
% Gera as transições, corre BFS e mostra caminho e ambiente.

test :-
    iniciar_ambiente(8),               % gera transições com 8 movimentos (inclui diagonais)
    inicio(Init),                      % estado inicial do problema
    format('\n=== Iniciando BFS/WS ===\n'),
    format('Estado inicial: ~w\n', [Init]),
    solve(Init, Path),                 % corre BFS e obtém caminho como lista [Estado-Operador,...]
    format('\n=== BFS/WS concluído ===\n'),
    Path = [GoalState-_|_],
    format('Estado objetivo: ~w\n', [GoalState]),
    length(Path, NumPassos),
    format('Número de passos: ~w\n', [NumPassos]),
    mostrar_ambiente(Path),            % desenha ambiente com movimentos
    format('Caminho (Estado-Operador): ~w\n', [Path]).

% Alias conveniente
run :- test.
