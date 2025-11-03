/*
strips(+Estado,+ListaObjetivo,+SeqAccoes,-SeqAccoesFinal):-
    +Estado= [],
    +ListaObjetivo=[Inicio|Resto]:-
    +SeqAccoes=[] ,
    -SeqAccoesFinal=[].
*/
%Condições particulares
%strips(+Estado,+ListaObjetivo,+SeqAccoes,-SeqAccoesFinal)
/* 
Sub-objectivo no início da lista objectivo:
    • Sub-objectivo é uma condição
    • Estado actual satisfaz a condição
Transformação a realizar:
    • Remover o sub-objectivo
    • Satisfazer o resto da lista objectivo
*/
planear(Estado,ListaObjetivo,Plano):-
    strips(Estado,ListaObjetivo,[],SeqAccoesFinal),
    reverse(SeqAccoesFinal,Plano).

strips(_,[],SeqAccoes,SeqAccoes).%Lista objectivo vazia

strips(Estado,[Inicio|Resto],SeqAccoes,SeqAccoesFinal):-
    condicao(Inicio),
    member(Inicio,Estado),
    strips(Estado,Resto,SeqAccoes,SeqAccoesFinal).%Satisfazer o resto da lista objectivo

/*
Sub-objectivo no início da lista objectivo:
    • Sub-objectivo é uma condição  
    • Estado actual não satisfaz a condição
Transformação a realizar:
 • Escolher uma acção cujos efeitos incluam o 
sub-objectivo
 • Colocar a acção no início da lista objectivo
*/
strips(Estado,[Inicio|Resto],SeqAccoes,SeqAccoesFinal):-
    condicao(Inicio),
    \+ member(Inicio,Estado),
    accao(Accao,_,Efeitos),
    member(Inicio,Efeitos),
    strips(Estado,[Accao,Inicio|Resto],SeqAccoes,SeqAccoesFinal).
   
/*

Sub-objectivo no início da lista objectivo:
    • Sub-objectivo é uma acção
    • Estado actual satisfaz as precondições da acção
Transformação a realizar:
    • Remover o sub-objectivo, juntar efeitos da acção ao estado 
    e juntar acção ao plano
    • Resolver o resto da lista objectivo
*/

strips(Estado,[Inicio|Resto],SeqAccoes,SeqAccoesFinal):-
    accao(Inicio,PreCond,Efeitos),
    subset(PreCond,Estado),
    subtract(Estado, Efeitos, EstadoTemp),
    append(EstadoTemp, Efeitos, EstadoNovo),
    strips(EstadoNovo,Resto,[Inicio|SeqAccoes],SeqAccoesFinal).
    

/*
Sub-objectivo no início da lista objectivo:
    • Sub-objectivo é uma acção
    • Estado actual não satisfaz as precondições da 
acção
Transformação a realizar:
    • Juntar ao início da lista objectivo as pré
    condições da acção
    • Resolver a lista objectivo
*/
strips(Estado,[Inicio|Resto],SeqAccoes,SeqAccoesFinal):-
    accao(Inicio,PreCond,_),
    \+ subset(PreCond,Estado),
    append(PreCond,[Inicio|Resto],NovoObj),
    strips(Estado,NovoObj,SeqAccoes,SeqAccoesFinal).

/*
Sub-objectivo no início da lista objectivo:
    •  Lista objectivo está vazia
Transformação a realizar:
   • Objectivo satisfeito
    • O plano produzido até ao momento é o plano 
    final
*/

