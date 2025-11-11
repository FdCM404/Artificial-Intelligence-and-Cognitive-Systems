% Corrigir para a minha versao

:- consult(bsf_p_search).

:- dynamic h/1.

iniciar_rtaa :-
    ht_new(HFechados),
    memorizar_h(HFechados).

resolver_rtaa(Estado, NoU, ProfMax) :-
    resolver(Estado, Explorados, NoU, ProfMax),
    avaliar(NoU, FU),
    h(HFechados),   
    foreach(explorados_enumerar(Explorados, NoV),
            actualizar_h(HFechados, NoV, FU)),
    memorizar_h(HFechados).

memorizar_h(HFechados) :-
    retractall(h(_)),   
    assert(h(HFechados)).

actualizar_h(HFechados, NoV, FU) :-
    no_g(NoV, GV),
    HV is FU - GV,
    no_estado(NoV, EstadoV),
    ht_put(HFechados, EstadoV, HV).

avaliar(No, F) :-
    no_g(No, G),
    no_estado(No, Estado),
    obter_heuristica(Estado, H),
    F is G + H.

obter_heuristica(Estado, H) :-
    h(HFechados),
    ht_get(HFechados, Estado, H),
    !.

obter_heuristica(Estado, H) :-
    heuristica(Estado, H).
                    