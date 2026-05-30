resolver_termino(T, R) :-
    equivalente(T, R), !.
resolver_termino(T, T).

concepto_con_sinonimo(T, D) :-
    resolver_termino(T, R),
    concepto_total(R, D), !.

es_un_con_sinonimo(A, B) :-
    resolver_termino(A, RA),
    resolver_termino(B, RB),
    es_un_total(RA, RB).