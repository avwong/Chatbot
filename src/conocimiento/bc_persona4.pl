% =========================================
% Base de Conocimiento - Persona 4
% Tema: Animales
% =========================================

% ---------------------------------
% Conceptos (definiciones)
% ---------------------------------

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

% ---------------------------------
% Jerarquias (es_un)
% ---------------------------------

% Categorias principales son animales
es_un(mamifero, animal).
es_un(ave, animal).
es_un(reptil, animal).
es_un(anfibio, animal).
es_un(pez, animal).
es_un(insecto, animal).
es_un(aracnido, animal).

% Subcategorias
es_un(felino, mamifero).
es_un(canido, mamifero).

% Mamiferos especificos
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

% Aves especificas
es_un(aguila, ave).
es_un(loro, ave).
es_un(pinguino, ave).
es_un(colibri, ave).

% Reptiles especificos
es_un(cocodrilo, reptil).
es_un(serpiente, reptil).
es_un(tortuga, reptil).

% Anfibios especificos
es_un(rana, anfibio).
es_un(salamandra, anfibio).

% Peces especificos
es_un(tiburon, pez).
es_un(salmon, pez).
es_un(pez_payaso, pez).

% Insectos especificos
es_un(abeja, insecto).
es_un(mariposa, insecto).
es_un(hormiga, insecto).

% Aracnidos especificos
es_un(arana, aracnido).

% ---------------------------------
% Relaciones: propiedades (tiene)
% ---------------------------------

% Propiedades heredables por categoria
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

% Propiedades individuales
relacion(elefante, tiene, trompa).
relacion(elefante, tiene, colmillos).
relacion(jirafa, tiene, cuello_largo).
relacion(tortuga, tiene, caparazon).
relacion(leon, tiene, melena).
relacion(colibri, tiene, pico_largo).

% ---------------------------------
% Relaciones: habitat (vive_en)
% ---------------------------------

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

% ---------------------------------
% Relaciones: alimentacion (come)
% ---------------------------------

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

% ---------------------------------
% Relaciones: habilidades (puede)
% ---------------------------------

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

% ---------------------------------
% Relaciones: produccion (produce)
% ---------------------------------

relacion(abeja, produce, miel).
relacion(vaca, produce, leche).
relacion(gallina, produce, huevos).

% ---------------------------------
% Relaciones: otros
% ---------------------------------

relacion(perro, es_amigo_de, humano).
relacion(gato, es_compania_de, humano).

% ---------------------------------
% Sinonimos
% ---------------------------------

sinonimo(perro, can).
sinonimo(gato, minino).
sinonimo(serpiente, vibora).
sinonimo(loro, perico).
sinonimo(tiburon, escualo).
sinonimo(murcielago, quiroptero).
