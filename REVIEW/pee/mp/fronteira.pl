
%  Implementa a fronteira como uma fila de prioridade
% Biblioteca heaps

fronteira_iniciar(Fronteira,No):-
    singleton_heap(Fronteira, 0, No). % Fila ordenada por prioridade a começar em 0
    

fronteira_obter(Fronteira,No,RestoFronteira):- % remove o Nó da lista
    get_from_heap(Fronteira, _, No, RestoFronteira).
    

fronteira_inserir(Fronteira,Func,No,NovaFronteira):-
    add_to_heap(Fronteira, Func, No, NovaFronteira).


    
    