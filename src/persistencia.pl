guardar_aprendido :-
    tell('data/aprendido.pl'),
    listing(aprendido_concepto/2),
    listing(aprendido_es_un/2),
    listing(aprendido_relacion/3),
    told.

guardar_sinonimos :-
    tell('data/sinonimos_dinamicos.pl'),
    listing(aprendido_sinonimo/2),
    told.