:- encoding(utf8).

% Liga o problema do ambiente 2D e a procura Greedy
:- consult('problema_amb2d').
:- consult('../../lib/pee/inf/mp/greedy').

% --- Wrappers de integração entre o problema e a biblioteca de procura ---
% base_search usa transition/4; o problema expõe transicao/4
transition(S1, S2, Op, Cost) :- transicao(S1, S2, Op, Cost).

% bsf_search espera goal/1; o problema expõe objectivo/1
goal(S) :- objectivo(S).

% greedy espera heuristic/2; o problema expõe heuristica/2
heuristic(S, H) :- heuristica(S, H).

% base_search usa explored/2; estados explorados expõe explored_check/2
explored(Node, Explored) :- explored_check(Node, Explored).

% --- Runner simples para testar no ambiente ---
% Gera as transições, corre Greedy e mostra caminho e ambiente.

test :-
    iniciar_ambiente(8),               % gera transições com 8 movimentos (inclui diagonais)
    inicio(Init),                      % estado inicial do problema
    init_search(Init, F, E),           % fronteira + explorados
    bsf_search(F, E, FinalNode),       % corre procura melhor-primeiro com função Greedy
    solution(FinalNode, Path),         % obtém caminho como lista [Estado-Accao,...]
    format('\n=== Greedy concluído ===\n'),
    format('Estado inicial: ~w\n', [Init]),
    node_state(FinalNode, GoalState),
    format('Estado objetivo: ~w\n', [GoalState]),
    mostrar_ambiente(Path),            % desenha ambiente com movimentos
    format('Caminho (Estado-Accao): ~w\n', [Path]).

