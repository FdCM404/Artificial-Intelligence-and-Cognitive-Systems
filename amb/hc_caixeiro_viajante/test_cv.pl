% ==
% TESTES PARA O "Travelling Salesman"
% ==

% Carrega o algoritmo Hill Climbing
:- consult('../../lib/pee/inf/hc/hc').
:- consult('../../lib/pee/inf/hc/hcr').

% Carrega o problema do "Travelling Salesman"
:- consult('prob_cv').

% Carrega o tabuleiro (distâncias)
:- consult('tab_cv').


%  TESTE 1: Hill Climbing com 50 iteracoes 
teste1 :-
    write(' TESTE 1: Hill Climbing com 50 iteracoes '), nl, nl,
    EstadoInicial = [a, b, c, d],
    write('Estado inicial: '), mostrar_rota(EstadoInicial), nl,
    hc(EstadoInicial, Solucao, 50),
    write('Solucao encontrada: '), mostrar_rota(Solucao), nl.


%  TESTE 2: Hill Climbing com 100 iteracoes 
teste2 :-
    write(' TESTE 2: Hill Climbing com 100 iteracoes '), nl, nl,
    EstadoInicial = [a, b, c, d],
    write('Estado inicial: '), mostrar_rota(EstadoInicial), nl,
    hc(EstadoInicial, Solucao, 100),
    write('Solucao encontrada: '), mostrar_rota(Solucao), nl.


%  TESTE 3: Hill Climbing com Reinícios (50 iteracoes, 200 repeticoes) 
teste3 :-
    write(' TESTE 3: Hill Climbing com Reinícios (50 iter, 200 rep) '), nl, nl,
    estado_aleat(EstadoInicial),
    write('Estado inicial: '), mostrar_rota(EstadoInicial), nl,
    hcr(EstadoInicial, Solucao, 50, 200),
    write('Solucao encontrada: '), mostrar_rota(Solucao), nl.


%  TESTE 4: Hill Climbing com Reinícios (100 iteracoes, 200 repeticoes) 
teste4 :-
    write(' TESTE 4: Hill Climbing com Reinícios (100 iter, 200 rep) '), nl, nl,
    random_permutation([a, b, c, d], EstadoInicial),
    write('Estado inicial: '), mostrar_rota(EstadoInicial), nl,
    hcr(EstadoInicial, Solucao, 100, 200),
    write('Solucao encontrada: '), mostrar_rota(Solucao), nl.


%  INSTRUÇÕES 

ajuda :-
    write(' COMANDOS DISPONÍVEIS '), nl,
    write('teste1.          - Hill Climbing 50 iteracoes'), nl,
    write('teste2.          - Hill Climbing 100 iteracoes'), nl,
    write('teste3.          - HCR 50 iteracoes, 200 repeticoes'), nl,
    write('teste4.          - HCR 100 iteracoes, 200 repeticoes'), nl,

    write('mostrar_mapa.    - Ver distancias entre cidades'), nl,
    write('ajuda.           - Mostrar esta mensagem'), nl.

% Mostra ajuda ao carregar
:- ajuda.

% Corre o teste do hc e do hcr

:- teste1. 
:- teste3.