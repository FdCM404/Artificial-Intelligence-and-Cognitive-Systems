:- encoding(utf8).

procura_larg([Caminho|_],Caminho):- 
    Caminho=[Estado-_|_], 
    objectivo(Estado),
    format('~n✓ OBJECTIVO ENCONTRADO: ~w~n', [Estado]).

procura_larg(Caminhos,CaminhoFinal):-
    Caminhos = [Caminho|RestoCaminhos],
    Caminho = [Estado-Operador|_],
    format('→ Explorando: ~w (operador: ~w)~n', [Estado, Operador]),
    findall(CaminhoSuc,
            sucessor(Caminho,Caminhos,CaminhoSuc),
            CaminhosSuc
    ),
    length(CaminhosSuc, N),
    format('  Gerados ~w sucessores~n', [N]),
    append(RestoCaminhos,CaminhosSuc,NovoCaminhos),
    procura_larg(NovoCaminhos,CaminhoFinal).

sucessor([No|RestoCaminho],Caminhos,CaminhoSuc):-
    No = Estado-_,
    transicao(Estado,EstadoSuc,Operador),
    \+ explorado(EstadoSuc,Caminhos),
    CaminhoSuc = [EstadoSuc-Operador , No | RestoCaminho].

explorado(Estado, Caminhos):-
    member(Caminho,Caminhos),
    member(Estado-_, Caminho).

resolver(EstadoInicial, Solucao):-
    format('~n=== PROCURA EM LARGURA ===~nInicio: ~w~n~n', [EstadoInicial]),
    procura_larg([[EstadoInicial-none]],Caminho),
    reverse(Caminho,Solucao).