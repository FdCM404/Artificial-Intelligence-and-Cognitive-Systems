:- encoding(utf8).

% Carrega o ambiente e o algoritmo STRIPS
:- consult('def_amb_strips').
:- consult('../../lib/strips/strips').

% --- Teste do Mundo dos Blocos ---

teste :-
    % Estado inicial: A sobre B, C livre
    %   A       C
    %   B      ---
    %  ---    Mesa
    % Mesa
    EstadoInicial = [
        sobre(a, b),
        sobre(b, mesa),
        sobre(c, mesa),
        livre(a),
        livre(c),
        mao_vazia
    ],
    
    % Objetivo: B sobre C, A livre
    %   B
    %   C       A
    %  ---     ---
    % Mesa    Mesa
    Objetivo = [sobre(b, c), livre(a)],
    
    format('\n=== STRIPS - Mundo dos Blocos ===\n\n'),
    format('Estado inicial:\n'),
    format('  A       C\n'),
    format('  B      ---\n'),
    format('-----   Mesa\n'),
    format('Mesa\n\n'),
    
    format('Objetivo:\n'),
    format('  B\n'),
    format('  C       A\n'),
    format('-----   ---\n'),
    format('Mesa    Mesa\n\n'),
    
    % Chama o planeador com timeout de 5 segundos
    (   catch(
            call_with_time_limit(5.0, planear(EstadoInicial, Objetivo, Plano)),
            time_limit_exceeded,
            fail
        )
    ->  (   format('\n=== Plano encontrado ===\n'),
            length(Plano, NumPassos),
            format('Total de ações: ~w\n\n', [NumPassos]),
            mostrar_plano(Plano, 1)
        )
    ;   format('\n!!! Timeout ou sem solução !!!\n'),
        format('O STRIPS pode entrar em loop sem controle de estados visitados.\n')
    ).

% Mostra o plano numerado
mostrar_plano([], _).
mostrar_plano([Passo|Resto], N) :-
    format('~w. ~w\n', [N, Passo]),
    N1 is N + 1,
    mostrar_plano(Resto, N1).

% Alias
run :- teste.
