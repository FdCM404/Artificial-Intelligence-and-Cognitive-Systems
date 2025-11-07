% Best Search First (BSF) implementation (PT - Melhor Primeiro)

% Metodo de procura que utiliza uma avaliaçao de estado baseada no custo para atingir cada estado a partir
% do estado inicial. 
% Utiliza um funcao de custo f(n) >= 0. Pode ser uma estimativa do custo da solucao atraves do nó "n"
% Utiliza uma fronteira ordenada para explorar os nós com menor custo primeiro.

% Cria nó inicial
% Inicia fronteira com prioridade
% Incia nós explorados
% Enquanto a fronteira não estiver vazia
    % Remove primeiro nó da fronteira
    % Se o nó for solução, devolve a solução
    % Caso contrario:
        % Expande o nó
        % por cada nó sucessor:
            % Obter estado do nó
            % Se o nó ainda nao foi explorado OU se for melhor:
                % Junta nó aos explorados
                % Junta nó à fronteira
% Fronteira vazia = falha.

