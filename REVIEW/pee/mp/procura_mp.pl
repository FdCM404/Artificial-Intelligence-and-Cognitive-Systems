:- consult(procura_base).
iniciar_procura(EstadoInicial, Fronteira, Explorados):-
    no(NoInicial, EstadoInicial), % Cria o nó inicial
    fronteira_iniciar(Fronteira,NoInicial), % Inicia a fronteira com o nó inicial
    explorados_iniciar(Explorados,NoInicial). % Inicia os explorados com o nó inicial


procura_mp(Fronteira, Explorados, NoFinal):-
    fronteira_obter(Fronteira,No,RestoFronteira), % Obtem o nó da fronteira
    (finalizar_procura(No) -> % Verifica se o nó é o objetivo ("->" se entao senao ";"  )
        NoFinal = No % Se for, devolve o nó final
        ;
        continuar_procura(No, RestoFronteira, Explorados, NoFinal) % Se não for, continua a procura
        
    ).

continuar_procura(No, Fronteira, Explorados, NoFinal):-
    expandir(No, Sucessor), % Expande o nó
    memorizar(Sucessor,Fronteira,NovaFronteira, Explorados), % Memoriza os sucessores na fronteira e nos explorados
    procura_mp(NovaFronteira, Explorados, NoFinal). 

finalizar_procura(No):-
    no_estado(No,Estado),
    objectivo(Estado). % Verifica se o estado do nó é o objetivo

resolver(EstadoInicial, Solucao):-
    iniciar_procura(EstadoInicial, Fronteira, Explorados),
    procura_mp(Fronteira, Explorados, NoFinal),
    solucao(NoFinal, Solucao).