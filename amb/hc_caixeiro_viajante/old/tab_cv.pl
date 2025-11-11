% ===============================================
% TABULEIRO DO CAIXEIRO VIAJANTE
% ===============================================
% Define as cidades e distâncias entre elas
% ===============================================

% === EXEMPLO 1: Problema Pequeno (4 cidades) ===

% Distâncias entre cidades
% Forma um "quadrado" com diagonais
distancia(a, b, 10).
distancia(a, c, 15).
distancia(a, d, 20).
distancia(b, c, 35).
distancia(b, d, 25).
distancia(c, d, 30).

% Torna as distâncias simétricas
distancia(X, Y, D) :- 
    X \= Y,
    distancia(Y, X, D).

% Distância de uma cidade para ela mesma é 0
distancia(X, X, 0).


% === EXEMPLO 2: Problema Médio (5 cidades) ===
% Descomenta para testar com mais cidades

/*
distancia(a, b, 12).
distancia(a, c, 10).
distancia(a, d, 19).
distancia(a, e, 8).
distancia(b, c, 3).
distancia(b, d, 7).
distancia(b, e, 6).
distancia(c, d, 2).
distancia(c, e, 20).
distancia(d, e, 4).

distancia(X, Y, D) :- 
    X \= Y,
    distancia(Y, X, D).

distancia(X, X, 0).
*/


% === EXEMPLO 3: Problema Maior (6 cidades) ===
% Descomenta para testar com ainda mais cidades

/*


distancia(X, Y, D) :- 
    X \= Y,
    distancia(Y, X, D).

distancia(X, X, 0).
*/


% === INFORMAÇÃO SOBRE O PROBLEMA ===

% Lista todas as cidades do problema atual
cidades(Cidades) :-
    findall(C, (distancia(C, _, _), C \= _), TodasCidades),
    sort(TodasCidades, Cidades).

% Número de cidades
num_cidades(N) :-
    cidades(Cidades),
    length(Cidades, N).

% Mostra o mapa de distâncias
mostrar_mapa :-
    write('=== MAPA DE DISTÂNCIAS ==='), nl,
    cidades(Cidades),
    write('Cidades: '), write(Cidades), nl, nl,
    mostrar_distancias(Cidades).

mostrar_distancias([]).
mostrar_distancias([C|Resto]) :-
    forall(
        (member(D, Resto), distancia(C, D, Dist)),
        (write(C), write(' -> '), write(D), write(': '), write(Dist), nl)
    ),
    mostrar_distancias(Resto).


% === SOLUÇÕES CONHECIDAS (OPCIONAL) ===

% Para o exemplo de 4 cidades, uma solução ótima conhecida
% (útil para validar o algoritmo)
solucao_otima_4_cidades([a, b, d, c]).
distancia_otima_4_cidades(70).

% Para testar se uma rota é ótima
:- dynamic melhor_rota_conhecida/1.
melhor_rota_conhecida([a, b, d, c]).