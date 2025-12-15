:- consult("../../lib/pee/inf/hc/hc").
:- consult("../../lib/pee/inf/hc/hcr").
:- consult("prob_travelling_salesman").
:- consult("tab_travelling_salesman").

first_test_hc :-
    write("Teste 1: Hill Climbing com 50 iteraçoes"), nl, nl,
    % InitState = [a, b, c, d, e, f],
    InitState = [a, b, c, d],
    write("Estado inicial: "), show_route(InitState), nl,
    hc(InitState, Solucao, 50),
    write("SOLUCAO ENCONTRADA: "), show_route(Solucao), nl.

second_test_hc :-
    write("Teste 2: Hill Climbing com 100 iteracoes"),nl, nl,
    % InitState = [a, b, c, d, e, f],
    InitState = [a, b, c, d],
    write("Estado inicial: "), show_route(InitState), nl,
    hc(InitState, Solucao, 100),
    write("SOLUCAO ENCONTRADA: "), show_route(Solucao), nl.

first_test_hcr :-
    write("Teste 1: HCR com 100 iteracoes e 200 repeticoes"),nl, nl,
    InitState = [a, b, c, d],
    write("Estado inicial: "), show_route(InitState), nl,
    hcr(InitState, Solucao, 100, 200),
    write("HCR com reinícios aleatórios:"), show_route(Solucao), nl.





% Menu de ajuda para cada instruçao
help :-
    format("** COMANDOS DISPONVEIS **~n"),
    format("first_test_hc.          - HC com 50 iteracoes~n"),
    format("second_test_hc.         - HC com 100 iteracoes~n"),
    
    format("first_test_hcr.         - HCR com 100 iteracoes~n"),
%    format("second_test_hcr.        - HCR com 200 iteracoes~n"),
    format("show_map.            - Mostra o mapa e as distancias~n").
    

:- help.
