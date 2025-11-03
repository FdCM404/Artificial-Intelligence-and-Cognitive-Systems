:- encoding(utf8).

:-consult(problema_amb2d).

:-consult('../lib/pee/mp/procura_aa').

teste :- iniciar_ambiente(8),
    inicio(Estado),
    resolver(Estado, Solucao) ->
        mostrar_ambiente(Solucao) ; %Disjunção
        writeln('Solução não encontrada').
   

% [C:\Users\xico\Desktop\fDIR\MEIC\2526-1SEM\IASC\IASC-PROJETO\IASC\amb2d\amb2d\teste_pee_mp.pl].