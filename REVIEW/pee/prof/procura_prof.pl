%procura_prof(+Caminho,-CaminhoFinal)
%No: Estado - Operador
/*
procura_prof(Caminho,CaminhoFinal):-
    Caminho = [No|_],
    No=Estado-Caminho,
    objectivo(Estado),
    CaminhoFinal = Caminho.
*/

%Caso particular
procura_prof(Caminho,Caminho):-
    Caminho = [Estado-_|_],
    objectivo(Estado).

%Caso geral
procura_prof(Caminho,CaminhoFinal):-
    sucessor(Caminho,CaminhoSuc),
    procura_prof(CaminhoSuc,CaminhoFinal).

sucessor([No|RestoCaminho],CaminhoSuc):-
    No = Estado-_ ,
    transicao(Estado,EstadoSuc,Operador),
    \+ explorado(EstadoSuc,[No|RestoCaminho]), % Evitar ciclos
    CaminhoSuc = [EstadoSuc-Operador , No | RestoCaminho].

explorado(Estado, Caminho):- % Verifica se o estado já foi explorado
    member(Estado-_, Caminho).

resolver(EstadoInicial, Solucao):-
    procura_prof([EstadoInicial-none],Caminho),
    reverse(Caminho,Solucao).
    