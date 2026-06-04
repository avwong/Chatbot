% util.pl - Funciones utilitarias compartidas
% Centraliza la normalizacion, canonizacion y lectura de entradas.

% --- Normalizacion ASCII ---
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

% --- Canonizacion de terminos ---
% Convierte texto libre en un atomo canonico (ej: "Bad Bunny!" -> bad_bunny)
canonizar_termino(Texto0, Termino) :-
    ( atom(Texto0) ->
        atom_string(Texto0, Texto)
    ; string(Texto0) ->
        Texto = Texto0
    ; term_string(Texto0, Texto)
    ),
    split_string(Texto, " ", " \t\n\r.,;:!?¡¿", Partes0),
    exclude(=(""), Partes0, Partes),
    % Limpiar puntuacion residual dentro de los tokens
    maplist(limpiar_partes, Partes, PartesLimpias),
    exclude(=(""), PartesLimpias, PartesFinales),
    atomic_list_concat(PartesFinales, '_', Atom0),
    downcase_atom(Atom0, Lower),
    normalizar_ascii(Lower, Termino).

limpiar_partes(StringIn, StringOut) :-
    string_chars(StringIn, CharsIn),
    exclude(es_puntuacion, CharsIn, CharsOut),
    string_chars(StringOut, CharsOut).

es_puntuacion(C) :- member(C, ['.', ',', ';', ':', '!', '?', '¡', '¿']).

% --- Lectura de linea estandarizada ---
leer_linea(Texto) :-
    read_line_to_string(user_input, Raw),
    ( Raw == end_of_file ->
        Texto = ""
    ; normalize_space(string(Texto), Raw)
    ).
