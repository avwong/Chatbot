% =========================================
% nlp.pl
% =========================================
% Procesamiento de lenguaje natural (espanol).
% Convierte el texto crudo del usuario en un termino
% Prolog estructurado que inferencia.pl sabe responder.
%
% Pipeline:
%   "Que es Prolog?"  -> [parse_entrada] -> que_es(prolog)
%
% parse_entrada/2 intenta, en orden:
%   1. Interpretar la linea como un termino Prolog valido.
%   2. Interpretarla como una frase en espanol (patrones).

parse_entrada(Linea, Termino) :-
    catch(term_string(T, Linea), _, fail),
    nonvar(T), !,
    Termino = T.
parse_entrada(Linea, Termino) :-
    normalizar_frase(Linea, Termino), !.

% -----------------------------------------
% Normalizacion: minusculas, sin signos de
% apertura, espacios colapsados -> atomo.
% -----------------------------------------

normalizar_frase(Linea, Termino) :-
    string_lower(Linea, Lower),
    normalize_space(atom(Sin), Lower),
    quitar_apertura(Sin, Clean0),
    normalizar_ascii(Clean0, Clean),
    ( phrase_que_es(Clean, Termino)
    ; phrase_defina(Clean, Termino)
    ; phrase_explique(Clean, Termino)
    ; phrase_para_que_sirve(Clean, Termino)
    ; phrase_aprender(Clean, Termino)
    ; phrase_tiene(Clean, Termino)
    ; phrase_hermanos(Clean, Termino)
    ; phrase_ancestros(Clean, Termino)
    ; phrase_descendientes(Clean, Termino)
    ; phrase_propiedades(Clean, Termino)
    ; phrase_donde_vive(Clean, Termino)
    ; phrase_de_donde_es(Clean, Termino)
    ; phrase_que_come(Clean, Termino)
    ; phrase_que_puede(Clean, Termino)
    ; phrase_relaciones_de(Clean, Termino)
    ; phrase_listar(Clean, Termino)
    ; phrase_salir(Clean, Termino)
    ; phrase_cortesia(Clean, Termino)
    ; texto_a_termino(Clean, Termino)
    ), !.

% Quita los signos de apertura del espanol (¿ ¡) al inicio.
quitar_apertura(A, Out) :-
    ( atom_concat('¿', Resto, A) -> quitar_apertura(Resto, Out)
    ; atom_concat('¡', Resto, A) -> quitar_apertura(Resto, Out)
    ; Out = A
    ).

normalizar_ascii(Atom, Out) :-
    atom_chars(Atom, Chars),
    maplist(reemplazar_caracter, Chars, Nuevos),
    atom_chars(Out, Nuevos).

reemplazar_caracter('á', 'a').
reemplazar_caracter('é', 'e').
reemplazar_caracter('í', 'i').
reemplazar_caracter('ó', 'o').
reemplazar_caracter('ú', 'u').
reemplazar_caracter('Á', 'a').
reemplazar_caracter('É', 'e').
reemplazar_caracter('Í', 'i').
reemplazar_caracter('Ó', 'o').
reemplazar_caracter('Ú', 'u').
reemplazar_caracter('ñ', 'n').
reemplazar_caracter('Ñ', 'n').
reemplazar_caracter(C, C).

% =========================================
% Patrones de frase -> termino
% =========================================

phrase_que_es(Clean, que_es(X)) :-
    ( atom_concat('que es ', Resto, Clean)
    ; atom_concat('qué es ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_defina(Clean, defina(X)) :-
    ( atom_concat('defina ', Resto, Clean)
    ; atom_concat('define ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_explique(Clean, explique(X)) :-
    ( atom_concat('explique ', Resto, Clean)
    ; atom_concat('explica ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_para_que_sirve(Clean, para_que_sirve(X)) :-
    ( atom_concat('para que sirve ', Resto, Clean)
    ; atom_concat('para qué sirve ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

% "X tiene Y" -> tiene(X, Y)
phrase_tiene(Clean, tiene(X, P)) :-
    sub_atom(Clean, Antes, _, _, ' tiene '),
    sub_atom(Clean, 0, Antes, _, Izq),
    Despues is Antes + 7,
    sub_atom(Clean, Despues, _, 0, Der),
    termino_limpio(Izq, X),
    termino_limpio(Der, P).

% =========================================
% Aprendizaje desde lenguaje natural
% =========================================
% OJO:
%   - "es de" debe interpretarse como relacion(es_de)
%   - "es" solo como clasificacion si NO contiene "es de"

phrase_aprender(Clean, aprender_sinonimo(A, B)) :-
    prefijo_aprender(Clean, Resto),
    sub_atom(Resto, Antes, _, _, ' significa '),
    sub_atom(Resto, 0, Antes, _, AText),
    Inicio is Antes + 10,
    sub_atom(Resto, Inicio, _, 0, BText),
    termino_limpio(AText, A),
    termino_limpio(BText, B).

% Casos especiales de relacion para evitar choque con "es"
phrase_aprender(Clean, aprender_relacion(A, es_de, B)) :-
    prefijo_aprender(Clean, Resto),
    sub_atom(Resto, Antes, _, _, ' es de '),
    sub_atom(Resto, 0, Antes, _, AText),
    Inicio is Antes + 7,
    sub_atom(Resto, Inicio, _, 0, BText),
    termino_limpio(AText, A),
    termino_limpio(BText, B).

phrase_aprender(Clean, aprender_relacion(A, vive_en, B)) :-
    prefijo_aprender(Clean, Resto),
    sub_atom(Resto, Antes, _, _, ' vive en '),
    sub_atom(Resto, 0, Antes, _, AText),
    Inicio is Antes + 9,
    sub_atom(Resto, Inicio, _, 0, BText),
    termino_limpio(AText, A),
    termino_limpio(BText, B).

% Resto de relaciones genericas
phrase_aprender(Clean, aprender_relacion(A, Rel, B)) :-
    prefijo_aprender(Clean, Resto),
    patron_relacion(Patron, Rel),
    Rel \== es_de,
    Rel \== vive_en,
    sub_atom(Resto, Antes, _, _, Patron),
    sub_atom(Resto, 0, Antes, _, AText),
    atom_length(Patron, Largo),
    Inicio is Antes + Largo,
    sub_atom(Resto, Inicio, _, 0, BText),
    termino_limpio(AText, A),
    termino_limpio(BText, B).

% Clasificacion: solo si NO contiene relaciones mas especificas
phrase_aprender(Clean, aprender_es_un(A, B)) :-
    prefijo_aprender(Clean, Resto),
    \+ sub_atom(Resto, _, _, _, ' es de '),
    \+ sub_atom(Resto, _, _, _, ' vive en '),
    sub_atom(Resto, Antes, _, _, ' es '),
    sub_atom(Resto, 0, Antes, _, AText),
    Inicio is Antes + 4,
    sub_atom(Resto, Inicio, _, 0, BText),
    termino_limpio(AText, A),
    termino_limpio(BText, B).

prefijo_aprender(Clean, Resto) :- atom_concat('aprender que ', Resto, Clean).
prefijo_aprender(Clean, Resto) :- atom_concat('aprende que ', Resto, Clean).

patron_relacion(' tiene album ', tiene_album).
patron_relacion(' tiene álbum ', tiene_album).
patron_relacion(' tiene_album ', tiene_album).
patron_relacion(' tiene cancion ', tiene_cancion).
patron_relacion(' tiene canción ', tiene_cancion).
patron_relacion(' tiene_cancion ', tiene_cancion).
patron_relacion(' sirve para ', sirve_para).
patron_relacion(' requiere ', requiere).
patron_relacion(' permite ', permite).
patron_relacion(' produce ', produce).
patron_relacion(' simula ', simula).
patron_relacion(' puede ', puede).
patron_relacion(' come ', come).
patron_relacion(' tiene ', tiene).

phrase_hermanos(Clean, hermanos(X)) :-
    ( atom_concat('hermanos de ', Resto, Clean)
    ; atom_concat('hermano de ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_ancestros(Clean, ancestros(X)) :-
    ( atom_concat('ancestros de ', Resto, Clean)
    ; atom_concat('categorias de ', Resto, Clean)
    ; atom_concat('categoría de ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_descendientes(Clean, descendientes(X)) :-
    ( atom_concat('descendientes de ', Resto, Clean)
    ; atom_concat('tipos de ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_propiedades(Clean, propiedades(X)) :-
    ( atom_concat('propiedades de ', Resto, Clean)
    ; atom_concat('caracteristicas de ', Resto, Clean)
    ; atom_concat('características de ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_donde_vive(Clean, donde_vive(X)) :-
    ( atom_concat('donde vive ', Resto, Clean)
    ; atom_concat('dónde vive ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_de_donde_es(Clean, de_donde_es(X)) :-
    atom_concat('de donde es ', Resto, Clean),
    termino_limpio(Resto, X).
phrase_de_donde_es(Clean, de_donde_es(X)) :-
    atom_concat('de dónde es ', Resto, Clean),
    termino_limpio(Resto, X).

phrase_que_come(Clean, que_come(X)) :-
    atom_concat('que come ', Resto, Clean),
    termino_limpio(Resto, X).

phrase_que_puede(Clean, que_puede(X)) :-
    ( atom_concat('que puede hacer ', Resto, Clean)
    ; atom_concat('que puede ', Resto, Clean)
    ),
    termino_limpio(Resto, X).

phrase_relaciones_de(Clean, relaciones_de(X)) :-
    atom_concat('relaciones de ', Resto, Clean),
    termino_limpio(Resto, X).

phrase_listar('listar conceptos',  listar_conceptos).
phrase_listar('lista conceptos',   listar_conceptos).
phrase_listar('listar relaciones', listar_relaciones).
phrase_listar('lista relaciones',  listar_relaciones).
phrase_listar('listar sinonimos',  listar_sinonimos).
phrase_listar('lista sinonimos',   listar_sinonimos).

phrase_salir('salir',       salir).
phrase_salir('adios',       salir).
phrase_salir('adiós',       salir).
phrase_salir('hasta luego', salir).
phrase_salir('chao',        salir).
phrase_salir('bye',         salir).

phrase_cortesia('hola',    hola).
phrase_cortesia('buenas',  hola).
phrase_cortesia('gracias', gracias).

% =========================================
% Limpieza de terminos
% =========================================
% Convierte un fragmento de texto en un atomo canonico:
%   - quita puntuacion final,
%   - elimina articulos/cualificadores iniciales,
%   - une las palabras restantes con guion bajo
%     (ej: "el objeto prolog" -> prolog, "bad bunny" -> bad_bunny).

termino_limpio(Texto, Termino) :-
    quitar_puntuacion_final(Texto, Limpio),
    atomic_list_concat(Palabras0, ' ', Limpio),
    exclude(==(''), Palabras0, Palabras1),
    quitar_fillers(Palabras1, Palabras2),
    ( Palabras2 == [] -> Final = Palabras1 ; Final = Palabras2 ),
    Final \== [],
    atomic_list_concat(Final, '_', Termino).

% Articulos y cualificadores que se ignoran al inicio.
filler(el).   filler(la).  filler(los). filler(las).
filler(un).   filler(una). filler(unos). filler(unas).
filler(objeto). filler(concepto). filler(palabra).
filler(termino). filler(término). filler(cosa).

quitar_fillers([P|Resto], Out) :- filler(P), !, quitar_fillers(Resto, Out).
quitar_fillers(Palabras, Palabras).

% Quita ?.,! y signos de apertura al final del fragmento.
quitar_puntuacion_final(A, Out) :-
    atom_chars(A, Chars),
    reverse(Chars, Rev),
    quitar_signos(Rev, Rev2),
    reverse(Rev2, Chars2),
    atom_chars(Out, Chars2).

quitar_signos([C|T], R) :-
    member(C, ['?', '.', ',', '!', '¿', '¡', ' ']), !,
    quitar_signos(T, R).
quitar_signos(L, L).

% Fallback: cualquier texto se vuelve un unico atomo con guiones.
texto_a_termino(Clean, Termino) :-
    termino_limpio(Clean, Termino).