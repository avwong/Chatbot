inicio :-
    write('Chatbot logico iniciado.'), nl,
    write('Escriba una consulta o salir.'), nl,
    bucle.

bucle :-
    write('> '),
    read_line_to_string(user_input, Line),
    normalize_space(string(Norm), Line),
    ( Norm == "" ->
        bucle
    ; parse_entrada(Norm, Entrada) ->
        procesar_entrada(Entrada)
    ; write('No pude entender la entrada.'), nl,
      bucle
    ).

parse_entrada(Line, Term) :-
    catch(term_string(Term, Line), _, fail), !.
parse_entrada(Line, Term) :-
    normalize_space(atom(Atom), Line),
    \+ sub_atom(Atom, _, 1, _, ' '),
    atom_string(Term, Atom), !.
parse_entrada(Line, Term) :-
    normalizar_frase(Line, Term), !.

procesar_entrada(salir) :-
    write('Hasta luego.'), nl.

procesar_entrada(Entrada) :-
    responder(Entrada), !,
    bucle.

procesar_entrada(Entrada) :-
    aprender_si_no_sabe(Entrada),
    bucle.

normalizar_frase(Line, Term) :-
    string_lower(Line, Lower),
    normalize_space(string(Clean0), Lower),
    remove_punctuation(Clean0, CleanString),
    atom_string(Clean, CleanString),
    ( phrase_que_es(Clean, Term)
    ; phrase_defina(Clean, Term)
    ; phrase_explique(Clean, Term)
    ; phrase_para_que_sirve(Clean, Term)
    ; phrase_hermanos(Clean, Term)
    ; phrase_ancestros(Clean, Term)
    ; phrase_descendientes(Clean, Term)
    ; phrase_propiedades(Clean, Term)
    ; phrase_donde_vive(Clean, Term)
    ; phrase_que_come(Clean, Term)
    ; phrase_que_puede(Clean, Term)
    ; phrase_relaciones_de(Clean, Term)
    ; phrase_aprender(Clean, Term)
    ; phrase_listar(Clean, Term)
    ; phrase_salir(Clean, Term)
    ).

remove_punctuation(Line, Clean) :-
    string_chars(Line, Chars),
    strip_punct_start(Chars, Mid),
    strip_punct_end(Mid, CleanChars),
    string_chars(Clean, CleanChars).

strip_punct_start(['¿'|T], R) :- strip_punct_start(T, R).
strip_punct_start(['¡'|T], R) :- strip_punct_start(T, R).
strip_punct_start([C|T], [C|T]) :- \+ member(C, ['¿','¡']).

strip_punct_end(Chars, Result) :-
    reverse(Chars, Rev),
    strip_punct_start(Rev, RevStripped),
    reverse(RevStripped, Result).

phrase_que_es(Clean, que_es(X)) :-
    ( atom_concat('que es ', Rest, Clean)
    ; atom_concat('qué es ', Rest, Clean)
    ),
    texto_a_atom(Rest, X).

phrase_defina(Clean, defina(X)) :-
    atom_concat('defina ', Rest, Clean),
    texto_a_atom(Rest, X).

phrase_explique(Clean, explique(X)) :-
    atom_concat('explique ', Rest, Clean),
    texto_a_atom(Rest, X).

phrase_para_que_sirve(Clean, para_que_sirve(X)) :-
    ( atom_concat('para que sirve ', Rest, Clean)
    ; atom_concat('para qué sirve ', Rest, Clean)
    ),
    texto_a_atom(Rest, X).

phrase_aprender(Clean, aprender_es_un(A, B)) :-
    ( atom_concat('aprender que ', Rest, Clean)
    ; atom_concat('aprende que ', Rest, Clean)
    ),
    sub_atom(Rest, Before, _, _After, ' es '),
    sub_atom(Rest, 0, Before, _, AText),
    Start is Before + 4,
    sub_atom(Rest, Start, _, 0, BText),
    quitar_articulo(AText, A1),
    quitar_articulo(BText, B1),
    texto_a_atom(A1, A),
    texto_a_atom(B1, B).

phrase_aprender(Clean, aprender_sinonimo(A, B)) :-
    ( atom_concat('aprender que ', Rest, Clean)
    ; atom_concat('aprende que ', Rest, Clean)
    ),
    sub_atom(Rest, Before, _, _After, ' significa '),
    sub_atom(Rest, 0, Before, _, AText),
    Start is Before + 10,
    sub_atom(Rest, Start, _, 0, BText),
    quitar_articulo(AText, A1),
    quitar_articulo(BText, B1),
    texto_a_atom(A1, A),
    texto_a_atom(B1, B).

phrase_listar('listar conceptos', listar_conceptos).
phrase_listar('listar_conceptos', listar_conceptos).
phrase_listar('lista conceptos', listar_conceptos).
phrase_listar('listar definiciones', listar_definiciones).
phrase_listar('listar_definiciones', listar_definiciones).
phrase_listar('listar relaciones', listar_relaciones).
phrase_listar('listar_relaciones', listar_relaciones).
phrase_listar('listar sinonimos', listar_sinonimos).
phrase_listar('listar_sinonimos', listar_sinonimos).

phrase_salir('salir', salir).
phrase_salir('adios', salir).
phrase_salir('hasta luego', salir).
phrase_salir('chao', salir).

texto_a_atom(Text, Atom) :-
    normalize_space(string(Clean), Text),
    remove_trailing_punctuation(Clean, Clean2),
    atom_string(Atom, Clean2).

quitar_articulo(Text, Result) :-
    normalize_space(string(Clean), Text),
    split_string(Clean, " ", " ", Words),
    ( Words = [First|Rest], member(First, ["el","la","los","las","un","una"]) ->
        atomics_to_text(Rest, ' ', Clean1)
    ; atomics_to_text(Words, ' ', Clean1)
    ),
    normalize_space(string(Result), Clean1).

atomics_to_text([], _, "").
atomics_to_text([X], _, X).
atomics_to_text([X|Xs], Sep, Result) :-
    atomics_to_text(Xs, Sep, Rest),
    string_concat(X, Sep, Temp),
    string_concat(Temp, Rest, Result).

remove_trailing_punctuation(Input, Output) :-
    ( sub_string(Input, 0, _, 1, P), member(P, ['?','.',',','!']) ->
        sub_string(Input, 0, _, 1, Trimmed),
        remove_trailing_punctuation(Trimmed, Output)
    ; Output = Input
    ).

% ---------------------------------
% Frases para inferencias logicas
% ---------------------------------

phrase_hermanos(Clean, hermanos(X)) :-
    ( atom_concat('hermanos de ', Rest, Clean)
    ; atom_concat('hermano de ', Rest, Clean)
    ),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).

phrase_ancestros(Clean, ancestros(X)) :-
    ( atom_concat('ancestros de ', Rest, Clean)
    ; atom_concat('categorias de ', Rest, Clean)
    ),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).

phrase_descendientes(Clean, descendientes(X)) :-
    ( atom_concat('descendientes de ', Rest, Clean)
    ; atom_concat('tipos de ', Rest, Clean)
    ),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).

phrase_propiedades(Clean, propiedades(X)) :-
    ( atom_concat('propiedades de ', Rest, Clean)
    ; atom_concat('caracteristicas de ', Rest, Clean)
    ),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).

phrase_donde_vive(Clean, donde_vive(X)) :-
    ( atom_concat('donde vive ', Rest, Clean)
    ; atom_concat('donde vive el ', Rest, Clean)
    ; atom_concat('donde vive la ', Rest, Clean)
    ),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).

phrase_que_come(Clean, que_come(X)) :-
    ( atom_concat('que come ', Rest, Clean)
    ; atom_concat('que come el ', Rest, Clean)
    ; atom_concat('que come la ', Rest, Clean)
    ),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).

phrase_que_puede(Clean, que_puede(X)) :-
    ( atom_concat('que puede ', Rest, Clean)
    ; atom_concat('que puede hacer ', Rest, Clean)
    ),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).

phrase_relaciones_de(Clean, relaciones_de(X)) :-
    atom_concat('relaciones de ', Rest, Clean),
    quitar_articulo(Rest, Rest2),
    texto_a_atom(Rest2, X).
