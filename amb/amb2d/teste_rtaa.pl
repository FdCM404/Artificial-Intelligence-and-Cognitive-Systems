:- encoding(utf8).

:- consult(problema_amb2d).

:- consult('../../lib/pee/inf/mp/rtaa_search').

% Wrappers necessários
transition(S1, S2, Op, Cost) :- transicao(S1, S2, Op, Cost).
goal(S) :- objectivo(S).
heuristic(S, H) :- heuristica(S, H).
explored(Node, Explored) :- explored_check(Node, Explored).
check_func(Node, F) :- 
    node_g(Node, G),
    node_state(Node, State),
    heuristic(State, H),
    F is G + H.

teste :-
    iniciar_ambiente(8),
    inicio(Estado),
    iniciar_rtaa,  % Inicializa a tabela de heurísticas
    ProfMax = 10,  % Profundidade máxima por iteração
    resolver_ciclo_rtaa(Estado, ProfMax).

% Ciclo principal do RTAA*
resolver_ciclo_rtaa(Estado, _ProfMax) :-
    objectivo(Estado), !,
    format('~n=== OBJECTIVO ALCANÇADO ===~n').

resolver_ciclo_rtaa(Estado, ProfMax) :-
    format('~n--- Iteração RTAA* ---~n'),
    format('Estado atual: ~w~n', [Estado]),
    resolver_rtaa(Estado, NoU, ProfMax),
    node_state(NoU, ProximoEstado),
    node_action(NoU, Operador),
    format('Próximo estado: ~w (operador: ~w)~n', [ProximoEstado, Operador]),
    resolver_ciclo_rtaa(ProximoEstado, ProfMax).

resolver_ciclo_rtaa(_Estado, _ProfMax) :-
    writeln('Solução não encontrada').

% Alias conveniente
run :- teste.
