inicio :-
    write('Chatbot logico iniciado.'), nl,
    write('Escriba una consulta o salir.'), nl,
    bucle.

bucle :-
    write('> '),
    read(Entrada),
    procesar_entrada(Entrada).

procesar_entrada(salir) :-
    write('Hasta luego.'), nl.

procesar_entrada(Entrada) :-
    responder(Entrada), !,
    bucle.

procesar_entrada(Entrada) :-
    aprender_si_no_sabe(Entrada),
    bucle.