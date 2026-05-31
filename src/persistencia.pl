% ---------------------------------
% Rutas de archivos dinamicos
% ---------------------------------

ruta_aprendido('data/aprendido.pl').
ruta_sinonimos('data/sinonimos_dinamicos.pl').

% ---------------------------------
% Guardado de conocimiento aprendido
% ---------------------------------

guardar_aprendido :-
    ruta_aprendido(Ruta),
    tell(Ruta),
    listing(aprendido_concepto/2),
    listing(aprendido_es_un/2),
    listing(aprendido_relacion/3),
    told.

guardar_sinonimos :-
    ruta_sinonimos(Ruta),
    tell(Ruta),
    listing(aprendido_sinonimo/2),
    told.

guardar_todo :-
    guardar_aprendido,
    guardar_sinonimos.