% =========================================
% Modulo de Inferencias Logicas
% =========================================
% Este modulo implementa el razonamiento logico
% del chatbot: herencia de propiedades, relaciones
% transitivas, y generacion de conclusiones.

% ---------------------------------
% Herencia de propiedades por jerarquia
% ---------------------------------

% X tiene la propiedad Prop directamente
tiene_propiedad(X, Prop) :-
    relacion_total(X, tiene, Prop).

% X hereda la propiedad Prop de su categoria padre
tiene_propiedad(X, Prop) :-
    es_un_total(X, Y),
    tiene_propiedad(Y, Prop).

% ---------------------------------
% Padre directo (sin transitividad)
% ---------------------------------

padre_directo(X, Y) :- es_un(X, Y).
padre_directo(X, Y) :- aprendido_es_un(X, Y).

% ---------------------------------
% Hermanos: comparten padre directo
% ---------------------------------

hermanos(X, Hermanos) :-
    findall(H,
        (padre_directo(X, Padre),
         padre_directo(H, Padre),
         H \== X),
        Lista),
    lista_sin_duplicados(Lista, Hermanos).

% ---------------------------------
% Ancestros: toda la cadena de jerarquia
% ---------------------------------

ancestros(X, Ancestros) :-
    findall(A, es_un_total(X, A), Lista),
    lista_sin_duplicados(Lista, Ancestros).

% ---------------------------------
% Descendientes: todos los que son tipo de X
% ---------------------------------

descendientes(X, Desc) :-
    findall(D, (es_un_total(D, X), D \== X), Lista),
    lista_sin_duplicados(Lista, Desc).

% ---------------------------------
% Comparten categoria
% ---------------------------------

comparten_categoria(X, Y, Cat) :-
    X \== Y,
    padre_directo(X, Cat),
    padre_directo(Y, Cat).

% ---------------------------------
% Todas las propiedades (directas + heredadas)
% ---------------------------------

todas_las_propiedades(X, Props) :-
    findall(P, tiene_propiedad(X, P), Lista),
    lista_sin_duplicados(Lista, Props).

% ---------------------------------
% Todas las relaciones de un concepto
% ---------------------------------

todas_las_relaciones(X, Rels) :-
    findall(R-Y, relacion_total(X, R, Y), Lista),
    lista_sin_duplicados(Lista, Rels).

% ---------------------------------
% Inferencias especificas por tipo de relacion
% ---------------------------------

% Donde vive: directo o heredado
vive_en(X, Lugar) :-
    relacion_total(X, vive_en, Lugar).
vive_en(X, Lugar) :-
    es_un_total(X, Y),
    vive_en(Y, Lugar).

% Que come: directo o heredado
se_alimenta_de(X, Alimento) :-
    relacion_total(X, come, Alimento).
se_alimenta_de(X, Alimento) :-
    es_un_total(X, Y),
    se_alimenta_de(Y, Alimento).

% Que puede hacer: directo o heredado
puede_hacer(X, Accion) :-
    relacion_total(X, puede, Accion).
puede_hacer(X, Accion) :-
    es_un_total(X, Y),
    puede_hacer(Y, Accion).

% Que produce: directo o heredado
produce(X, Producto) :-
    relacion_total(X, produce, Producto).
produce(X, Producto) :-
    es_un_total(X, Y),
    produce(Y, Producto).

% =========================================
% Predicados de respuesta con inferencia
% =========================================

% ---------------------------------
% Respuesta: definicion de un termino
% ---------------------------------

respuesta_definicion(Termino) :-
    concepto_con_sinonimo(Termino, Def),
    write(Termino), write(' es '), write(Def), nl.

% ---------------------------------
% Respuesta: relacion es_un entre dos terminos
% ---------------------------------

respuesta_relacion(A, B) :-
    es_un_con_sinonimo(A, B),
    write('Si, '), write(A), write(' es un '), write(B), write('.'), nl.

% ---------------------------------
% Respuesta: propiedad de un termino
% ---------------------------------

respuesta_propiedad(X, Prop) :-
    tiene_propiedad(X, Prop),
    write(X), write(' tiene '), write(Prop), write('.'), nl.

% ---------------------------------
% Respuesta: hermanos de X
% ---------------------------------

respuesta_hermanos(X) :-
    resolver_termino(X, RX),
    hermanos(RX, Hermanos),
    Hermanos \== [],
    write('Los elementos en la misma categoria que '), write(X), write(' son:'), nl,
    mostrar_lista_con_guion(Hermanos).

% ---------------------------------
% Respuesta: ancestros de X
% ---------------------------------

respuesta_ancestros(X) :-
    resolver_termino(X, RX),
    ancestros(RX, Ancestros),
    Ancestros \== [],
    write('Los ancestros/categorias de '), write(X), write(' son:'), nl,
    mostrar_lista_con_guion(Ancestros).

% ---------------------------------
% Respuesta: descendientes de X
% ---------------------------------

respuesta_descendientes(X) :-
    resolver_termino(X, RX),
    descendientes(RX, Desc),
    Desc \== [],
    write('Los descendientes/tipos de '), write(X), write(' son:'), nl,
    mostrar_lista_con_guion(Desc).

% ---------------------------------
% Respuesta: todas las propiedades
% ---------------------------------

respuesta_tiene_todo(X) :-
    resolver_termino(X, RX),
    todas_las_propiedades(RX, Props),
    Props \== [],
    write('Propiedades de '), write(X), write(':'), nl,
    mostrar_lista_con_guion(Props).

% ---------------------------------
% Respuesta: todas las relaciones
% ---------------------------------

respuesta_relaciones_de(X) :-
    resolver_termino(X, RX),
    todas_las_relaciones(RX, Rels),
    Rels \== [],
    write('Relaciones de '), write(X), write(':'), nl,
    mostrar_relaciones(Rels).

% ---------------------------------
% Respuesta: donde vive X
% ---------------------------------

respuesta_donde_vive(X) :-
    resolver_termino(X, RX),
    findall(L, vive_en(RX, L), Lista),
    lista_sin_duplicados(Lista, Lugares),
    Lugares \== [],
    write(X), write(' vive en:'), nl,
    mostrar_lista_con_guion(Lugares).

% ---------------------------------
% Respuesta: que come X
% ---------------------------------

respuesta_que_come(X) :-
    resolver_termino(X, RX),
    findall(A, se_alimenta_de(RX, A), Lista),
    lista_sin_duplicados(Lista, Alimentos),
    Alimentos \== [],
    write(X), write(' se alimenta de:'), nl,
    mostrar_lista_con_guion(Alimentos).

% ---------------------------------
% Respuesta: que puede hacer X
% ---------------------------------

respuesta_que_puede(X) :-
    resolver_termino(X, RX),
    findall(A, puede_hacer(RX, A), Lista),
    lista_sin_duplicados(Lista, Acciones),
    Acciones \== [],
    write(X), write(' puede:'), nl,
    mostrar_lista_con_guion(Acciones).