% ---------------------------------------------------------------
% Ficheiro de teste unitário para dfs_algorithm.pl - Francisco Mendes
% ---------------------------------------------------------------

:- consult(dfs_algorithm).

% ---------------------------------------------------------------
% Definição do grafo de teste
% Exemplo utilizado nos slides em aula
% ---------------------------------------------------------------

transition(0, 1, '0_to_1').
transition(0, 2, '0_to_2').

transition(1, 3, '1_to_3').
transition(1, 6, '1_to_6').

transition(2, 4, '2_to_4').

transition(4, 3, '4_to_3').

transition(3, 2, '3_to_2').
transition(3, 5, '3_to_5').

transition(5, 4, '5_to_4').
transition(5, 6, '5_to_6').


% ---------------------------------------------------------------
% Estado objetivo
% ---------------------------------------------------------------

goal(4).

% ---------------------------------------------------------------
% Testes simples
% ---------------------------------------------------------------

% Teste 1: encontrar caminho de '0' até '4'
test_dfs_basic :-
    solve(0, Solution),
    format("Solucao encontrada: ~w~n", [Solution]).

% Teste 2: verificar que o primeiro estado é o inicial
test_dfs_start :-
    solve(0, [Init-_|_]),
    Init == 0.

% Teste 3: verificar que o último estado é o objetivo
test_dfs_goal :-
    solve(0, Solution),
    last(Solution, Goal-_),
    goal(Goal).

% ---------------------------------------------------------------
% Execução automática dos testes
% ---------------------------------------------------------------

run_tests :-
    format("~n=== Teste 1: Caminho basico ===~n", []),
    test_dfs_basic,
    format("~n=== Teste 2: Estado inicial ===~n", []),
    (test_dfs_start -> writeln('OK'); writeln('Falhou')),
    format("~n=== Teste 3: Estado objetivo ===~n", []),
    (test_dfs_goal -> writeln('OK'); writeln('Falhou')).

:- run_tests. 