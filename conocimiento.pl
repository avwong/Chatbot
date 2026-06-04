
% Predicados base:
%   concepto(Termino, Definicion)
%   es_un(Elemento, Categoria)        - jerarquia
%   relacion(Sujeto, Relacion, Objeto) - relaciones genericas
%   sinonimo(Canonico, Alias)
%   dialogo(Frase, Respuesta)          - respuestas directas

% Declaraciones

:- discontiguous concepto/2.
:- discontiguous es_un/2.
:- discontiguous relacion/3.
:- discontiguous sinonimo/2.

:- dynamic concepto/2.
:- dynamic es_un/2.
:- dynamic relacion/3.
:- dynamic sinonimo/2.
:- dynamic dialogo/2.

:- dynamic aprendido_concepto/2.
:- dynamic aprendido_es_un/2.
:- dynamic aprendido_relacion/3.
:- dynamic aprendido_sinonimo/2.
:- dynamic aprendido_dialogo/2.

% Hechos estaticos

% Conceptos base (ejemplo de lenguajes logicos)

concepto(prolog, 'Lenguaje de programacion logica basado en clausulas de Horn.').
relacion(prolog, sirve_para,
    'resolver problemas complejos mediante hechos y reglas sin definir algoritmos imperativos.').
sinonimo(prolog, programacion_logica).

% Videojuegos y comida

concepto(videojuego, 'software para entretenimiento').
concepto(juego, 'actividad para entretenerse').
concepto(zelda, 'serie de videojuegos hecha por Nintendo').
concepto(mario, 'serie de videojuegos hecha por Nintendo').
concepto(link, 'personaje principal de The Legend of Zelda').
concepto(bowser, 'villano de mario').
concepto(princesa_peach, 'princesa del Reino Champinon en videojuegos de Mario').
concepto(pizza, 'comida italiana, que consiste de masa, tomate, queso y otros agregados').
concepto(arroz, 'grano/lejumbre comestible, tradicional').
concepto(masa, 'mezcla de harina, y agua, entre otros').
concepto(salsa_tomate, 'salsa hecha con tomate').
concepto(queso, 'producto hecho con leche, de sabor salado, y que se derrita/estira(aveces)').
concepto(agua, 'liquido esencial para la vida, y recetas').
concepto(sal, 'elemento, compuesto por NaCI y otros minerales, le da sabor a los alimentos').
concepto(horno, 'aparato de cocina, util para calentar o cocinar').
concepto(harina, 'polvo de distintos cereales, como trigo, se usa para hacer masa').
concepto(hamburguesa, 'comida, consiste de pan, una forma de carne, y agregados como queso, y vegetales').
concepto(carne, 'alimento de base animal').
concepto(vegetales, 'alimentos de base vegetal').
concepto(estrella, 'cuerpo celeste, que tiene combustion y brinda luz').
concepto(electricidad, 'forma de energia').

es_un(zelda, videojuego).
es_un(mario, videojuego).
es_un(link, personaje).
es_un(bowser, personaje).
es_un(princesa_peach, personaje).
es_un(pizza, alimento).
es_un(arroz, ingrediente).
es_un(masa, ingrediente).
es_un(queso, ingrediente).
es_un(agua, ingrediente).
es_un(sal, ingrediente).
es_un(hamburguesa, alimento).
es_un(carne, ingrediente).
es_un(vegetales, ingrediente).
es_un(horno, herramienta).
es_un(electricidad, recurso).

relacion(zelda, tiene, link).
relacion(mario, tiene, princesa_peach).
relacion(mario, tiene, bowser).
relacion(pizza, tiene, masa).
relacion(pizza, tiene, salsa_tomate).
relacion(pizza, tiene, queso).
relacion(pizza, requiere, horno).
relacion(horno, requiere, electricidad).
relacion(hamburguesa, tiene, carne).
relacion(hamburguesa, tiene, vegetales).
relacion(hamburguesa, tiene, queso).
relacion(arroz, requiere, agua).
relacion(arroz, requiere, sal).
relacion(masa, requiere, harina).

sinonimo(requiere, necesita).
sinonimo(mario, super_mario).
sinonimo(videojuego, juego).
sinonimo(princesa_peach, peach).
sinonimo(zelda, legend_of_zelda).

% Videojuegos modernos

concepto(minecraft, 'videojuego de construccion y supervivencia con bloques').
concepto(gta_v, 'videojuego de mundo abierto de la saga grand theft auto').
concepto(gta_san_andreas, 'videojuego de mundo abierto protagonizado por cj').
concepto(fortnite, 'videojuego multijugador de batalla y construccion').
concepto(call_of_duty, 'serie de videojuegos de disparos en primera persona').
concepto(fifa, 'serie de videojuegos de futbol').
concepto(pokemon, 'franquicia de videojuegos de criaturas coleccionables').
concepto(among_us, 'videojuego multijugador de deduccion social').
concepto(roblox, 'plataforma de videojuegos y creacion de experiencias').
concepto(mario_kart, 'serie de carreras con personajes de nintendo').
concepto(creeper, 'enemigo explosivo de minecraft').
concepto(ender_dragon, 'jefe final principal de minecraft').
concepto(steve, 'personaje jugable clasico de minecraft').
concepto(cj, 'personaje principal de gta_san_andreas').
concepto(trevor, 'uno de los protagonistas de gta_v').
concepto(pikachu, 'pokemon electrico muy conocido').
concepto(master_chief, 'protagonista principal de halo').

es_un(minecraft, videojuego).
es_un(gta_v, videojuego).
es_un(gta_san_andreas, videojuego).
es_un(fortnite, videojuego).
es_un(call_of_duty, videojuego).
es_un(fifa, videojuego).
es_un(pokemon, franquicia).
es_un(among_us, videojuego).
es_un(roblox, plataforma).
es_un(mario_kart, videojuego).
es_un(creeper, enemigo).
es_un(ender_dragon, jefe).
es_un(steve, personaje).
es_un(cj, personaje).
es_un(trevor, personaje).
es_un(pikachu, personaje).
es_un(master_chief, personaje).

relacion(minecraft, tiene, creeper).
relacion(minecraft, tiene, ender_dragon).
relacion(minecraft, tiene, steve).
relacion(gta_san_andreas, tiene, cj).
relacion(gta_v, tiene, trevor).
relacion(pokemon, tiene, pikachu).
relacion(halo, tiene, master_chief).
relacion(the_legend_of_zelda, tiene, link).
relacion(fortnite, requiere, internet).
relacion(among_us, requiere, trabajo_en_equipo).
relacion(call_of_duty, requiere, punteria).
relacion(fifa, simula, futbol).
relacion(mario_kart, simula, carreras).
relacion(roblox, permite, crear_juegos).

sinonimo(gta_v, grand_theft_auto_v).
sinonimo(gta_san_andreas, san_andreas).
sinonimo(call_of_duty, cod).
sinonimo(fifa, ea_fc).

% Musica (generos, cantantes, albumes)

% Generos
concepto(pop, 'genero musical popular de ritmos pegajosos y letras accesibles').
concepto(reggaeton, 'genero musical urbano latino de ritmo sincopado originado en Puerto Rico').
concepto(r_and_b, 'genero musical de ritmo y blues de origen afroamericano').
concepto(indie_jazz, 'genero que combina jazz clasico con sensibilidad indie moderna').
concepto(trap_latino, 'subgenero urbano latino derivado del trap estadounidense').
concepto(flamenco_pop, 'fusion de flamenco tradicional espanol con pop moderno').

% Cantantes
concepto(ariana_grande, 'cantante y actriz estadounidense conocida por su voz de soprano y su estilo pop').
concepto(the_weeknd, 'cantante canadiense conocido por su estilo oscuro de r&b y pop').
concepto(taylor_swift, 'cantante y compositora estadounidense icono del pop y country moderno').
concepto(laufey, 'cantante islandesa que mezcla indie con jazz clasico').
concepto(bad_bunny, 'cantante puertorriqueno considerado el mayor exponente del trap latino y reggaeton').
concepto(ozuna, 'cantante puertorriqueno de reggaeton apodado el negrito de ojos claros').
concepto(rauw_alejandro, 'cantante puertorriqueno de reggaeton y pop urbano').
concepto(young_miko, 'cantante puertorriquena de trap latino y rap').
concepto(rosalia, 'cantante espanola que fusiona el flamenco con el pop y el urbano').
concepto(karol_g, 'cantante colombiana de reggaeton y pop latino apodada la bichota').

% Albumes
concepto(thank_u_next, 'sexto album de ariana grande lanzado en 2019').
concepto(positions, 'septimo album de ariana grande lanzado en 2020').
concepto(after_hours, 'cuarto album de the weeknd lanzado en 2020').
concepto(dawn_fm, 'quinto album de the weeknd lanzado en 2022').
concepto(midnights, 'decimo album de taylor swift lanzado en 2022').
concepto(folklore, 'octavo album de taylor swift lanzado en 2020').
concepto(bewitched_album, 'segundo album de laufey lanzado en 2023').
concepto(un_verano_sin_ti, 'album de bad bunny lanzado en 2022, el mas escuchado en spotify ese ano').
concepto(nibiru, 'cuarto album de ozuna lanzado en 2019').
concepto(vice_versa, 'segundo album de rauw alejandro lanzado en 2021').
concepto(att, 'album debut de young miko lanzado en 2023').
concepto(motomami, 'tercer album de rosalia lanzado en 2022, ganador del grammy').
concepto(manana_sera_bonito_album, 'tercer album de karol g lanzado en 2023').

es_un(cantante, artista).
es_un(artista_pop, cantante).
es_un(artista_urbano, cantante).
es_un(artista_indie, cantante).
es_un(ariana_grande, artista_pop).
es_un(the_weeknd, artista_pop).
es_un(taylor_swift, artista_pop).
es_un(laufey, artista_indie).
es_un(bad_bunny, artista_urbano).
es_un(ozuna, artista_urbano).
es_un(rauw_alejandro, artista_urbano).
es_un(young_miko, artista_urbano).
es_un(rosalia, artista_pop).
es_un(karol_g, artista_urbano).

% Paises de origen
relacion(ariana_grande, es_de, estados_unidos).
relacion(the_weeknd, es_de, canada).
relacion(taylor_swift, es_de, estados_unidos).
relacion(laufey, es_de, islandia).
relacion(bad_bunny, es_de, puerto_rico).
relacion(ozuna, es_de, puerto_rico).
relacion(rauw_alejandro, es_de, puerto_rico).
relacion(young_miko, es_de, puerto_rico).
relacion(rosalia, es_de, espana).
relacion(karol_g, es_de, colombia).

% Genero que interpreta cada cantante
relacion(ariana_grande, canta, pop).
relacion(the_weeknd, canta, r_and_b).
relacion(the_weeknd, canta, pop).
relacion(taylor_swift, canta, pop).
relacion(laufey, canta, indie_jazz).
relacion(bad_bunny, canta, reggaeton).
relacion(bad_bunny, canta, trap_latino).
relacion(ozuna, canta, reggaeton).
relacion(rauw_alejandro, canta, reggaeton).
relacion(young_miko, canta, trap_latino).
relacion(rosalia, canta, flamenco_pop).
relacion(karol_g, canta, reggaeton).

% Albumes
relacion(ariana_grande, tiene_album, thank_u_next).
relacion(the_weeknd, tiene_album, after_hours).
relacion(taylor_swift, tiene_album, midnights).
relacion(laufey, tiene_album, bewitched_album).
relacion(bad_bunny, tiene_album, un_verano_sin_ti).
relacion(ozuna, tiene_album, nibiru).
relacion(rauw_alejandro, tiene_album, vice_versa).
relacion(young_miko, tiene_album, att).
relacion(rosalia, tiene_album, motomami).
relacion(karol_g, tiene_album, manana_sera_bonito_album).

% Canciones famosas
relacion(ariana_grande, tiene_cancion, thank_u_next).
relacion(ariana_grande, tiene_cancion, positions).
relacion(ariana_grande, tiene_cancion, seven_rings).
relacion(the_weeknd, tiene_cancion, blinding_lights).
relacion(the_weeknd, tiene_cancion, starboy).
relacion(the_weeknd, tiene_cancion, save_your_tears).
relacion(taylor_swift, tiene_cancion, shake_it_off).
relacion(taylor_swift, tiene_cancion, blank_space).
relacion(laufey, tiene_cancion, from_the_start).
relacion(bad_bunny, tiene_cancion, titi_me_pregunto).
relacion(bad_bunny, tiene_cancion, yonaguni).
relacion(ozuna, tiene_cancion, taki_taki).
relacion(ozuna, tiene_cancion, baila_baila_baila).
relacion(rauw_alejandro, tiene_cancion, todo_de_ti).
relacion(young_miko, tiene_cancion, brb).
relacion(rosalia, tiene_cancion, despecha).
relacion(rosalia, tiene_cancion, con_altura).
relacion(karol_g, tiene_cancion, tusa).
relacion(karol_g, tiene_cancion, provenza).

sinonimo(the_weeknd, abel).
sinonimo(bad_bunny, benito).
sinonimo(bad_bunny, benito_antonio_martinez).
sinonimo(ozuna, juanpa).
sinonimo(rauw_alejandro, raul_alejandro).
sinonimo(young_miko, miko).
sinonimo(rosalia, rosa).
sinonimo(karol_g, la_bichota).
sinonimo(taylor_swift, taylor).
sinonimo(laufey, laufey_lin).
sinonimo(ariana_grande, ari).

% Animales

% Categorias generales
concepto(animal, 'ser vivo que se desplaza y se alimenta de sustancias organicas').
concepto(mamifero, 'animal vertebrado de sangre caliente que amamanta a sus crias').
concepto(ave, 'animal vertebrado con plumas y alas').
concepto(reptil, 'animal vertebrado de sangre fria con escamas').
concepto(anfibio, 'animal vertebrado que vive en agua y tierra').
concepto(pez, 'animal vertebrado acuatico que respira por branquias').
concepto(insecto, 'animal invertebrado con seis patas y exoesqueleto').
concepto(aracnido, 'animal invertebrado con ocho patas').

% Subcategorias
concepto(felino, 'mamifero carnivoro agil con garras retractiles').
concepto(canido, 'mamifero carnivoro de la familia de los perros y lobos').

% Mamiferos
concepto(perro, 'mamifero domestico considerado el mejor amigo del hombre').
concepto(gato, 'mamifero domestico felino pequeno y agil').
concepto(leon, 'gran felino conocido como el rey de la selva').
concepto(tigre, 'el mas grande de los felinos, con rayas naranjas y negras').
concepto(elefante, 'el mamifero terrestre mas grande del mundo, con trompa').
concepto(delfin, 'mamifero marino muy inteligente y sociable').
concepto(ballena, 'el animal mas grande del planeta, mamifero marino').
concepto(caballo, 'mamifero grande domesticado para montar y transporte').
concepto(vaca, 'mamifero domestico rumiante que produce leche').
concepto(lobo, 'mamifero canido salvaje que vive en manadas').
concepto(oso, 'mamifero grande omnivoro de gran fuerza').
concepto(jirafa, 'mamifero africano con el cuello mas largo del mundo').
concepto(murcielago, 'unico mamifero capaz de volar').

% Aves
concepto(aguila, 'ave rapaz de gran tamano y excelente vision').
concepto(loro, 'ave tropical capaz de imitar sonidos humanos').
concepto(pinguino, 'ave que no puede volar adaptada a climas frios').
concepto(colibri, 'ave muy pequena que puede volar hacia atras').

% Reptiles
concepto(cocodrilo, 'reptil grande y depredador que vive cerca del agua').
concepto(serpiente, 'reptil sin patas que se desplaza reptando').
concepto(tortuga, 'reptil con caparazon protector, longeva').

% Anfibios
concepto(rana, 'anfibio pequeno que puede saltar grandes distancias').
concepto(salamandra, 'anfibio con cola que puede regenerar partes de su cuerpo').

% Peces
concepto(tiburon, 'pez cartilaginoso depredador de los oceanos').
concepto(salmon, 'pez que migra del mar a los rios para reproducirse').
concepto(pez_payaso, 'pez pequeno anaranjado que vive entre anemonas').

% Insectos
concepto(abeja, 'insecto polinizador que produce miel').
concepto(mariposa, 'insecto con alas coloridas que pasa por metamorfosis').
concepto(hormiga, 'insecto social que vive en colonias organizadas').

% Aracnidos
concepto(arana, 'aracnido que teje telaranas para atrapar presas').

% Jerarquia
es_un(mamifero, animal).
es_un(ave, animal).
es_un(reptil, animal).
es_un(anfibio, animal).
es_un(pez, animal).
es_un(insecto, animal).
es_un(aracnido, animal).
es_un(felino, mamifero).
es_un(canido, mamifero).
es_un(leon, felino).
es_un(tigre, felino).
es_un(gato, felino).
es_un(perro, canido).
es_un(lobo, canido).
es_un(elefante, mamifero).
es_un(delfin, mamifero).
es_un(ballena, mamifero).
es_un(caballo, mamifero).
es_un(vaca, mamifero).
es_un(oso, mamifero).
es_un(jirafa, mamifero).
es_un(murcielago, mamifero).
es_un(aguila, ave).
es_un(loro, ave).
es_un(pinguino, ave).
es_un(colibri, ave).
es_un(cocodrilo, reptil).
es_un(serpiente, reptil).
es_un(tortuga, reptil).
es_un(rana, anfibio).
es_un(salamandra, anfibio).
es_un(tiburon, pez).
es_un(salmon, pez).
es_un(pez_payaso, pez).
es_un(abeja, insecto).
es_un(mariposa, insecto).
es_un(hormiga, insecto).
es_un(arana, aracnido).

% Propiedades (tiene) -- heredables por jerarquia
relacion(animal, tiene, vida).
relacion(mamifero, tiene, pelo).
relacion(mamifero, tiene, sangre_caliente).
relacion(ave, tiene, plumas).
relacion(ave, tiene, pico).
relacion(reptil, tiene, escamas).
relacion(reptil, tiene, sangre_fria).
relacion(pez, tiene, branquias).
relacion(pez, tiene, aletas).
relacion(insecto, tiene, seis_patas).
relacion(insecto, tiene, exoesqueleto).
relacion(aracnido, tiene, ocho_patas).
relacion(elefante, tiene, trompa).
relacion(elefante, tiene, colmillos).
relacion(jirafa, tiene, cuello_largo).
relacion(tortuga, tiene, caparazon).
relacion(leon, tiene, melena).
relacion(colibri, tiene, pico_largo).

% Habitat (vive_en)
relacion(delfin, vive_en, oceano).
relacion(ballena, vive_en, oceano).
relacion(tiburon, vive_en, oceano).
relacion(pez_payaso, vive_en, arrecife).
relacion(salmon, vive_en, rio).
relacion(aguila, vive_en, montanas).
relacion(pinguino, vive_en, antartida).
relacion(leon, vive_en, sabana).
relacion(tigre, vive_en, selva).
relacion(oso, vive_en, bosque).
relacion(jirafa, vive_en, sabana).
relacion(cocodrilo, vive_en, pantano).
relacion(rana, vive_en, estanque).
relacion(lobo, vive_en, bosque).
relacion(hormiga, vive_en, hormiguero).

% Alimentacion (come)
relacion(leon, come, carne).
relacion(tigre, come, carne).
relacion(lobo, come, carne).
relacion(aguila, come, peces).
relacion(tiburon, come, peces).
relacion(rana, come, insectos).
relacion(vaca, come, pasto).
relacion(caballo, come, pasto).
relacion(jirafa, come, hojas).
relacion(oso, come, bayas).
relacion(oso, come, peces).
relacion(abeja, come, nectar).
relacion(cocodrilo, come, carne).
relacion(serpiente, come, roedores).
relacion(delfin, come, peces).

% Habilidades (puede)
relacion(delfin, puede, nadar).
relacion(aguila, puede, volar).
relacion(pinguino, puede, nadar).
relacion(murcielago, puede, volar).
relacion(rana, puede, saltar).
relacion(serpiente, puede, reptar).
relacion(colibri, puede, volar).
relacion(caballo, puede, galopar).
relacion(tortuga, puede, nadar).
relacion(tiburon, puede, nadar).
relacion(loro, puede, hablar).
relacion(gato, puede, trepar).
relacion(arana, puede, tejer).

% Produccion (produce)
relacion(abeja, produce, miel).
relacion(vaca, produce, leche).
relacion(gallina, produce, huevos).

% Otras relaciones
relacion(perro, es_amigo_de, humano).
relacion(gato, es_compania_de, humano).

sinonimo(perro, can).
sinonimo(gato, minino).
sinonimo(serpiente, vibora).
sinonimo(loro, perico).
sinonimo(tiburon, escualo).
sinonimo(murcielago, quiroptero).


% Capa total: estatico + aprendido

concepto_total(X, D) :- concepto(X, D).
concepto_total(X, D) :- aprendido_concepto(X, D).

es_un_total(X, Y) :- es_un(X, Y).
es_un_total(X, Y) :- aprendido_es_un(X, Y).
es_un_total(X, Y) :-
    ( es_un(X, Z) ; aprendido_es_un(X, Z) ),
    Z \== X,
    es_un_total(Z, Y).

relacion_total(X, R, Y) :- relacion(X, R, Y).
relacion_total(X, R, Y) :- aprendido_relacion(X, R, Y).

sinonimo_total(X, Y) :- sinonimo(X, Y).
sinonimo_total(X, Y) :- aprendido_sinonimo(X, Y).

dialogo_total(I, R) :- dialogo(I, R).
dialogo_total(I, R) :- aprendido_dialogo(I, R).


% Resolucion de sinonimos

% equivalente/2: cadena de sinonimos (bidireccional y transitiva).
equivalente(X, X).
equivalente(X, Y) :- sinonimo_total(X, Y).
equivalente(X, Y) :- sinonimo_total(Y, X).
equivalente(X, Y) :-
    sinonimo_total(X, Z),
    Z \== X,
    equivalente(Z, Y).

% resolver_termino/2: encuentra el termino canonico con conocimiento.
resolver_termino(T, T) :-
    concepto_total(T, _), !.
resolver_termino(T, R) :-
    equivalente(T, R),
    R \== T,
    concepto_total(R, _), !.
resolver_termino(T, T).

% concepto_con_sinonimo/2: definicion del termino o de su equivalente.
concepto_con_sinonimo(T, D) :-
    concepto_total(T, D), !.
concepto_con_sinonimo(T, D) :-
    equivalente(T, R),
    R \== T,
    concepto_total(R, D), !.

% es_un_con_sinonimo/2: relacion es_un resolviendo sinonimos en ambos lados.
es_un_con_sinonimo(A, B) :-
    resolver_termino(A, RA),
    resolver_termino(B, RB),
    es_un_total(RA, RB).


% Conocimiento de un termino

termino_conocido(T) :- dialogo_total(T, _), !.
termino_conocido(T) :- concepto_total(T, _), !.
termino_conocido(T) :- es_un_total(T, _), !.
termino_conocido(T) :- es_un_total(_, T), !.
termino_conocido(T) :- relacion_total(T, _, _), !.
termino_conocido(T) :- relacion_total(_, _, T), !.
termino_conocido(T) :- sinonimo_total(T, _), !.
termino_conocido(T) :- sinonimo_total(_, T), !.

% Persistencia
% Cada vez que se aprende algo, se reescribe el archivo


ruta_aprendido('data/aprendido.pl').
ruta_sinonimos('data/sinonimos_dinamicos.pl').

guardar_aprendido :-
    ruta_aprendido(Ruta),
    setup_call_cleanup(
        tell(Ruta),
        ( listing(aprendido_concepto/2),
          listing(aprendido_es_un/2),
          listing(aprendido_relacion/3),
          listing(aprendido_dialogo/2)
        ),
        told).

guardar_sinonimos :-
    ruta_sinonimos(Ruta),
    setup_call_cleanup(
        tell(Ruta),
        listing(aprendido_sinonimo/2),
        told).

guardar_todo :-
    guardar_aprendido,
    guardar_sinonimos.
