:- consult(procura_mp).
% Algoritmo de procura de custo uniforme
avaliar(No,F):-
    no_g(No, G), % Avalia o nó sucessor pelo custo acumulado G
    F=G.