
:-consult(procura_mp).
:- multifile finalizar_procura/1.  %aridade1 Utiliza o predicado finalizar_procura/1 definido em procura_mp.pl em caso de falha utiliza o definido aqui


resolver(EstadoInicial, Explorados, NoFinal, ProfMax):-
    iniciar_prof_max(ProfMax),
    iniciar_procura(EstadoInicial, Fronteira, Explorados),
    procura_mp(Fronteira, Explorados, NoFinal).

/*Manipulação da base de dados dinâmica
    assert
    retract
    retractall
    asserta -> coloca no inicio da base de dados
    assertz -> coloca no fim da base de dados*/
iniciar_prof_max(ProfMax):-
    retractall(prof_max(_)), % Remove todos os factos prof_max(_)
    assert(prof_max(ProfMax)). % Cria o facto prof_max(ProfMax)

finalizar_procura(No):-
    prof_max(ProfMax), % Obtém o valor máximo de profundidade
    no_prof(No, Prof), % Obtém a profundidade do nó
    Prof > ProfMax. % Verifica se a profundidade é maior ou igual
