:- consult("../../lib/pee/inf/hc/hc").
% :- consult("../../lib/pee/inf/hc/hcr").
:- consult("prob_travelling_salesman").
:- consult("tab_travelling_salesman").

show_map :- !.

first_test :-
    write("Teste 1: Hill Climbing com 50 iteraçoes"), nl, nl,
    InitState = [a,b,c,d,e,f],
    write("Estado inicial: "), show_route(InitState), nl,
    hc(InitState, Solution, 50),
    write("SOLUCAO ENCONTRADA: "), show_route(Solucao), nl.

% second_test:
% 
% third_test:
% 
% all_tests:

% Menu de ajuda para cada instruçao
help :-
    format("** COMANDOS DISPONVEIS **~n"),
    format("first_test.          - HC com 50 iteracoes~n"),
    format("second_test.         - HC com 100 iteracoes~n"),
    format("third_test.          - Analise detalhada~n"),
    format("show_map.            - Mostra o mapa e as distancias~n").

:- help.
