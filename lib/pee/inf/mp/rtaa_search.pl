:- consult('bsf_p_search').

:- dynamic h/1.

iniciar_rtaa :-
    ht_new(HFechados),
    memorizar_h(HFechados).

resolver_rtaa(Estado, NoU, ProfMax) :-
    solve(Estado, Explorados, NoU, ProfMax),
    avaliar(NoU, FU),
    h(HFechados),   
    foreach(explored_enumerate(Explorados, NoV),
            actualizar_h(HFechados, NoV, FU)),
    memorizar_h(HFechados).

memorizar_h(HFechados) :-
    retractall(h(_)),   
    assert(h(HFechados)).

actualizar_h(HFechados, NoV, FU) :-
    node_g(NoV, GV),
    HV is FU - GV,
    node_state(NoV, EstadoV),
    ht_put(HFechados, EstadoV, HV).

avaliar(No, F) :-
    node_g(No, G),
    node_state(No, Estado),
    obter_heuristica(Estado, H),
    F is G + H.

obter_heuristica(Estado, H) :-
    h(HFechados),
    ht_get(HFechados, Estado, H),
    !.

obter_heuristica(Estado, H) :-
    heuristica(Estado, H).
                    