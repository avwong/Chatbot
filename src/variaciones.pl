responder(que_es(X)) :-
    respuesta_definicion(X), !.

responder(defina(X)) :-
    respuesta_definicion(X), !.

responder(explique(X)) :-
    respuesta_definicion(X), !.

responder(para_que_sirve(X)) :-
    respuesta_definicion(X), !.

responder(es_un(A, B)) :-
    respuesta_relacion(A, B), !.

responder(tiene(X, P)) :-
    respuesta_propiedad(X, P), !.

responder(listar_conceptos) :-
    findall(X, concepto_total(X, _), L),
    mostrar_lista(L), !.