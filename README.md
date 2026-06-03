# Proyecto 3 - Chatbot Inteligente con Programación Lógica

## Ejecutar
Desde la raíz del proyecto:
```bash
swipl main.pl
```

## Estructura
- `main.pl` — punto de entrada, bucle de conversación, entrada/salida y aprendizaje guiado.
- `conocimiento.pl` — base de conocimiento (hechos), capa `*_total` (estático + aprendido), sinónimos y persistencia.
- `inferencia.pl` — motor de razonamiento (herencia por jerarquía) y `responder/1`.
- `nlp.pl` — convierte el texto en español del usuario en términos Prolog.
- `data/` — conocimiento aprendido que persiste entre sesiones.
Ortiz Brenes Jose Felipe
Otarola Ulate Carina
Padilla Escalante Sebastian De Jesus
Palacios Quiros	Isabella
Quesada Phillips Julian
Rojas Rojas	Josue David
Solis Chaves Francisco Jesus	
Valverde Chacon	Nicole Fernanda
