:- multifile responder/1.

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

responder(listar_relaciones) :-
    findall((A, R, B), relacion_total(A, R, B), L),
    mostrar_lista(L), !.

responder(listar_sinonimos) :-
    findall((X, Y), sinonimo_total(X, Y), L),
    mostrar_lista(L), !.

responder(listar_definiciones) :-
    findall(X-D, concepto_total(X, D), L),
    mostrar_lista(L), !.

responder(hola) :-
    write('Hola. Puedes preguntarme, enseñarme o pedir definiciones.'), nl, !.

responder(adios) :-
    write('Hasta luego.'), nl, !.

responder(gracias) :-
    write('De nada.'), nl, !.
