% o processo de inferencia tem inicio num estado objetivo a atingir e opera no sentido inverso,
% identificando sub objetivos que possam ser concretizados em sucessivos estados ate ao estado inicial

% Estado - estado inicial
% ListaObjs (sub objetivos) - lista de objetivos que queremos alcançar
% planeamento (o nosso plano) - a sequência de ações que resolve o problema

% [] - lista de acoes necessarias para completar o objetivo (começa vazia)
planear(Estado, ListaObjs, Planeamento) :-
    strips(Estado, ListaObjs, [], SeqAcoesFinal),
    reverse(SeqAcoesFinal, Planeamento).


% CLAUSULA 1: 
% 0. sub objetivo no inicio da lista objetivo (ListaObjs -> [PrimObj|ObjRestantes])
%  1. sub objetivo é uma condiçao (condicao(PrimObj))
%  2. estado atual satisfaz a condiçao
% nota: SeqAccoes - tratado como o nosso plano de accoes

% transformaçao:
% 1. remover sub objetivo
% 2. satisfazer o resto da lista objetivo
strips(Estado, [PrimObj|ObjRestantes], SeqAccoes, SeqAccoesFinal):-
    condicao(PrimObj),
    member(PrimObj, Estado),
    write('CLAUSULA 1'), nl,
    strips(Estado, ObjRestantes, SeqAccoes, SeqAccoesFinal). % "satisfazer o resto da lista objetivo"


% CLAUSULA 2:
% 1. sub objetivo é uma condicao
% 2. estado atual nao satisfaz a condicao

% transformacao:
% 1. escolher accao cujos efeitos incluam o subobjetivo -> accao/3 (Nome, PreCondicoes, Efeitos) [slide 25 - R.A PT1]
% nota: Efeitos é a lista de condições que a ação torna verdadeiras / Accao é apenas o nome da accao

% 2. colocar a acca no inicio da lista objetivo
strips(Estado, [PrimObj|ObjRestantes], SeqAccoes, SeqAccoesFinal):-
    write('CLAUSULA 2'), nl,
    condicao(PrimObj),
    \+ member(PrimObj, Estado),
    accao(Accao,_,Efeitos),
    member(PrimObj, Efeitos),
    strips(Estado,[Accao, PrimObj|ObjRestantes],SeqAccoes, SeqAccoesFinal).


% CLAUSULA 3:
% 1. subobjetivo é uma accao
% 2. Estado atual satisafaz as precond da accao
% nota: subset(+SubSet, +Set) : True if all elements of SubSet belong to Set as well.
% subset(o_que_preciso, o_que_tenho)

% transformacao:
%   1. Remover o subobjetivo, juntar efeitos da accao ao estado E juntar accao ao plano
%   2. resolver a lista obj
% nota: subtract(+Set, +Delete, -Result)
strips(Estado, [PrimObj|ObjRestantes], SeqAccoes, SeqAccoesFinal):-
    write('CLAUSULA 3'), nl,
    accao(PrimObj, PreCond, Efeitos), % 1.
    subset(PreCond, Estado), % 2.
    subtract(Estado, Efeitos,TmpEstado),
    append(TmpEstado,Efeitos,NovoEstado),
    strips(NovoEstado, ObjRestantes, [PrimObj|SeqAccoes], SeqAccoesFinal).


% CLAUSULA 4:
% 1. sub objetivo é uma accao
% 2. Estado atual nao satisfaz as precondiçoes da accao
% nota: accao/3 (Nome, PreCondicoes, Efeitos) [slide 25 - R.A PT1]

% transformacao:
% 1. Juntar ao inicio da lista objetivo as pre condiçoes da accao
% 2. Resolver a lista obj
strips(Estado, [PrimObj|ObjRestantes], SeqAccoes, SeqAccoesFinal):-
    write('CLAUSULA 4'), nl,
    accao(PrimObj, PreCond, _), % 1.
    \+ subset(PreCond, Estado), % 2.
    append(PreCond,[PrimObj|ObjRestantes], NovaListaObj), %1. 
    strips(Estado, NovaListaObj, SeqAccoes, SeqAccoesFinal). %2. 


% CLAUSULA 5:
% Quando nao ha mais objetivos para alcançar, o plano esta completo
% _ - o estado atual nao importa
% [] - lista de objetivos vazia
% SeqAccoes - sequencia de acoes acumuladas ate agora
% SeqAccoes - unificar com o resultado final
strips(_, [], SeqAccoes, SeqAccoes).
