% =========================================
% Modulo de Utilidades Generales
% =========================================
% Predicados auxiliares reutilizables para
% formateo, manejo de listas y salida.

% ---------------------------------
% Mostrar lista simple (un elemento por linea)
% ---------------------------------

mostrar_lista([]).
mostrar_lista([X|R]) :-
    write(X), nl,
    mostrar_lista(R).

% ---------------------------------
% Mostrar lista con guion (- elemento)
% ---------------------------------

mostrar_lista_con_guion([]).
mostrar_lista_con_guion([X|R]) :-
    write('  - '), write(X), nl,
    mostrar_lista_con_guion(R).

% ---------------------------------
% Mostrar lista numerada (1. elemento)
% ---------------------------------

mostrar_lista_numerada(Lista) :-
    mostrar_lista_numerada(Lista, 1).

mostrar_lista_numerada([], _).
mostrar_lista_numerada([X|R], N) :-
    write(N), write('. '), write(X), nl,
    N1 is N + 1,
    mostrar_lista_numerada(R, N1).

% ---------------------------------
% Mostrar relaciones (lista de pares R-Y)
% ---------------------------------

mostrar_relaciones([]).
mostrar_relaciones([R-Y|Resto]) :-
    write('  - '), write(R), write(' -> '), write(Y), nl,
    mostrar_relaciones(Resto).

% ---------------------------------
% Separador visual
% ---------------------------------

separador :-
    write('----------------------------------------'), nl.

% ---------------------------------
% Titulo con decoracion
% ---------------------------------

titulo(Texto) :-
    separador,
    write('  '), write(Texto), nl,
    separador.

% ---------------------------------
% Eliminar duplicados de una lista
% ---------------------------------

lista_sin_duplicados([], []).
lista_sin_duplicados([X|Xs], Ys) :-
    member(X, Xs), !,
    lista_sin_duplicados(Xs, Ys).
lista_sin_duplicados([X|Xs], [X|Ys]) :-
    lista_sin_duplicados(Xs, Ys).

% ---------------------------------
% Longitud de una lista
% ---------------------------------

longitud([], 0).
longitud([_|R], N) :-
    longitud(R, N1),
    N is N1 + 1.

% ---------------------------------
% Verificar si un atomo contiene una palabra
% ---------------------------------

contiene_palabra(Atomo, Palabra) :-
    atom(Atomo),
    atom(Palabra),
    sub_atom(Atomo, _, _, _, Palabra).

% ---------------------------------
% Concatenar lista de atomos en uno solo
% ---------------------------------

concatenar_atomos([], '').
concatenar_atomos([X], X).
concatenar_atomos([X|Xs], Result) :-
    concatenar_atomos(Xs, Rest),
    atom_concat(X, ' ', Temp),
    atom_concat(Temp, Rest, Result).

% ---------------------------------
% Imprimir par clave-valor
% ---------------------------------

imprimir_par(Clave, Valor) :-
    write(Clave), write(': '), write(Valor), nl.

% ---------------------------------
% Imprimir relacion A -> R -> B
% ---------------------------------

imprimir_relacion(A, R, B) :-
    write(A), write(' --'), write(R), write('--> '), write(B), nl.