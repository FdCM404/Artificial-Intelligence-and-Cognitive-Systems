%------------------------------------------------------------
% Algoritmo Hill-Climbing
%
% hc(+Estado, -Solucao, +NIter)
%
% Estado: Estado inicial
% Solucao: Solução obtida
% NIter: Número de iterações
%------------------------------------------------------------

% OBJETIVO DO ALGORITMO:

% O algoritmo funciona de forma iterativa, 
%  movendo-se sempre para o melhor vizinho (sucessor) 
%  até que não consiga melhorar mais 
%  (atingindo um ótimo local ou global) 
%  ou atinja um limite de iterações.


% Fim das iterações
% Nenhuma outra clausula "hc/3" deve ser considerada.
hc(Estado, Estado, 0) :- !.

% Objectivo atingido
hc(Estado, Estado, _) :-
    objectivo(Estado).

% Iterar procura
hc(Estado, Solucao, NIter) :-
    sucessores(Estado, Sucessores),
    % Chama o predicado para calcular o valor heurístico de cada sucessor, 
    % resultando numa lista de pares "Valor-EstadoSuc"
    avaliar(Sucessores, AvalSuc),
    % Encontra o *melhor sucessor*. "AvalMaxSuc" será o par "ValorMax-EstadoSucMax"
    %   com o maior valor na lista "AvalSuc"
    max_member(AvalMaxSuc, AvalSuc), 
    valor(Estado, ValorEstado), % Obtém o valor heurístico do estado atual.
    gerar_solucao(ValorEstado-Estado, AvalMaxSuc, Solucao, NIter).

% Estado atingido é o melhor
gerar_solucao(ValorEstado-Estado, AvalSuc-_, Estado, _) :-
    ValorEstado >= AvalSuc.

% Recorre ao predicado debaixo caso a solucao nao tenha sido encontrada.
% Estado atingido não é o melhor
gerar_solucao(_, _-EstadoSuc, Solucao, NIter) :-
    NIterSuc is NIter - 1,
    hc(EstadoSuc, Solucao, NIterSuc).

% Sucessores de um estado
% Encontra todas as instancias de "EstadoSuc" que satisfazem o objetivo "transicao(Estado, EstadoSuc)"
%  e coloca-as na lista "Sucessores"
sucessores(Estado, Sucessores) :-
    findall(EstadoSuc, transicao(Estado, EstadoSuc), Sucessores).

% Avaliar estados de uma lista de estados
% gerando uma lista de pares valor-estado
avaliar([], []).
avaliar([Estado | Resto], [Valor-Estado | RestoAval]) :-
    valor(Estado, Valor),
    avaliar(Resto, RestoAval).


