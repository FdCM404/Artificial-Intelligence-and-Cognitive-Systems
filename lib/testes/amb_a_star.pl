% =====================================================
% PROBLEMA: Grafo com início S e fim E
% =====================================================

% Define as arestas do grafo com custos
aresta(s, a, 7).
aresta(s, b, 2).
aresta(a, b, 3).
aresta(a, d, 4).
aresta(d, b, 1).
aresta(b, h, 1).
aresta(h, f, 3).
aresta(h, g, 2).
aresta(g, e, 2).
aresta(e, k, 5).
aresta(k, i, 4).
aresta(k, j, 4).
aresta(i, j, 6).% =====================================================
% PROBLEMA: Grafo com início S e fim E
% =====================================================

% Define as arestas do grafo com custos
aresta(s, a, 7).
aresta(s, b, 2).
aresta(a, b, 3).
aresta(a, d, 4).
aresta(d, b, 1).
aresta(b, h, 1).
aresta(h, f, 3).
aresta(h, g, 2).
aresta(g, e, 2).
aresta(e, k, 5).
aresta(k, i, 4).
aresta(k, j, 4).
aresta(i, j, 6).
aresta(i, l, 4).
aresta(l, c, 2).
aresta(c, s, 3).

% Torna as arestas simétricas
aresta(X, Y, Custo) :- aresta(Y, X, Custo).

% Heurística: distância estimada até E
heuristic(s, 15).
heuristic(a, 14).
heuristic(b, 10).
heuristic(d, 8).
heuristic(h, 6).
heuristic(f, 9).
heuristic(g, 4).
heuristic(c, 12).
heuristic(e, 0).
heuristic(k, 9).
heuristic(i, 8).
heuristic(j, 10).
heuristic(l, 14).

% Vizinhos de um nó
vizinho(No, Vizinho) :- aresta(No, Vizinho, _).

% Custo de transição entre nós
custo_transicao(No1, No2, Custo) :- aresta(No1, No2, Custo).

% Estado inicial
estado_inicial(s).

% Objetivo
objectivo(e).
aresta(i, l, 4).
aresta(l, c, 2).
aresta(c, s, 3).

% Torna as arestas simétricas
aresta(X, Y, Custo) :- aresta(Y, X, Custo).

% Heurística: distância estimada até E
heuristic(s, 15).
heuristic(a, 14).
heuristic(b, 10).
heuristic(d, 8).
heuristic(h, 6).
heuristic(f, 9).
heuristic(g, 4).
heuristic(c, 12).
heuristic(e, 0).
heuristic(k, 9).
heuristic(i, 8).
heuristic(j, 10).
heuristic(l, 14).

% Vizinhos de um nó
vizinho(No, Vizinho) :- aresta(No, Vizinho, _).

% Custo de transição entre nós
custo_transicao(No1, No2, Custo) :- aresta(No1, No2, Custo).

% Estado inicial
estado_inicial(s).

% Objetivo
objectivo(e).