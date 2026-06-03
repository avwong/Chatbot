% =========================================
% inferencia.pl
% =========================================
% Motor de razonamiento y capa de respuestas.
%
% Contiene:
%   1. Reglas de inferencia (herencia de propiedades y
%      relaciones transitivas por jerarquia es_un).
%   2. responder/1: dado un termino estructurado producido
%      por nlp.pl, genera la respuesta del chatbot.
%   3. Aprendizaje directo ("aprender que X es Y").
%
% Depende de:
%   - conocimiento.pl (predicados *_total, resolver_termino...)
%   - main.pl (predicado de salida bot/1)

% =========================================
% REGLAS DE INFERENCIA
% =========================================

% Padre directo (un solo nivel, sin transitividad).
padre_directo(X, Y) :- es_un(X, Y).
padre_directo(X, Y) :- aprendido_es_un(X, Y).

% Propiedad: directa o heredada de una categoria padre.
tiene_propiedad(X, Prop) :-
    relacion_total(X, tiene, Prop).
tiene_propiedad(X, Prop) :-
    es_un_total(X, Y),
    relacion_total(Y, tiene, Prop).

% Relaciones especificas heredables por jerarquia.
vive_en(X, L)        :- relacion_total(X, vive_en, L).
vive_en(X, L)        :- es_un_total(X, Y), relacion_total(Y, vive_en, L).

se_alimenta_de(X, A) :- relacion_total(X, come, A).
se_alimenta_de(X, A) :- es_un_total(X, Y), relacion_total(Y, come, A).

puede_hacer(X, Acc)  :- relacion_total(X, puede, Acc).
puede_hacer(X, Acc)  :- es_un_total(X, Y), relacion_total(Y, puede, Acc).

% Hermanos: comparten un padre directo.
hermanos(X, Hermanos) :-
    findall(H,
        ( padre_directo(X, Padre),
          padre_directo(H, Padre),
          H \== X ),
        Lista),
    list_to_set(Lista, Hermanos).

% Ancestros: toda la cadena de jerarquia hacia arriba.
ancestros(X, Ancestros) :-
    findall(A, es_un_total(X, A), Lista),
    list_to_set(Lista, Ancestros).

% Descendientes: todos los que son tipo de X.
descendientes(X, Desc) :-
    findall(D, ( es_un_total(D, X), D \== X ), Lista),
    list_to_set(Lista, Desc).

% =========================================
% responder/1
% =========================================
% Cada clausula maneja una clase de intencion y termina con
% corte para no probar las demas. Si ninguna tiene exito,
% responder/1 falla y main.pl activa el aprendizaje guiado.

% --- Definiciones ---
responder(que_es(X))         :- respuesta_definicion(X), !.
responder(defina(X))         :- respuesta_definicion(X), !.
responder(explique(X))       :- respuesta_definicion(X), !.
responder(para_que_sirve(X)) :- respuesta_sirve_para(X), !.

% --- Inferencias puntuales ---
responder(tiene(X, P))       :- respuesta_propiedad(X, P), !.
responder(es_un(A, B))       :- respuesta_es_un(A, B), !.

% --- Consultas de jerarquia y relaciones ---
responder(hermanos(X))       :- respuesta_hermanos(X), !.
responder(ancestros(X))      :- respuesta_ancestros(X), !.
responder(descendientes(X))  :- respuesta_descendientes(X), !.
responder(propiedades(X))    :- respuesta_propiedades(X), !.
responder(donde_vive(X))     :- respuesta_donde_vive(X), !.
responder(que_come(X))       :- respuesta_que_come(X), !.
responder(que_puede(X))      :- respuesta_que_puede(X), !.
responder(relaciones_de(X))  :- respuesta_relaciones_de(X), !.
responder(canciones_de(X))   :- respuesta_canciones_de(X), !.
responder(albumes_de(X))     :- respuesta_albumes_de(X), !.

% --- Listados ---
responder(listar_conceptos)  :- respuesta_listar_conceptos, !.
responder(listar_relaciones) :- respuesta_listar_relaciones, !.
responder(listar_sinonimos)  :- respuesta_listar_sinonimos, !.

% --- Aprendizaje directo ---
responder(aprender_es_un(A, B))   :- aprender_es_un(A, B), !.
responder(aprender_sinonimo(A, B)):- aprender_sinonimo(A, B), !.

% --- Cortesia ---
responder(hola)    :- bot('Hola. Puede preguntarme, ensenarme o pedir definiciones.'), !.
responder(gracias) :- bot('De nada, para eso estoy.'), !.

% --- Dialogo aprendido directamente (frase -> respuesta) ---
responder(T) :-
    atom(T),
    dialogo_total(T, Respuesta), !,
    bot(Respuesta).

% --- Termino conocido: resumen consolidado ---
responder(T) :-
    atom(T),
    termino_conocido(T), !,
    resumen(T).

% =========================================
% Respuestas concretas
% =========================================

respuesta_definicion(Termino) :-
    concepto_con_sinonimo(Termino, Def),
    atom_concat('Definicion: ', Def, Msg),
    bot(Msg).

% Para que sirve: usa la relacion sirve_para; si no existe,
% cae a la definicion del termino.
respuesta_sirve_para(Termino) :-
    resolver_termino(Termino, R),
    relacion_total(R, sirve_para, Uso), !,
    atom_concat('Sirve para ', Uso, Msg),
    bot(Msg).
respuesta_sirve_para(Termino) :-
    respuesta_definicion(Termino).

respuesta_propiedad(X, Prop) :-
    resolver_termino(X, RX),
    tiene_propiedad(RX, Prop), !,
    atom_concat('Infiero que tiene ', Prop, Msg),
    bot(Msg).

respuesta_es_un(A, B) :-
    es_un_con_sinonimo(A, B), !,
    format(atom(Msg), 'Si, ~w es un tipo de ~w.', [A, B]),
    bot(Msg).

respuesta_hermanos(X) :-
    resolver_termino(X, RX),
    hermanos(RX, Hs), Hs \== [],
    format(atom(H), 'En la misma categoria que ~w estan:', [X]),
    bot(H),
    mostrar_items(Hs).

respuesta_ancestros(X) :-
    resolver_termino(X, RX),
    ancestros(RX, As), As \== [],
    format(atom(H), 'Categorias/ancestros de ~w:', [X]),
    bot(H),
    mostrar_items(As).

respuesta_descendientes(X) :-
    resolver_termino(X, RX),
    descendientes(RX, Ds), Ds \== [],
    format(atom(H), 'Tipos/descendientes de ~w:', [X]),
    bot(H),
    mostrar_items(Ds).

respuesta_propiedades(X) :-
    resolver_termino(X, RX),
    findall(P, tiene_propiedad(RX, P), L0),
    list_to_set(L0, Props), Props \== [],
    format(atom(H), 'Propiedades de ~w:', [X]),
    bot(H),
    mostrar_items(Props).

respuesta_donde_vive(X) :-
    resolver_termino(X, RX),
    findall(L, vive_en(RX, L), L0),
    list_to_set(L0, Lugares), Lugares \== [],
    format(atom(H), '~w vive en:', [X]),
    bot(H),
    mostrar_items(Lugares).

respuesta_que_come(X) :-
    resolver_termino(X, RX),
    findall(A, se_alimenta_de(RX, A), L0),
    list_to_set(L0, Alimentos), Alimentos \== [],
    format(atom(H), '~w se alimenta de:', [X]),
    bot(H),
    mostrar_items(Alimentos).

respuesta_que_puede(X) :-
    resolver_termino(X, RX),
    findall(A, puede_hacer(RX, A), L0),
    list_to_set(L0, Acciones), Acciones \== [],
    format(atom(H), '~w puede:', [X]),
    bot(H),
    mostrar_items(Acciones).

respuesta_relaciones_de(X) :-
    resolver_termino(X, RX),
    findall(R-Y, relacion_total(RX, R, Y), L0),
    list_to_set(L0, Rels), Rels \== [],
    format(atom(H), 'Relaciones de ~w:', [X]),
    bot(H),
    mostrar_relaciones(Rels).

respuesta_canciones_de(X) :-
    resolver_termino(X, RX),
    findall(C, relacion_total(RX, tiene_cancion, C), L0),
    list_to_set(L0, Canciones), Canciones \== [],
    format(atom(H), 'Canciones de ~w:', [X]),
    bot(H),
    mostrar_items(Canciones).

respuesta_albumes_de(X) :-
    resolver_termino(X, RX),
    findall(A, relacion_total(RX, tiene_album, A), L0),
    list_to_set(L0, Albumes), Albumes \== [],
    format(atom(H), 'Albumes de ~w:', [X]),
    bot(H),
    mostrar_items(Albumes).

% --- Listados globales ---
respuesta_listar_conceptos :-
    findall(X, concepto_total(X, _), L0),
    list_to_set(L0, L), L \== [],
    bot('Conceptos que conozco:'),
    mostrar_items(L).

respuesta_listar_relaciones :-
    findall(A-R-B, relacion_total(A, R, B), L0),
    list_to_set(L0, L), L \== [],
    bot('Relaciones que conozco:'),
    mostrar_triples(L).

respuesta_listar_sinonimos :-
    findall(X-Y, sinonimo_total(X, Y), L0),
    list_to_set(L0, L), L \== [],
    bot('Sinonimos que conozco:'),
    mostrar_pares(L).

% --- Resumen consolidado de un termino conocido ---
resumen(Termino) :-
    format(atom(H), 'Esto es lo que se sobre ~w:', [Termino]),
    bot(H),
    ( respuesta_definicion(Termino)    -> true ; true ),
    ( respuesta_ancestros(Termino)     -> true ; true ),
    ( respuesta_relaciones_de(Termino) -> true ; true ).

% =========================================
% Helpers de presentacion de listas
% =========================================

mostrar_items([]).
mostrar_items([X|R]) :-
    write('           - '), write(X), nl,
    mostrar_items(R).

mostrar_relaciones([]).
mostrar_relaciones([R-Y|Resto]) :-
    write('           - '), write(R), write(' -> '), write(Y), nl,
    mostrar_relaciones(Resto).

mostrar_pares([]).
mostrar_pares([X-Y|Resto]) :-
    write('           - '), write(X), write(' = '), write(Y), nl,
    mostrar_pares(Resto).

mostrar_triples([]).
mostrar_triples([A-R-B|Resto]) :-
    write('           - '), write(A), write(' '), write(R), write(' '), write(B), nl,
    mostrar_triples(Resto).

% =========================================
% APRENDIZAJE DIRECTO
% =========================================
% Se dispara desde frases del tipo "aprender que X es Y" /
% "aprender que X significa Y" (ver nlp.pl).

aprender_es_un(Elemento, Categoria) :-
    es_un_total(Elemento, Categoria), !,
    bot('Esa clasificacion ya existe en la base de conocimiento.').
aprender_es_un(Elemento, Categoria) :-
    assertz(aprendido_es_un(Elemento, Categoria)),
    guardar_aprendido,
    bot('Clasificacion aprendida correctamente.').

aprender_sinonimo(A, B) :-
    sinonimo_total(A, B), !,
    bot('Ese sinonimo ya existe en la base de conocimiento.').
aprender_sinonimo(A, B) :-
    assertz(aprendido_sinonimo(A, B)),
    guardar_sinonimos,
    bot('Sinonimo aprendido correctamente.').
