:- encoding(utf8).

% Liga o problema do ambiente 2D e a procura DFS (Depth-First Search)
:- consult('problema_amb2d').
:- consult('../../lib/pee/not-inf/depth/dfs_algorithm').

% --- Wrappers de integração entre o problema e a biblioteca de procura ---
% dfs_algorithm usa transition/3; o problema expõe transicao/4
% DFS não usa custo, então ignoramos o 4º argumento
transition(S1, S2, Op) :- transicao(S1, S2, Op, _Cost).

% dfs_algorithm espera goal/1; o problema expõe objectivo/1
goal(S) :- objectivo(S).

% --- Runner simples para testar no ambiente ---
% Gera as transições, corre DFS e mostra caminho e ambiente.

test :-
    iniciar_ambiente(8),
    inicio(Estado),
    solve(Estado, Solucao) ->
        (
            format('~n=== SOLUCAO FINAL ===~n'),
            mostrar_ambiente(Solucao)
        ) ; 
        writeln('Solução não encontrada').

% Alias conveniente
run :- test.
