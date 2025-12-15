% TESTE DO ALGORITMO A*

:- consult('../pee/inf/mp/search_a_star').
:- consult('amb_a_star').

% Teste A*
teste_astar :-
    write(' TESTE A* '), nl, nl,
    estado_inicial(EstadoInicial),
    write('Estado inicial: '), write(EstadoInicial), nl,
    objectivo(Objetivo),
    write('Objetivo: '), write(Objetivo), nl, nl,
    
    (astar(EstadoInicial, Solucao) ->
        write('Solução encontrada: '), write(Solucao), nl
    ;   write('Nenhuma solução encontrada.'), nl
    ), !.

% Executa o teste ao carregar
:- teste_astar.