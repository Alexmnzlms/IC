# Alejandro Manzanares Lemus

## Estudio del problema "Asesorar a un alumno de informática en su elección de asignaturas en las que matricularse"

Se trata de analizar el problema de realizar un sistema experto para asesorar a un alumno de informática en su elección de asignaturas en las que matricularse. El experto será un compañero de clase, y el sistema debe reproducir cómo ese compañero aconsejaría al usuario que utilice el sistema.

Debe indicarse: el nombre del experto, la definición del problema, un análisis de viabilidad del mismo y el procedimiento seguido para definir el problema y para llevar a cabo el análisis de viabilidad. Incluir también un resumen de la entrevista realizada al compañero.

### Nombre del experto:
Juan Mota Martinez.

### Definición del problema:
Queremos obtener un sistema experto que sea capaz de ayudar a un estudiante de informática a elegir en que asignaturas debe matricularse.

### Analisis de la viabilidad:
Los datos de entrada son relativamente sencillos de obtener, pues se pueden extraer del expediente academico y de las guias docentes de las asignaturas junto con el horario.

Eliminar asignaturas sin conocimientos para cursar.
Intentar que la matricula sea lo mas barata posible -> Minimizar el numero de 2º o 3º matriculas
No coger dos asignaturas con horario solapado.

Cada tarea puede implementarse como un SBC que decida si es factible o no seleccionar una asignatura dependinedo de si se poseen conocimientos suficientes para cursarlas, seleccionar la asignatura mas "barata" y no coger dos asignaturas con el mismo horario.

### Procedimiento:


### Resumen de la entrevista:

Es importante tener en cuenta que asignaturas has superado y que asignaturas quedan pendientes de cursar, ademas hay que tener en cuenta cuales son de segunda matricula o superiores y cuales requieren haber cursado otras asignaturas previamente, asi como la carga de trabajo de la misma, la compatibilidad horaria.

Sistema de puntacion en la que pesan mas las asignaturas para las cuales has superado las asignaturas previas

Basandote en gustos recomendar si las asignaturas se solapan en horario pero tiene la misma puntuacion.

Valorar primero si una asignatura con varias matriculas tiene importancia para asignaturas posteriores. Preferible asignar matriculas mas altas a asignaturas mas basicas.

Cursar como maximo 5 asignaturas por cuatrimestre
