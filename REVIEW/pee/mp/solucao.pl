
solucao(NoFinal, Solucao):-
    gerar_solucao(NoFinal, [], Solucao).

gerar_solucao(No, Caminho, Caminho):-
    no_ant(No, none), % Se o nó não tem antecessor, é o nó inicial
    !. % Em alternativa poderia usar o predicado no_estado/2 para verificar se o estado é o estado inicial NoAntecessor \= none

gerar_solucao(No, Caminho, Solucao):-
    no_ant(No, NoAntecessor), % Extrai o nó antecessor
    no_estado(NoAntecessor, EstadoAnt), % Extrai o estado do nó antecessor
    no_oper(No, Operador), % Extrai o operador que gerou o nó
    CaminhoParcial = [EstadoAnt-Operador|Caminho], % Adiciona o estado e operador ao caminho
    gerar_solucao(NoAntecessor, CaminhoParcial, Solucao). % Adiciona o estado e operador ao caminho
% O caminho é construído em ordem inversa, do nó final para o inicial

