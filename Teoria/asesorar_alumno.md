## Alejandro Manzanares Lemus

# Estudio del problema "Asesorar a un alumno de informática en su elección de asignaturas en las que matricularse"

Se trata de analizar el problema de realizar un sistema experto para asesorar a un alumno de informática en su elección de asignaturas en las que matricularse. El experto será un compañero de clase, y el sistema debe reproducir cómo ese compañero aconsejaría al usuario que utilice el sistema.

Se trata de analizar el problema de realizar un sistema experto para asesorar a un alumno de informática en su elección de asignaturas en las que matricularse. El experto será un compañero de clase, y el sistema debe reproducir cómo ese compañero aconsejaría al usuario que utilice
Debe indicarse: el nombre del experto, la definición del problema, un análisis de viabilidad del mismo y el procedimiento seguido para definir el problema y para llevar a cabo el análisis de viabilidad. Incluir también un resumen de la entrevista realizada al compañero.

# Nombre del experto:
Juan Mota Martinez.

# Definición del problema:
Queremos obtener un sistema experto que sea capaz de ayudar a un estudiante de informática a elegir en que asignaturas debe matricularse.

# Análisis de la viabilidad:
Los datos de entrada son relativamente sencillos de obtener, pues se pueden extraer del expediente académico y de las guías docentes de las distintas asignaturas junto con el horario.

Hay que intentar eliminar las asignaturas para las que necesitemos conocimientos previos que no tengamos. También intentar que la matrícula sea lo más barata posible, es decir, minimizar el número de 2º o 3º matrículas. Importante no coger dos asignaturas con horario solapado.

Cada tarea puede implementarse como un SBC que decida si es factible o no seleccionar una asignatura dependiendo de si se poseen conocimientos suficientes para cursarlas, seleccionar la asignatura más "barata" y no coger dos asignaturas con el mismo horario.

# Procedimiento:
Lo primero ha sido decidir que información es necesaria para definir el problema, y si esta información es accesible o no.

Después me he puesto en contacto con el experto, para ver cómo debe usarse la información, que estructuras son necesarias para representarla y que cosas son esenciales para poder desarrollar el sistema experto.

El siguiente paso sería desarrollar los diferentes SBC que se encarguen de tomar las decisiones del sistema experto.

\newpage

# Resumen de la entrevista:
Los puntos mas importantes extraídos de la entrevista son:

- Es importante tener en cuenta que asignaturas has superado y que asignaturas quedan pendientes de cursar, además hay que tener en cuenta cuáles son de segunda matrícula o superiores y cuales requieren haber cursado otras asignaturas previamente, así como la carga de trabajo de la misma y la compatibilidad horaria.

- Sistema de puntuación en la que pesan más las asignaturas para las cuales has superado las asignaturas previas.

- Si las asignaturas se solapan en horario y tienen la misma puntuación recomendar basándote en gustos.

- Valorar primero si una asignatura con varias matrículas cursadas tiene importancia para asignaturas posteriores.

- Preferible asignar matrículas más altas a asignaturas más básicas.

- Cursar como máximo 5 asignaturas por cuatrimestre
