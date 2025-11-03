:-consult(no).
:-consult(fronteira).
:-consult(explorados).
:-consult(solucao).

expandir(No, Sucessores):-
    findall(NoSuc,sucessor(No,NoSuc),Sucessores). % Encontra todos os sucessores do nó

sucessor(No,NoSuc):-
    no_estado(No,Estado), % Extrai o estado do nó
    transicao(Estado,EstadoSuc,Operador,CustoTrans), % Encontra uma transição possível -> defenida no problema
    no(NoSuc,EstadoSuc,No,Operador,CustoTrans). % Cria o nó sucessor



%memorizar(Sucessores,Fronteira,Fronteira,Explorados). 
memorizar([],Fronteira,Fronteira,_). % Se não houver sucessores, a fronteira mantém-se igual

memorizar([NoSuc|RestoSuc],Fronteira,NovaFronteira,Explorados):-
    explorado(NoSuc,Explorados), % Verifica se o nó sucessor já foi explorado
    memorizar(RestoSuc,Fronteira,NovaFronteira,Explorados).

memorizar([NoSuc|RestoSuc],Fronteira,NovaFronteira,Explorados):-
    avaliar(NoSuc,F), % Avalia se o nó sucessor deve ser adicionado à fronteira
    fronteira_inserir(Fronteira,F,NoSuc,FronteiraSuc), % Insere o nó sucessor na fronteira
    explorados_inserir(Explorados,NoSuc), 
    memorizar(RestoSuc,FronteiraSuc,NovaFronteira,Explorados).

%se o custo do nó sucessor for maior que o custo do nó explorado, não o adiciona à fronteira    
explorado(No,Explorados):-
    explorados_obter(Explorados,No,NoExp), % Verifica se o nó está na tabela de explorados
    no_g(No, G),
    no_g(NoExp, GExp),
    G >= GExp. % Se o custo do nó for maior ou igual ao custo do nó explorado, considera-o explorado
