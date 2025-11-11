% ===============================================
% TESTES PARA O CAIXEIRO VIAJANTE
% ===============================================
% Carrega os ficheiros necessários e define testes
% ===============================================

% Carrega o algoritmo Hill Climbing (assumindo que existe)
:- consult('../../lib/pee/inf/hc/hc').
% :- consult('../../lib/pee/inf/hc/hcr').

% Carrega o problema do Caixeiro Viajante
:- consult('prob_cv').

% Carrega o tabuleiro (distâncias)
:- consult('tab_cv').


% === TESTES BÁSICOS ===

% Teste 1: Executar Hill Climbing com estado inicial aleatório
teste1 :-
    write('=== TESTE 1: Hill Climbing com 50 iterações ==='), nl, nl,
    EstadoInicial = [a, b, c, d],
    write('Estado inicial: '), mostrar_rota(EstadoInicial), nl,
    hc(EstadoInicial, Solucao, 50),
    write('Solução encontrada: '), mostrar_rota(Solucao), nl.


% Teste 2: Executar com mais iterações
teste2 :-
    write('=== TESTE 2: Hill Climbing com 100 iterações ==='), nl, nl,
    EstadoInicial = [a, b, c, d],
    write('Estado inicial: '), mostrar_rota(EstadoInicial), nl,
    hc(EstadoInicial, Solucao, 100),
    write('Solução encontrada: '), mostrar_rota(Solucao), nl.


% Teste 3: Testar com diferentes estados iniciais
teste3 :-
    write('=== TESTE 3: Diferentes estados iniciais ==='), nl, nl,
    Estados = [
        [a, b, c, d],
        [d, c, b, a],
        [a, d, b, c],
        [b, a, d, c]
    ],
    testar_multiplos_estados(Estados, 50).

testar_multiplos_estados([], _).
testar_multiplos_estados([Estado|Resto], NIter) :-
    write('Estado inicial: '), write(Estado), nl,
    distancia_total_rota(Estado, DistInicial),
    write('Distância inicial: '), write(DistInicial), nl,
    hc(Estado, Solucao, NIter),
    distancia_total_rota(Solucao, DistFinal),
    write('Solução: '), write(Solucao), nl,
    write('Distância final: '), write(DistFinal), nl,
    Melhoria is DistInicial - DistFinal,
    write('Melhoria: '), write(Melhoria), nl, nl,
    testar_multiplos_estados(Resto, NIter).


% Teste 4: Análise detalhada de uma execução
teste4 :-
    write('=== TESTE 4: Análise detalhada ==='), nl, nl,
    EstadoInicial = [a, b, c, d],
    write('Analisando estado inicial...'), nl,
    mostrar_rota(EstadoInicial),
    num_sucessores(EstadoInicial, NumSuc),
    write('Número de vizinhos possíveis: '), write(NumSuc), nl, nl,
    write('Executando Hill Climbing...'), nl,
    hc(EstadoInicial, Solucao, 50),
    write('Resultado: '), mostrar_rota(Solucao).


% Teste 5: Verificar se encontra a solução ótima
teste5 :-
    write('=== TESTE 5: Procurar solução ótima ==='), nl, nl,
    solucao_otima_4_cidades(Otima),
    distancia_otima_4_cidades(DistOtima),
    write('Solução ótima conhecida: '), write(Otima), nl,
    write('Distância ótima: '), write(DistOtima), nl, nl,
    
    write('Tentando encontrar com Hill Climbing...'), nl,
    EstadoInicial = [a, b, c, d],
    hc(EstadoInicial, Solucao, 100),
    distancia_total_rota(Solucao, DistEncontrada),
    
    write('Solução encontrada: '), write(Solucao), nl,
    write('Distância encontrada: '), write(DistEncontrada), nl, nl,
    
    (   DistEncontrada =:= DistOtima
    ->  write('✓ SUCESSO: Encontrou a solução ótima!'), nl
    ;   Diferenca is DistEncontrada - DistOtima,
        write('✗ Não é ótima. Diferença: '), write(Diferenca), nl
    ).


% Teste 6: Comparar com pior caso
teste6 :-
    write('=== TESTE 6: Melhor vs Pior ==='), nl, nl,
    
    % Testa o melhor caso conhecido
    MelhorCaso = [a, b, d, c],
    write('Melhor caso: '), mostrar_rota(MelhorCaso),
    
    % Testa o pior caso
    PiorCaso = [a, c, b, d],
    write('Pior caso: '), mostrar_rota(PiorCaso), nl,
    
    % Aplica Hill Climbing ao pior caso
    write('Aplicando Hill Climbing ao pior caso...'), nl,
    hc(PiorCaso, Solucao, 50),
    write('Resultado: '), mostrar_rota(Solucao).


% === TESTE COMPLETO ===

% Executa todos os testes
todos_testes :-
    mostrar_mapa, nl,
    teste1, nl,
    teste2, nl,
    teste3, nl,
    teste4, nl,
    teste5, nl,
    teste6.


% === TESTE RÁPIDO ===

% Teste simples e rápido
teste :-
    write('=== TESTE RÁPIDO ==='), nl, nl,
    EstadoInicial = [a, b, c, d],
    write('Inicial: '), mostrar_rota(EstadoInicial),
    hc(EstadoInicial, Solucao, 50),
    write('Final: '), mostrar_rota(Solucao).


% === INSTRUÇÕES ===

ajuda :-
    write('=== COMANDOS DISPONÍVEIS ==='), nl,
    write('teste.           - Teste rápido'), nl,
    write('teste1.          - Hill Climbing 50 iterações'), nl,
    write('teste2.          - Hill Climbing 100 iterações'), nl,
    write('teste3.          - Múltiplos estados iniciais'), nl,
    write('teste4.          - Análise detalhada'), nl,
    write('teste5.          - Verificar solução ótima'), nl,
    write('teste6.          - Comparar melhor vs pior'), nl,
    write('todos_testes.    - Executar todos os testes'), nl,
    write('mostrar_mapa.    - Ver distâncias entre cidades'), nl,
    write('ajuda.           - Mostrar esta mensagem'), nl.

% Mostra ajuda ao carregar
:- ajuda.