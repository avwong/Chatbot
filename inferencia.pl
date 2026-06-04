% =========================================
% inferencia.pl
% =========================================
% Motor de razonamiento y capa de respuestas.
%
% Este archivo:
%   1. Responde consultas a partir de la base de conocimiento.
%   2. Maneja aprendizaje directo e interactivo.
%   3. Canoniza términos (sin tildes, con '_' y en minúscula).
%   4. Normaliza el conocimiento aprendido para evitar duplicados
%      como pais / país.
%
% Depende de:
%   - conocimiento.pl
%   - main.pl

:- dynamic normalizacion_ejecutada/0.

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
vive_en(X, L) :-
    relacion_total(X, vive_en, L).
vive_en(X, L) :-
    es_un_total(X, Y),
    relacion_total(Y, vive_en, L).

se_alimenta_de(X, A) :-
    relacion_total(X, come, A).
se_alimenta_de(X, A) :-
    es_un_total(X, Y),
    relacion_total(Y, come, A).

puede_hacer(X, Acc) :-
    relacion_total(X, puede, Acc).
puede_hacer(X, Acc) :-
    es_un_total(X, Y),
    relacion_total(Y, puede, Acc).

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
    findall(D, (es_un_total(D, X), D \== X), Lista),
    list_to_set(Lista, Desc).

% =========================================
% CANONIZACION Y NORMALIZACION
% =========================================

canonizar_atomo(Entrada, Canonico) :-
    atom(Entrada), !,
    atom_string(Entrada, Texto),
    texto_libre_a_termino(Texto, Canonico).
canonizar_atomo(Entrada, Canonico) :-
    string(Entrada), !,
    texto_libre_a_termino(Entrada, Canonico).
canonizar_atomo(Entrada, Entrada).

texto_libre_a_termino(Texto0, Termino) :-
    ( atom(Texto0) ->
        atom_string(Texto0, Texto)
    ; string(Texto0) ->
        Texto = Texto0
    ; term_string(Texto0, Texto)
    ),
    split_string(Texto, " ", " \t\n\r.,;:!?¡¿", Partes0),
    exclude(=(""), Partes0, Partes),
    atomic_list_concat(Partes, '_', Atom0),
    downcase_atom(Atom0, Lower),
    normalizar_ascii_inferencia(Lower, Termino).

normalizar_ascii_inferencia(Atom, Out) :-
    atom_chars(Atom, Chars),
    maplist(reemplazar_caracter_inferencia, Chars, Nuevos),
    atom_chars(Out, Nuevos).

reemplazar_caracter_inferencia('á', 'a').
reemplazar_caracter_inferencia('é', 'e').
reemplazar_caracter_inferencia('í', 'i').
reemplazar_caracter_inferencia('ó', 'o').
reemplazar_caracter_inferencia('ú', 'u').
reemplazar_caracter_inferencia('Á', 'a').
reemplazar_caracter_inferencia('É', 'e').
reemplazar_caracter_inferencia('Í', 'i').
reemplazar_caracter_inferencia('Ó', 'o').
reemplazar_caracter_inferencia('Ú', 'u').
reemplazar_caracter_inferencia('ñ', 'n').
reemplazar_caracter_inferencia('Ñ', 'n').
reemplazar_caracter_inferencia(C, C).

canonizar_termino_inferencia(TerminoIn, TerminoOut) :-
    canonizar_atomo(TerminoIn, TerminoOut).

canonico_si_existe(T0, R) :-
    canonizar_atomo(T0, T),
    resolver_termino(T, R0), !,
    R = R0.
canonico_si_existe(T, T).

% -----------------------------------------
% Normalizacion del conocimiento aprendido
% -----------------------------------------
% Esto limpia duplicados tipo pais/país cargados desde
% archivos viejos, y deja solo la versión canonizada.

asegurar_normalizacion_inicial :-
    normalizacion_ejecutada, !.
asegurar_normalizacion_inicial :-
    normalizar_aprendido,
    guardar_aprendido,
    guardar_sinonimos,
    assertz(normalizacion_ejecutada).

normalizar_aprendido :-
    normalizar_aprendido_conceptos,
    normalizar_aprendido_es_un,
    normalizar_aprendido_relaciones,
    normalizar_aprendido_dialogos,
    normalizar_aprendido_sinonimos.

normalizar_aprendido_conceptos :-
    findall(T-D, aprendido_concepto(T, D), L0),
    maplist(canonizar_par_concepto, L0, L1),
    sort(L1, L),
    retractall(aprendido_concepto(_, _)),
    forall(member(T-D, L), assertz(aprendido_concepto(T, D))).

canonizar_par_concepto(T-D, TC-D) :-
    canonizar_atomo(T, TC).

normalizar_aprendido_es_un :-
    findall(A-B, aprendido_es_un(A, B), L0),
    maplist(canonizar_par_es_un, L0, L1),
    sort(L1, L),
    retractall(aprendido_es_un(_, _)),
    forall(member(A-B, L), assertz(aprendido_es_un(A, B))).

canonizar_par_es_un(A-B, AC-BC) :-
    canonizar_atomo(A, AC),
    canonizar_atomo(B, BC).

normalizar_aprendido_relaciones :-
    findall(A-R-B, aprendido_relacion(A, R, B), L0),
    maplist(canonizar_par_relacion, L0, L1),
    sort(L1, L),
    retractall(aprendido_relacion(_, _, _)),
    forall(member(A-R-B, L), assertz(aprendido_relacion(A, R, B))).

canonizar_par_relacion(A-R-B, AC-RC-BC) :-
    canonizar_atomo(A, AC),
    canonizar_atomo(R, RC),
    canonizar_atomo(B, BC).

normalizar_aprendido_dialogos :-
    findall(T-R, aprendido_dialogo(T, R), L0),
    maplist(canonizar_par_dialogo, L0, L1),
    sort(L1, L),
    retractall(aprendido_dialogo(_, _)),
    forall(member(T-R, L), assertz(aprendido_dialogo(T, R))).

canonizar_par_dialogo(T-R, TC-R) :-
    canonizar_atomo(T, TC).

normalizar_aprendido_sinonimos :-
    findall(A-B, aprendido_sinonimo(A, B), L0),
    maplist(canonizar_par_sinonimo, L0, L1),
    sort(L1, L),
    retractall(aprendido_sinonimo(_, _)),
    forall(member(A-B, L), assertz(aprendido_sinonimo(A, B))).

canonizar_par_sinonimo(A-B, AC-BC) :-
    canonizar_atomo(A, AC),
    canonizar_atomo(B, BC).

% =========================================
% DIALOGO APOYADO POR SINONIMOS
% =========================================

dialogo_con_sinonimo(T, Respuesta) :-
    dialogo_total(T, Respuesta), !.
dialogo_con_sinonimo(T, Respuesta) :-
    equivalente(T, R),
    R \== T,
    dialogo_total(R, Respuesta), !.

% =========================================
% responder/1
% =========================================

responder(Entrada) :-
    asegurar_normalizacion_inicial,
    responder_interno(Entrada).

% --- Definiciones ---
responder_interno(que_es(X))         :- respuesta_definicion(X), !.
responder_interno(defina(X))         :- respuesta_definicion(X), !.
responder_interno(explique(X))       :- respuesta_definicion(X), !.
responder_interno(para_que_sirve(X)) :- respuesta_sirve_para(X), !.

% --- Inferencias puntuales ---
responder_interno(tiene(X, P))       :- respuesta_propiedad(X, P), !.
responder_interno(es_un(A, B))       :- respuesta_es_un(A, B), !.

% --- Consultas de jerarquia y relaciones ---
responder_interno(hermanos(X))       :- respuesta_hermanos(X), !.
responder_interno(ancestros(X))      :- respuesta_ancestros(X), !.
responder_interno(descendientes(X))  :- respuesta_descendientes(X), !.
responder_interno(propiedades(X))    :- respuesta_propiedades(X), !.
responder_interno(donde_vive(X))     :- respuesta_donde_vive(X), !.
responder_interno(de_donde_es(X))    :- respuesta_de_donde_es(X), !.
responder_interno(que_come(X))       :- respuesta_que_come(X), !.
responder_interno(que_puede(X))      :- respuesta_que_puede(X), !.
responder_interno(relaciones_de(X))  :- respuesta_relaciones_de(X), !.

% --- Listados ---
responder_interno(listar_conceptos)  :- respuesta_listar_conceptos, !.
responder_interno(listar_relaciones) :- respuesta_listar_relaciones, !.
responder_interno(listar_sinonimos)  :- respuesta_listar_sinonimos, !.

% --- Aprendizaje directo ---
responder_interno(aprender_es_un(A, B))       :- aprender_es_un(A, B), !.
responder_interno(aprender_sinonimo(A, B))    :- aprender_sinonimo(A, B), !.
responder_interno(aprender_relacion(A, R, B)) :- aprender_relacion(A, R, B), !.

% --- Cortesia ---
responder_interno(hola)    :- bot('Hola. Puede preguntarme, ensenarme o pedir definiciones.'), !.
responder_interno(gracias) :- bot('De nada, para eso estoy.'), !.

% --- Dialogo aprendido directamente (frase -> respuesta) ---
responder_interno(T) :-
    atom(T),
    dialogo_con_sinonimo(T, Respuesta), !,
    bot(Respuesta).

% --- Termino conocido: resumen consolidado ---
responder_interno(T) :-
    atom(T),
    termino_conocido(T), !,
    resumen(T).

% =========================================
% RESPUESTAS CONCRETAS
% =========================================

respuesta_definicion(Termino) :-
    concepto_con_sinonimo(Termino, Def),
    atom_concat('Definicion: ', Def, Msg),
    bot(Msg).

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
    hermanos(RX, Hs),
    Hs \== [],
    format(atom(H), 'En la misma categoria que ~w estan:', [X]),
    bot(H),
    mostrar_items(Hs).

respuesta_ancestros(X) :-
    resolver_termino(X, RX),
    ancestros(RX, As),
    As \== [],
    format(atom(H), 'Categorias/ancestros de ~w:', [X]),
    bot(H),
    mostrar_items(As).

respuesta_descendientes(X) :-
    resolver_termino(X, RX),
    descendientes(RX, Ds),
    Ds \== [],
    format(atom(H), 'Tipos/descendientes de ~w:', [X]),
    bot(H),
    mostrar_items(Ds).

respuesta_propiedades(X) :-
    resolver_termino(X, RX),
    findall(P, tiene_propiedad(RX, P), L0),
    list_to_set(L0, Props),
    Props \== [],
    format(atom(H), 'Propiedades de ~w:', [X]),
    bot(H),
    mostrar_items(Props).

respuesta_donde_vive(X) :-
    resolver_termino(X, RX),
    findall(L, vive_en(RX, L), L0),
    list_to_set(L0, Lugares),
    Lugares \== [],
    format(atom(H), '~w vive en:', [X]),
    bot(H),
    mostrar_items(Lugares).

respuesta_de_donde_es(X) :-
    resolver_termino(X, RX),
    findall(L, relacion_total(RX, es_de, L), L0),
    list_to_set(L0, Lugares),
    Lugares \== [],
    format(atom(H), '~w es de:', [X]),
    bot(H),
    mostrar_items(Lugares).

respuesta_que_come(X) :-
    resolver_termino(X, RX),
    findall(A, se_alimenta_de(RX, A), L0),
    list_to_set(L0, Alimentos),
    Alimentos \== [],
    format(atom(H), '~w se alimenta de:', [X]),
    bot(H),
    mostrar_items(Alimentos).

respuesta_que_puede(X) :-
    resolver_termino(X, RX),
    findall(A, puede_hacer(RX, A), L0),
    list_to_set(L0, Acciones),
    Acciones \== [],
    format(atom(H), '~w puede:', [X]),
    bot(H),
    mostrar_items(Acciones).

respuesta_relaciones_de(X) :-
    resolver_termino(X, RX),
    findall(R-Y, relacion_total(RX, R, Y), L0),
    list_to_set(L0, Rels),
    Rels \== [],
    format(atom(H), 'Relaciones de ~w:', [X]),
    bot(H),
    mostrar_relaciones(Rels).

% --- Listados globales ---
respuesta_listar_conceptos :-
    findall(X, concepto_total(X, _), L0),
    list_to_set(L0, L),
    L \== [],
    bot('Conceptos que conozco:'),
    mostrar_items(L).

respuesta_listar_relaciones :-
    findall(A-R-B, relacion_total(A, R, B), L0),
    list_to_set(L0, L),
    L \== [],
    bot('Relaciones que conozco:'),
    mostrar_triples(L).

respuesta_listar_sinonimos :-
    findall(X-Y, sinonimo_total(X, Y), L0),
    list_to_set(L0, L),
    L \== [],
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
% HELPERS DE PRESENTACION
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

aprender_es_un(Elemento0, Categoria0) :-
    canonizar_atomo(Elemento0, Elemento),
    canonizar_atomo(Categoria0, Categoria),
    es_un_total(Elemento, Categoria), !,
    bot('Esa clasificacion ya existe en la base de conocimiento.').

aprender_es_un(Elemento0, Categoria0) :-
    canonizar_atomo(Elemento0, Elemento),
    canonizar_atomo(Categoria0, Categoria),
    assertz(aprendido_es_un(Elemento, Categoria)),
    normalizar_aprendido,
    guardar_aprendido,
    bot('Clasificacion aprendida correctamente.').

aprender_sinonimo(A0, B0) :-
    canonizar_atomo(A0, A),
    canonizar_atomo(B0, B),
    sinonimo_total(A, B), !,
    bot('Ese sinonimo ya existe en la base de conocimiento.').

aprender_sinonimo(A0, B0) :-
    canonizar_atomo(A0, A),
    canonizar_atomo(B0, B),
    assertz(aprendido_sinonimo(A, B)),
    normalizar_aprendido,
    guardar_sinonimos,
    bot('Sinonimo aprendido correctamente.').

% -----------------------------------------
% Aprendizaje de relaciones genericas
% -----------------------------------------

aprender_relacion(A0, Relacion0, B0) :-
    asegurar_termino_conocido(A0),
    asegurar_termino_conocido(B0),
    canonizar_atomo(A0, A1),
    canonizar_atomo(Relacion0, Relacion),
    canonizar_atomo(B0, B1),
    canonico_si_existe(A1, A),
    canonico_si_existe(B1, B),
    relacion_total(A, Relacion, B), !,
    bot('Esa relacion ya existe en la base de conocimiento.').

aprender_relacion(A0, Relacion0, B0) :-
    asegurar_termino_conocido(A0),
    asegurar_termino_conocido(B0),
    canonizar_atomo(A0, A1),
    canonizar_atomo(Relacion0, Relacion),
    canonizar_atomo(B0, B1),
    canonico_si_existe(A1, A),
    canonico_si_existe(B1, B),
    assertz(aprendido_relacion(A, Relacion, B)),
    normalizar_aprendido,
    guardar_aprendido,
    bot('Relacion aprendida correctamente.').

% =========================================
% APRENDIZAJE GUIADO RECURSIVO DE TERMINOS
% =========================================

asegurar_termino_conocido(TerminoIn) :-
    canonizar_termino_inferencia(TerminoIn, Termino),
    termino_conocido(Termino), !.

asegurar_termino_conocido(TerminoIn) :-
    canonizar_termino_inferencia(TerminoIn, Termino),
    format(atom(Msg), 'No conozco "~w". Voy a aprenderlo primero.', [Termino]),
    bot(Msg),
    preguntar_aprendizaje('¿Como debo responder cuando me digan', Termino, Respuesta),
    preguntar_aprendizaje('¿Cual es la definicion de', Termino, Definicion),
    preguntar_aprendizaje('¿Cual es la categoria de', Termino, CategoriaTexto),
    aprender_dialogo_si_hay(Termino, Respuesta),
    aprender_concepto_si_hay(Termino, Definicion),
    aprender_categoria_si_hay(Termino, CategoriaTexto),
    normalizar_aprendido,
    guardar_aprendido.

preguntar_aprendizaje(Pregunta, Termino, Texto) :-
    format('Chatbot> ~w "~w"? (Enter para omitir): ', [Pregunta, Termino]),
    flush_output,
    read_line_to_string(user_input, Raw),
    ( Raw == end_of_file ->
        Texto = ""
    ; normalize_space(string(Texto), Raw)
    ).

aprender_dialogo_si_hay(_, "") :- !.
aprender_dialogo_si_hay(Termino0, Respuesta) :-
    canonizar_atomo(Termino0, Termino),
    atom_string(RespuestaAtom, Respuesta),
    ( dialogo_total(Termino, RespuestaAtom) ->
        true
    ; assertz(aprendido_dialogo(Termino, RespuestaAtom))
    ).

aprender_concepto_si_hay(_, "") :- !.
aprender_concepto_si_hay(Termino0, Definicion) :-
    canonizar_atomo(Termino0, Termino),
    atom_string(DefinicionAtom, Definicion),
    ( concepto_total(Termino, _) ->
        true
    ; assertz(aprendido_concepto(Termino, DefinicionAtom))
    ).

aprender_categoria_si_hay(_, "") :- !.
aprender_categoria_si_hay(Termino0, CategoriaTexto0) :-
    canonizar_atomo(Termino0, Termino),
    canonizar_atomo(CategoriaTexto0, CategoriaCanonica),
    ( CategoriaCanonica == Termino ->
        bot('La categoria no puede ser igual al termino.')
    ; asegurar_termino_conocido(CategoriaCanonica),
      canonico_si_existe(CategoriaCanonica, Categoria),
      ( es_un_total(Termino, Categoria) ->
          true
      ; assertz(aprendido_es_un(Termino, Categoria))
      )
    ).