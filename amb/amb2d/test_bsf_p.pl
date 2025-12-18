:- encoding(utf8).

% Liga o problema do ambiente 2D e a procura Melhor-Primeiro Parcial
:- consult('problema_amb2d').
:- consult('../../lib/pee/inf/mp/bsf_p_search').

% --- Wrappers de integração entre o problema e a biblioteca de procura ---
% base_search usa transition/4; o problema expõe transicao/4
transition(S1, S2, Op, Cost) :- transicao(S1, S2, Op, Cost).

% bsf_search espera goal/1; o problema expõe objectivo/1
goal(S) :- objectivo(S).

% bsf_p precisa de heurística; o problema expõe heuristica/2
heuristic(S, H) :- heuristica(S, H).

% base_search usa explored/2; estados explorados expõe explored_check/2
explored(Node, Explored) :- explored_check(Node, Explored).

% Função de avaliação (tipo Greedy - só heurística)
check_func(Node, F) :-
    node_state(Node, State),
    heuristic(State, H),
    F = H.

% --- Runner simples para testar no ambiente ---
% Gera as transições, corre Melhor-Primeiro Parcial e mostra caminho.

teste :-
    iniciar_ambiente(8),               % gera transições com 8 movimentos (inclui diagonais)
    inicio(Init),                      % estado inicial do problema
    MaxDepth = 72,                     % profundidade máxima de exploração
    format('\n=== Iniciando Melhor-Primeiro Parcial ===\n'),
    format('Estado inicial: ~w\n', [Init]),
    format('Profundidade máxima: ~w\n', [MaxDepth]),
    solve(Init, Explored, FinalNode, MaxDepth), % corre procura com limite de profundidade
    solution(FinalNode, Path),         % obtém caminho como lista [Estado-Accao,...]
    format('\n=== Melhor-Primeiro Parcial concluído ===\n'),
    node_state(FinalNode, GoalState),
    format('Estado objetivo: ~w\n', [GoalState]),
    node_depth(FinalNode, Depth),
    format('Profundidade alcançada: ~w\n', [Depth]),
    mostrar_ambiente(Path),            % desenha ambiente com movimentos
    format('Caminho (Estado-Accao): ~w\n', [Path]).

% Alias conveniente
run :- teste.
