% Ejecutar desde proyecto:
%   swipl main.pl

% Arquitectura:
%   conocimiento.pl -> hechos + capa total + persistencia
%   inferencia.pl   -> razonamiento + responder/1
%   nlp.pl          -> texto del usuario -> termino Prolog
%   main.pl         -> bucle, entrada/salida y aprendizaje guiado

:- set_prolog_flag(encoding, utf8).

:- ['conocimiento.pl'].
:- ['inferencia.pl'].
:- ['nlp.pl'].

% Conocimiento aprendido en sesiones previas (si existe).
:- ( exists_file('data/aprendido.pl')           -> ['data/aprendido.pl']           ; true ).
:- ( exists_file('data/sinonimos_dinamicos.pl') -> ['data/sinonimos_dinamicos.pl'] ; true ).


bot(Texto) :-
    write('Chatbot> '), write(Texto), nl.

inicio :-
    nl,
    writeln('      Bienvenido al Chatbot '),
    writeln('        Made with Prolog '),
    writeln('       con esperanza y fe '),
    writeln(' [Escriba "salir" para finalizar]'),
    nl,
    bucle.

bucle :-
    nl,
    write('Usuario> '),
    read_line_to_string(user_input, Linea),
    ( Linea == end_of_file ->
        despedida
    ; normalize_space(string(Norm), Linea),
      ( Norm == "" ->
          bucle
      ; procesar(Norm)
      )
    ).

procesar(Norm) :-
    ( parse_entrada(Norm, Entrada) ->
        ejecutar(Entrada)
    ; bot('No pude entender la entrada.'),
      bucle
    ).

ejecutar(salir) :- !, despedida.
ejecutar(Entrada) :-
    ( responder(Entrada) ->
        true
    ; aprender_si_no_sabe(Entrada)
    ),
    bucle.

despedida :-
    bot('¡Hasta luego! Un placer conversar con usted.').

% Aprendizaje guiado
% Cuando responder/1 falla, el chatbot pide al usuario que le ensene. 
% Distingue dos tipos de conocimiento y los guarda por separado:

%   - respuesta : que contestar cuando le digan la frase
%                 (aprendido_dialogo). Ej: "como estas"
%                 -> "Bien y usted?".
%   - definicion: el significado del termino
%                 (aprendido_concepto), consultable con
%                 "que es / defina X". Ej: "como estas"
%                 -> "Una manera de preguntar el bienestar".

aprender_si_no_sabe(que_es(T))         :- !, aprender_guiado(T).
aprender_si_no_sabe(defina(T))         :- !, aprender_guiado(T).
aprender_si_no_sabe(explique(T))       :- !, aprender_guiado(T).
aprender_si_no_sabe(para_que_sirve(T)) :- !, aprender_guiado(T).
aprender_si_no_sabe(tiene(T, _))       :- !, aprender_guiado(T).
aprender_si_no_sabe(es_un(T, _))       :- !, aprender_guiado(T).
aprender_si_no_sabe(de_donde_es(T))    :- !, aprender_guiado(T).
aprender_si_no_sabe(T) :- atom(T), !, aprender_guiado(T).
aprender_si_no_sabe(_) :-
    bot('No pude entender eso. Escriba una palabra para consultarla.').

aprender_guiado(Termino) :-
    bot('No poseo conocimiento suficiente sobre eso. Permítame aprender.'),
    preguntar('¿Cómo debo responder cuando me digan', Termino, Respuesta),
    preguntar('¿Cuál es la definición de', Termino, Definicion),
    guardar_ensenanza(Termino, Respuesta, Definicion).

% Imprime un prompt y lee la respuesta del usuario en la misma linea.
preguntar(Pregunta, Termino, Texto) :-
    format('Chatbot> ~w "~w"? (Enter para omitir): ', [Pregunta, Termino]),
    flush_output,
    leer_linea(Texto).

canonizar_termino_main(TerminoIn, TerminoOut) :-
    atom_string(TerminoIn, Texto),
    split_string(Texto, " ", " \t\n\r.,;:!?¡¿", Partes0),
    exclude(=(""), Partes0, Partes),
    atomic_list_concat(Partes, '_', Atom0),
    downcase_atom(Atom0, Lower),
    normalizar_ascii_main(Lower, TerminoOut).

normalizar_ascii_main(Atom, Out) :-
    atom_chars(Atom, Chars),
    maplist(reemplazar_caracter_main, Chars, Nuevos),
    atom_chars(Out, Nuevos).

reemplazar_caracter_main('á', 'a').
reemplazar_caracter_main('é', 'e').
reemplazar_caracter_main('í', 'i').
reemplazar_caracter_main('ó', 'o').
reemplazar_caracter_main('ú', 'u').
reemplazar_caracter_main('Á', 'a').
reemplazar_caracter_main('É', 'e').
reemplazar_caracter_main('Í', 'i').
reemplazar_caracter_main('Ó', 'o').
reemplazar_caracter_main('Ú', 'u').
reemplazar_caracter_main('ñ', 'n').
reemplazar_caracter_main('Ñ', 'n').
reemplazar_caracter_main(C, C).

% Almacena lo aprendido segun lo que el usuario haya proporcionado.
guardar_ensenanza(_, "", "") :- !,
    bot('No aprendí nada nuevo esta vez.').
guardar_ensenanza(Termino, Respuesta, Definicion) :-
    canonizar_termino_main(Termino, TerminoCanonico),
    aprender_respuesta(TerminoCanonico, Respuesta),
    aprender_definicion(TerminoCanonico, Definicion),
    guardar_aprendido,
    bot('¡Entendido! He aprendido algo nuevo.').

aprender_respuesta(_, "") :- !.
aprender_respuesta(Termino, Respuesta) :-
    atom_string(RAtom, Respuesta),
    assertz(aprendido_dialogo(Termino, RAtom)).

aprender_definicion(_, "") :- !.
aprender_definicion(Termino, Definicion) :-
    atom_string(DAtom, Definicion),
    assertz(aprendido_concepto(Termino, DAtom)).

% Lee una linea y la normaliza; end_of_file se trata como vacio.
leer_linea(Texto) :-
    read_line_to_string(user_input, Raw),
    ( Raw == end_of_file ->
        Texto = ""
    ; normalize_space(string(Texto), Raw)
    ).



:- initialization(inicio, main).
