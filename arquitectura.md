# Arquitectura

El proyecto se organiza en cuatro archivos Prolog. `main.pl` carga el
resto en orden y arranca el bucle automáticamente:

```
conocimiento.pl  →  inferencia.pl  →  nlp.pl  →  main.pl
```

## Punto de entrada (`main.pl`)

No hay `while` ni `for`: el "ciclo" es recursión pura.

```
inicio
  └─ bucle ◄───────────────────────┐
       ├─ lee una línea             │
       ├─ parse_entrada (nlp.pl)    │
       ├─ ejecutar                  │
       │    ├─ salir → despedida    │
       │    ├─ responder(Entrada)   │
       │    └─ aprender_si_no_sabe  │
       └────────────────────────────┘
```

Toda salida se imprime con el prefijo `Chatbot> ` mediante `bot/1`.

## Pipeline de una entrada

```
Texto crudo → [parse_entrada] → Término Prolog → [responder] → Salida
                                               ↓ falla
                                        [aprender_si_no_sabe]
```

### Etapa 1 — `nlp.pl`: texto → término

`parse_entrada/2` intenta, en orden:

1. Leer la línea como un término Prolog válido (`term_string`).
2. Interpretarla como una frase en español (`normalizar_frase`), probando
   cada patrón hasta que uno coincide.

| Frase del usuario              | Término generado          |
|--------------------------------|---------------------------|
| que es X / defina X / explique X | `que_es(X)` / `defina(X)` / `explique(X)` |
| para que sirve X               | `para_que_sirve(X)`       |
| X tiene Y                      | `tiene(X, Y)`             |
| aprender que X es Y            | `aprender_es_un(X, Y)`    |
| aprender que X significa Y     | `aprender_sinonimo(X, Y)` |
| hermanos / ancestros / tipos de X | `hermanos(X)` / `ancestros(X)` / `descendientes(X)` |
| donde vive X / que come X / que puede X | `donde_vive(X)` / `que_come(X)` / `que_puede(X)` |
| listar conceptos / relaciones / sinonimos | `listar_*` |
| salir / adios / chao           | `salir`                   |
| cualquier otra cosa            | átomo (ej. `bad_bunny`)   |

`termino_limpio/2` quita artículos y cualificadores iniciales
("el objeto prolog" → `prolog`) y une las palabras restantes con guion
bajo ("bad bunny" → `bad_bunny`).

### Etapa 2 — `inferencia.pl`: `responder/1`

`responder/1` hace *pattern matching* sobre el término y consulta la base
de conocimiento. Si ninguna cláusula tiene éxito, falla y `main.pl`
activa el aprendizaje guiado.

Las inferencias clave usan **herencia por jerarquía**:

```prolog
tiene_propiedad(X, P) :- relacion_total(X, tiene, P).
tiene_propiedad(X, P) :- es_un_total(X, Y), relacion_total(Y, tiene, P).
```

Así, si `mamifero tiene pelo` y `leon → felino → mamifero`, entonces
`tiene_propiedad(leon, pelo)` es verdadero sin declararlo. Lo mismo para
`vive_en`, `se_alimenta_de` y `puede_hacer`.

### Etapa 3 — `main.pl`: aprendizaje guiado

Si el sistema no pudo responder, pide al usuario que le enseñe y
distingue dos tipos de conocimiento, guardados por separado (cualquiera
puede omitirse con Enter):

```
"No poseo conocimiento suficiente sobre eso. Permítame aprender."
"¿Cómo debo responder cuando me digan "X"? ..."   → aprendido_dialogo(X, Resp)
"¿Cuál es la definición de "X"? ..."               → aprendido_concepto(X, Def)
  → guardar_aprendido  (escribe data/aprendido.pl)
```

Así, tras enseñar `como estas`:

- `Como estas`        → la **respuesta** (`Bien y usted?`)
- `Que es como estas` → la **definición** (`Una manera de preguntar el bienestar`)

La respuesta directa (`dialogo`) tiene prioridad sobre el resumen, de modo
que un término con respuesta aprendida conversa de forma natural.

## Base de conocimiento (`conocimiento.pl`)

El conocimiento vive en dos capas que los predicados `*_total` unifican:

```
Capa estática (hechos en el archivo)
   concepto/2, es_un/2, relacion/3, sinonimo/2, dialogo/2

Capa dinámica (assertz en ejecución, persistida en data/)
   aprendido_concepto/2, aprendido_es_un/2, aprendido_relacion/3,
   aprendido_sinonimo/2, aprendido_dialogo/2
```

`es_un_total/2` es transitivo (herencia en cadena) y `equivalente/2`
resuelve cadenas de sinónimos. Cada vez que se aprende algo, se reescribe
el archivo correspondiente con `listing/1`, de modo que el conocimiento
persiste al siguiente arranque.
