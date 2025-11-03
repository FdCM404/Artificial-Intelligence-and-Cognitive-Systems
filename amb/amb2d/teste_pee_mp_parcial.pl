:- encoding(utf8).

:-consult(problema_amb2d).

:-consult('../lib/pee/mp/procura_rtaa').
:-consult('../lib/pee/mp/solucao').

teste :- iniciar_ambiente(8),
    inicio(Estado),
    resolver(Estado,_, NoFinal,72) -> %%72 é a profundidade necessária para encontrar a solução
        (solucao(NoFinal, Solucao),
         mostrar_ambiente(Solucao)) ; %Disjunção
        writeln('Solução não encontrada').
    