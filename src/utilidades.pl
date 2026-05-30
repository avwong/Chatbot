mostrar_lista([]).
mostrar_lista([X|R]) :-
    write(X), nl,
    mostrar_lista(R).