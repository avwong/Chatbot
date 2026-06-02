% Musica

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


% paises

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

% cantante con genero

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

% cantante con albumes

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

% canciones famosas

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

% Sinonimos

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