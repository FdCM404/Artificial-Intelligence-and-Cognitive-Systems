/* Modulo Explorados: Implementa uma tabela de hash para guardar os estados explorados
   Utiliza a biblioteca de tabelas de hash do SWI-Prolog
   https://www.swi-prolog.org

   Dicionario -Baseado na biblioteca de tabelas de hash do SWI-Prolog
*/

explorados_iniciar(Explorados):-
    ht_new(Explorados). % Cria uma hash table vazio
    
explorados_iniciar(Explorados,No):- % Cria uma hash table vazio e insere o nó
   explorados_iniciar(Explorados),
    explorados_inserir(Explorados,No).

explorados_obter(Explorados,No,NoExp):- % remove o Nó da lista
    no_estado(No,Estado),
    ht_get(Explorados, Estado, NoExp). % Obtem o nó da hash table

explorados_inserir(Explorados,No):-
    no_estado(No,Estado),
    ht_put(Explorados, Estado, No). % Insere o nó na hash table