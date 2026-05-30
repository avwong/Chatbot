:- dynamic aprendido_concepto/2.
:- dynamic aprendido_es_un/2.
:- dynamic aprendido_relacion/3.
:- dynamic aprendido_sinonimo/2.

concepto_total(X, D) :- concepto(X, D).
concepto_total(X, D) :- aprendido_concepto(X, D).

es_un_total(X, Y) :- es_un(X, Y).
es_un_total(X, Y) :- aprendido_es_un(X, Y).

relacion_total(X, R, Y) :- relacion(X, R, Y).
relacion_total(X, R, Y) :- aprendido_relacion(X, R, Y).

sinonimo_total(X, Y) :- sinonimo(X, Y).
sinonimo_total(X, Y) :- aprendido_sinonimo(X, Y).

equivalente(X, X).
equivalente(X, Y) :- sinonimo_total(X, Y).
equivalente(X, Y) :- sinonimo_total(Y, X).