% Distâncias entre cidades
% Forma um tabuleiro com diagonais
distance(a, b, 20).
distance(a, c, 42).
distance(a, d, 35).
distance(a, e, 30).
distance(a, f, 28).
distance(b, c, 30).
distance(b, d, 34).
distance(b, e, 18).
distance(b, f, 40).
distance(c, d, 12).
distance(c, e, 24).
distance(c, f, 15).
distance(d, e, 22).
distance(d, f, 27).
distance(e, f, 10).

% Torna as distâncias simétricas
distance(X, Y, D) :-
    X \= Y,
    distance(Y, X, D).

% A distância de uma cidade para ela mesma é 0
distance(X, X, 0).

% Lista todas as cidades do problema atual
list_cities(Cities) :-
    findall(C, (distance(C, _, _), C \= _), AllCities),
    sort(AllCities, Cities), % Unifica cities com all cities
    format("[LIST_CITIES:] As cidades presentes são: ~w~n",[AllCities]). % So para debug

% Obtem o numero de cidades
num_cities(N) :-
    list_cities(Cities),
    length(Cities, N).

% Display do mapa
show_map :-
    format("** MAPA ** ~n"),
    list_cities(Cities),
    format("[SHOW_MAP:] Cidades:~w~n",[Cities]),
    show_distancies(Cities).

show_distancies([]).
% C -> head da lista de cidades, R -> resto da lista de cidades
show_distancies([C|R]) :-
    forall((member(D, R), distance(C, D, D2)),
    (write(C), write("->"), write(D), write(": "), write(D2), nl)
    ),
    show_distancies(R).


% Teste para soluçoes conhecidas
% Para o caso de termos 4 cidades, uma soluçao otima conhecida seria:
optimal_cities_solution([a,b,e,f,c,d]).
optimal_distance_solution(110).

% Para testar se uma rota é otima
:- dynamic best_known_route/1.
best_known_route([a,b,e,f,c,d]).
