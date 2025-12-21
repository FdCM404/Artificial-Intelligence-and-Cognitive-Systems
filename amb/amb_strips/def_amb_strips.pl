% Definição do ambiente para STRIPS - Mundo dos Blocos

% Blocos disponíveis 
bloco(a).
bloco(b).
bloco(c).

% Condições possíveis 
condicao(sobre(X, Y)) :- bloco(X), (bloco(Y) ; Y = mesa).
condicao(livre(X)) :- bloco(X).
condicao(livre(mesa)).
condicao(mao_vazia).
condicao(segurando(X)) :- bloco(X).

% Ações disponíveis 

% Desempilhar bloco X de cima de Y
% Pré-condições: X sobre Y, X livre, mão vazia
% Efeitos: segurando X, Y livre
accao(desempilhar(X, Y),
      [sobre(X, Y), livre(X), mao_vazia],
      [segurando(X), livre(Y)]).

% Pousar um bloco na mesa
% Pré-condições: segurar o bloco
% Efeitos: bloco sobre mesa, bloco livre, mão vazia
accao(pousar(X),
      [segurando(X)],
      [sobre(X, mesa), livre(X), mao_vazia]).

% Empilhar bloco X sobre bloco Y
% Pré-condições: segurando X, Y livre
% Efeitos: X sobre Y, mão vazia
accao(empilhar(X, Y),
      [segurando(X), livre(Y)],
      [sobre(X, Y), livre(X), mao_vazia]).
