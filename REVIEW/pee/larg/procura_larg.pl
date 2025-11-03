%caso particular
/*
procura_larg(Caminhos,Caminho):- %Caminhos e uma lista de caminhos
    Caminhos = [Caminho|_], %extrai o primeiro caminho
    Caminho=[Estado-_|_], %extrai o estado do caminho
    objectivo(Estado).
*/
procura_larg([Caminho|_],Caminho):- % mantem contexto de procura_larg
    Caminho=[Estado-_|_], % extrai o estado do caminho
    objectivo(Estado). % verifica se o estado e objectivo

procura_larg(Caminhos,CaminhoFinal):-
    Caminhos = [Caminho|RestoCaminhos],
    findall(CaminhoSuc,%descobre um caminho sucessor 
            sucessor(Caminho,Caminhos,CaminhoSuc),
            CaminhosSuc
    ),% procura todos os CaminhoSuc e guarda em CaminhosSuc
    append(RestoCaminhos,CaminhosSuc,NovoCaminhos),% adiciona os novos caminhos ao fim da lista
    procura_larg(NovoCaminhos,CaminhoFinal).% chama recursivamente com a nova lista de caminhos


%sucessor(+Caminho,+Caminhos,-CaminhoSuc),
%findall(elemento(X), member(X,[1,2,3]), Lista ) -> Lista = [elemento(1),elemento2,elemento3]
 sucessor([No|RestoCaminho],Caminhos,CaminhoSuc):-
    No = Estado-_,
    transicao(Estado,EstadoSuc,Operador),
    \+ explorado(EstadoSuc,Caminhos), % Evitar ciclos
    CaminhoSuc = [EstadoSuc-Operador , No | RestoCaminho].

explorado(Estado, Caminhos):- % Verifica se o estado já foi explorado
    member(Caminho,Caminhos),
    member(Estado-_, Caminho).

resolver(EstadoInicial, Solucao):-
    procura_larg([[EstadoInicial-none]],Caminho),
    reverse(Caminho,Solucao).
    