
% PROBLEMA DO "TRAVELLING SALESMAN" (CAIXEIRO VIAJANTE) - DEFINIÇÃO

% Este ficheiro define o problema: transições, 
% avaliação e objetivo para o Caixeiro Viajante

% DESCRIÇÃO DO PROBLEMA:
%   O problema do caixeiro-viajante é um problema que tenta determinar a menor
%   rota para percorrer uma serie de cidades (visitando uma unica vez cada uma delas)
%   retornando à cidade de origem.
%     
%    
%
%
%
% 
% 
% https://pt.wikipedia.org/wiki/Problema_do_caixeiro-viajante
% 


% TRANSIÇÕES (GERAR VIZINHOS) 

% Gera um vizinho trocando duas cidades quaisquer na rota
% Este é o operador de vizinhança mais comum para o problema
transicao(Rota, NovaRota) :-
    length(Rota, N),
    N > 1,
    % Escolhe duas posições diferentes
    between(1, N, Pos1),
    between(1, N, Pos2),
    Pos1 \= Pos2,
    Pos1 < Pos2,  % Evita duplicados (trocar A-B é o mesmo que B-A)
    % Troca as cidades nessas posições
    trocar_posicoes(Rota, Pos1, Pos2, NovaRota).

% Auxiliar: troca elementos nas posições I e J
trocar_posicoes(Lista, I, J, NovaLista) :-
    nth1(I, Lista, ElemI),
    nth1(J, Lista, ElemJ),
    substituir_nth(Lista, I, ElemJ, Temp),
    substituir_nth(Temp, J, ElemI, NovaLista).

% Auxiliar: substitui elemento na posição N
substituir_nth([_|Resto], 1, Elem, [Elem|Resto]) :- !.
substituir_nth([H|T], N, Elem, [H|R]) :-
    N > 1,
    N1 is N - 1,
    substituir_nth(T, N1, Elem, R).


% AVALIAÇÃO (FUNÇÃO HEURÍSTICA) 

% Calcula o valor de uma rota
% Nota: Como o Hill Climbing maximiza, usamos o NEGATIVO da distância
% para que minimizar distância = maximizar valor
valor(Rota, ValorNegativo) :-
    distancia_total_rota(Rota, DistanciaTotal),
    ValorNegativo is -DistanciaTotal.

% Calcula a distância total de uma rota (incluindo volta à origem)
distancia_total_rota(Rota, Total) :-
    Rota = [Primeira|_],
    append(Rota, [Primeira], RotaCompleta),  % Adiciona volta à origem
    soma_distancias(RotaCompleta, Total).

% Soma as distâncias entre cidades consecutivas
soma_distancias([_], 0) :- !.
soma_distancias([C1, C2|Resto], Total) :-
    distancia(C1, C2, D),
    soma_distancias([C2|Resto], RestoTotal),
    Total is D + RestoTotal.


% OBJETIVO 

% Podemos definir diferentes critérios de paragem:

% Opção 1: Aceitar qualquer solução (deixa esgotar iterações)
objectivo(_) :- fail.

% Opção 2: Aceitar se atingir uma distância específica
% objectivo(Rota) :-
%     valor(Rota, Valor),
%     Valor >= -100.  % Ex: aceitar se distância <= 100

% Opção 3: Aceitar se for a solução ótima conhecida
% objectivo(Rota) :-
%     melhor_rota_conhecida(RotaOtima),
%     permutation(Rota, RotaOtima).


% ESTADO ALEATÓRIO (Para HCR) 

% Gera um estado inicial aleatório (permutação aleatória das cidades)
% estado_aleat(EstadoAleat) :-
%     % cidades(Cidades),
%     random_permutation(Cidades, EstadoAleat).
% 
% % Predicado auxiliar para obter as cidades
% cidades(Cidades) :-
%     findall(C, distancia(C, _, _), TodasCidades),
%     sort(TodasCidades, Cidades).
estado_aleat(EstadoAleat) :-
    random_permutation([a, b, c, d], EstadoAleat).

% Predicado auxiliar para obter as cidades
cidades([a, b, c, d]).
%  UTILIDADES 

% Mostra informação sobre uma rota
mostrar_rota(Rota) :-
    write('Rota: '), write(Rota), nl,
    distancia_total_rota(Rota, Dist),
    write('Distancia total: '), write(Dist), nl.

% Conta o número de sucessores possíveis
num_sucessores(Rota, N) :-
    findall(S, transicao(Rota, S), Sucessores),
    length(Sucessores, N).