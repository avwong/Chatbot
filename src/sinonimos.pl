% =========================================
% Modulo de Sinonimos
% =========================================
% Resolucion de terminos con sinonimos para
% que el chatbot entienda variaciones de nombres.

% resolver_termino: intenta encontrar el termino
% canonico que tenga conocimiento asociado.
% Primero intenta el termino tal cual, luego busca
% equivalencias via sinonimos.
resolver_termino(T, T) :-
    concepto_total(T, _), !.
resolver_termino(T, R) :-
    equivalente(T, R),
    R \== T,
    concepto_total(R, _), !.
resolver_termino(T, T).

% concepto_con_sinonimo: busca la definicion de un
% termino, resolviendo sinonimos si es necesario.
concepto_con_sinonimo(T, D) :-
    concepto_total(T, D), !.
concepto_con_sinonimo(T, D) :-
    equivalente(T, R),
    R \== T,
    concepto_total(R, D), !.

% es_un_con_sinonimo: verifica la relacion es_un
% resolviendo sinonimos en ambos terminos.
es_un_con_sinonimo(A, B) :-
    resolver_termino(A, RA),
    resolver_termino(B, RB),
    es_un_total(RA, RB).