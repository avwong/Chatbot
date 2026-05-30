tiene_propiedad(X, Prop) :-
    relacion_total(X, tiene, Prop).

tiene_propiedad(X, Prop) :-
    es_un_total(X, Y),
    tiene_propiedad(Y, Prop).

respuesta_definicion(Termino) :-
    concepto_con_sinonimo(Termino, Def),
    write(Termino), write(' es '), write(Def), nl.

respuesta_relacion(A, B) :-
    es_un_con_sinonimo(A, B),
    write('si'), nl.

respuesta_propiedad(X, Prop) :-
    tiene_propiedad(X, Prop),
    write(X), write(' tiene '), write(Prop), nl.