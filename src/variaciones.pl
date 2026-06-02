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

responder(hermanos(X)) :-
    respuesta_hermanos(X), !.

responder(ancestros(X)) :-
    respuesta_ancestros(X), !.

responder(descendientes(X)) :-
    respuesta_descendientes(X), !.

responder(propiedades(X)) :-
    respuesta_tiene_todo(X), !.

responder(donde_vive(X)) :-
    respuesta_donde_vive(X), !.

responder(que_come(X)) :-
    respuesta_que_come(X), !.

responder(que_puede(X)) :-
    respuesta_que_puede(X), !.

responder(relaciones_de(X)) :-
    respuesta_relaciones_de(X), !.

responder(hola) :-
    write('Hola. Puedes preguntarme, ensenarme o pedir definiciones.'), nl, !.

responder(adios) :-
    write('Hasta luego.'), nl, !.

responder(gracias) :-
    write('De nada.'), nl, !.

