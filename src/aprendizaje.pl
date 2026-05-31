% ---------------------------------
% Verificaciones de conocimiento
% ---------------------------------

existe_concepto(Termino) :-
    concepto_total(Termino, _), !.

existe_clasificacion(Elemento, Categoria) :-
    es_un_total(Elemento, Categoria), !.

existe_relacion(A, Relacion, B) :-
    relacion_total(A, Relacion, B), !.

% ---------------------------------
% Mensaje base cuando no sabe algo
% ---------------------------------

mensaje_desconocido(Termino) :-
    write('No poseo conocimiento suficiente sobre '),
    write(Termino),
    write('.'),
    nl.

% ---------------------------------
% Aprendizaje directo
% ---------------------------------

aprender_concepto(Termino, _) :-
    existe_concepto(Termino),
    write('Ese concepto ya existe en la base de conocimiento.'),
    nl, !.

aprender_concepto(Termino, Definicion) :-
    assertz(aprendido_concepto(Termino, Definicion)),
    write('Concepto aprendido correctamente.'),
    nl.

aprender_es_un(Elemento, Categoria) :-
    existe_clasificacion(Elemento, Categoria),
    write('Esa clasificacion ya existe en la base de conocimiento.'),
    nl, !.

aprender_es_un(Elemento, Categoria) :-
    assertz(aprendido_es_un(Elemento, Categoria)),
    write('Clasificacion aprendida correctamente.'),
    nl.

aprender_relacion(A, Relacion, B) :-
    existe_relacion(A, Relacion, B),
    write('Esa relacion ya existe en la base de conocimiento.'),
    nl, !.

aprender_relacion(A, Relacion, B) :-
    assertz(aprendido_relacion(A, Relacion, B)),
    write('Relacion aprendida correctamente.'),
    nl.

% ---------------------------------
% Integracion con conversacion
% ---------------------------------

responder(aprender_concepto(Termino, Definicion)) :-
    aprender_concepto(Termino, Definicion), !.

responder(aprender_es_un(Elemento, Categoria)) :-
    aprender_es_un(Elemento, Categoria), !.

responder(aprender_relacion(A, Relacion, B)) :-
    aprender_relacion(A, Relacion, B), !.

% ---------------------------------
% Aprendizaje interactivo
% ---------------------------------

aprender_concepto_interactivo(Termino) :-
    mensaje_desconocido(Termino),
    write('Digite una definicion para '),
    write(Termino),
    write(' o escriba cancelar.'),
    nl,
    read(Definicion),
    procesar_concepto(Termino, Definicion).

procesar_concepto(_, cancelar) :-
    write('Aprendizaje cancelado.'),
    nl, !.

procesar_concepto(Termino, Definicion) :-
    aprender_concepto(Termino, Definicion).

aprender_es_un_interactivo(Elemento) :-
    mensaje_desconocido(Elemento),
    write('Digite la categoria para '),
    write(Elemento),
    write(' o escriba cancelar.'),
    nl,
    read(Categoria),
    procesar_clasificacion(Elemento, Categoria).

procesar_clasificacion(_, cancelar) :-
    write('Aprendizaje cancelado.'),
    nl, !.

procesar_clasificacion(Elemento, Categoria) :-
    aprender_es_un(Elemento, Categoria).

aprender_relacion_interactiva(A) :-
    mensaje_desconocido(A),
    write('Digite la relacion que desea agregar para '),
    write(A),
    write(' o escriba cancelar.'),
    nl,
    read(Relacion),
    procesar_relacion_intermedia(A, Relacion).

procesar_relacion_intermedia(_, cancelar) :-
    write('Aprendizaje cancelado.'),
    nl, !.

procesar_relacion_intermedia(A, Relacion) :-
    write('Digite el valor relacionado o escriba cancelar.'),
    nl,
    read(B),
    procesar_relacion_final(A, Relacion, B).

procesar_relacion_final(_, _, cancelar) :-
    write('Aprendizaje cancelado.'),
    nl, !.

procesar_relacion_final(A, Relacion, B) :-
    aprender_relacion(A, Relacion, B).

% ---------------------------------
% Punto de entrada para cuando no sabe responder
% ---------------------------------

aprender_si_no_sabe(que_es(Termino)) :-
    aprender_concepto_interactivo(Termino), !.

aprender_si_no_sabe(defina(Termino)) :-
    aprender_concepto_interactivo(Termino), !.

aprender_si_no_sabe(explique(Termino)) :-
    aprender_concepto_interactivo(Termino), !.

aprender_si_no_sabe(para_que_sirve(Termino)) :-
    aprender_relacion_interactiva(Termino), !.

aprender_si_no_sabe(es_un(Elemento, _)) :-
    aprender_es_un_interactivo(Elemento), !.

aprender_si_no_sabe(_) :-
    write('No tengo suficiente conocimiento.'),
    nl,
    write('Puede ensenarme con:'),
    nl,
    write('  aprender_concepto(Termino, Definicion).'),
    nl,
    write('  aprender_es_un(Elemento, Categoria).'),
    nl,
    write('  aprender_relacion(A, Relacion, B).'),
    nl.