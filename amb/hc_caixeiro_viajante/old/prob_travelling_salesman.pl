% Definiçao do problema 

:- consult(tab_travelling_salesman).


% Transição de estado (gera um sucessor por troca de posições)
transicao(Route, NewRoute) :-
    length(Route, N), % O valor de N é dado pelos elementos presentes em "ROute"
    N > 1,
    between(1, N, Pos1),
    between(1, N, Pos2),
    Pos1 \= Pos2, % As duas posiçoes nao podem ser iguais
    Pos1 < Pos2,
    switch_positions(Route, Pos1, Pos2, NewRoute).

% Predicado auxiliar: trocar elementos entre as posiçoes I e J
switch_positions(List, I, J, NewList) :-
    %nth1(?Index, ?List, ?Elem) : 
    % Is true when Elem is the Index’th element of List. Counting starts at 1.
    nth1(I, List, ElemI), % Obtem elemento na pos I
    nth1(J, List, ElemJ), % Obtem elemento na pos J
    switch_nth(List, I, ElemJ, Temp), % Coloca ElemJ na pos I
    switch_nth(Temp, J, ElemI, NewList). % Coloca ElemI na pos J

% Predicado auxiliar:
% switch_nth(list, Index, Elem, list)
% Se N=1 entao substitui o elem da cabeça da lista por "Elem" 
switch_nth([_|T], 1, Elem, [Elem|Rest]) :- !.
switch_nth([H|T], N, Elem, [H|R]) :-
    N > 1, 
    N1 is N-1,
    switch_nth(T, N1, Elem, R). % Substitui o elemento T na pos N1 pelo Elem e cria uma nova lista R


% Calcula o valor de uma rota (negativo da distância total)
% O HC maximiza o valor, então usamos -distância para minimizar distância
valor(Route, NegativeValue) :-
    get_total_route_dist(Route, TotalDist),
    NegativeValue is -TotalDist.

% Alias para compatibilidade
get_route_value(Route, NegativeValue) :-
    valor(Route, NegativeValue).

% Calcula a distância total de uma rota (incluindo volta à origem)
get_total_route_dist(Route, Total) :-
    Route = [FirstRoute|_],
    append(Route, [FirstRoute], FullRoute),
    sum_dists(FullRoute, Total).

% Se a lista de cidades estiver vazia, retorna fail
sum_dists([_],0) :- !.
% Calcula recursivamente a distancia entre cidades presentes na lista
sum_dists([City1, City2 | OtherCities], Total) :-
    distance(City1, City2, Distance),
    sum_dists([City2|OtherCities], OtherDists),
    Total is Distance + OtherDists.



% Objectivo: encontrar rota com distância total mínima
% Como é um problema de otimização, não há goal state específico
% O algoritmo HC corre pelas iterações ou até encontrar um patamar
objectivo(_) :- fail.

% Display de uma rota (Fornece a rota e a distancia)
show_route(Route) :-
    format("Route:~w~n",[Route]),
    get_total_route_dist(Route, Distance),
    format("Total distance: ~w~n",[Distance]).

% Cria os sucessores possiveis à rota atual
sucessor(Route, N) :-
    findall(Sucessor, transicao(Route, Sucessor), Sucessores),
    length(Sucessores, N).


% TODO: TABULEIRO e TESTES UNICOS 
% TODO: Introduçao ao problema e a motivaçao
% OPt: Menu de varios testes?