:- multifile responder/1.

responder(aprender_concepto(X, D)) :-
    assertz(aprendido_concepto(X, D)),
    guardar_aprendido,
    write('Aprendido.'), nl, !.

responder(aprender_es_un(A, B)) :-
    assertz(aprendido_es_un(A, B)),
    guardar_aprendido,
    write('Clasificacion aprendida.'), nl, !.

responder(aprender_relacion(A, R, B)) :-
    assertz(aprendido_relacion(A, R, B)),
    guardar_aprendido,
    write('Relacion aprendida.'), nl, !.

responder(aprender_sinonimo(A, B)) :-
    assertz(aprendido_sinonimo(A, B)),
    guardar_sinonimos,
    write('Sinonimo aprendido.'), nl, !.

aprender_si_no_sabe(_) :-
    write('No tengo suficiente conocimiento sobre eso.'), nl,
    write('Puede ensenarme con:'), nl,
    write('  aprender_concepto(termino, definicion).'), nl,
    write('  aprender_es_un(tema, categoria).'), nl,
    write('  aprender_relacion(tema, relacion, valor).'), nl,
    write('  aprender_sinonimo(a, b).'), nl.