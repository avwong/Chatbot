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

sinonimo(requiere, necesita)
sinonimo(mario, super_mario).
sinonimo(videojuego, juego).
sinonimo(princesa_peach, peach).
sinonimo(zelda, legend_of_zelda).