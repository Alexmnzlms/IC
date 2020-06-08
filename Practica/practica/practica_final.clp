;;;; Representamos las posibles ramas a recomendar.
(deffacts Ramas
   (rama CSI)
   (rama IS)
   (rama IC)
   (rama SI)
   (rama TI)
)

;;;; Establecemos la relación entre el tema que se pregunta y la rama a la que el
;;;; tema hace referencia.
(deffacts Relaciones
   (relacion mates CSI)
   (relacion programar CSI)
   (relacion programar IS)
   (relacion bases_de_datos SI)
   (relacion hardware IC)
   (relacion docencia CSI)
   (relacion docencia SI)
   (relacion web IS)
   (relacion web TI)
   (relacion sistemas IC)
   (relacion sistemas SI)
   (relacion videojuegos IS)
   (relacion robotica CSI)
   (relacion robotica IC)
   (relacion red TI)
)

(deffacts Explicaciones
   (explicacion mates "te gustan las matematicas")
   (explicacion programar "te gusta programar")
   (explicacion bases_de_datos "te gustan las bases de datos")
   (explicacion hardware "te gustan el hardware")
   (explicacion docencia "te gustan la dodencia")
   (explicacion web "te gusta la programación web o diseño web")
   (explicacion sistemas "te gusta la administracion de sistemas")
   (explicacion videojuegos "te gustan los videoguejos")
   (explicacion robotica "te gustan los robocs")
   (explicacion red "te gustan las redes, te contaria un chiste UDP, pero igual no lo pillas")
   (explicacion por_defecto " no tengo suficiente información para no recomendarte esta rama, puesto que siempre puedes descubrir algo nuevo")
)

(deffacts Explicacion_consejo
   (expl_consejo CSI "")
   (expl_consejo IS "")
   (expl_consejo IC "")
   (expl_consejo SI "")
   (expl_consejo TI "")
)

;;;; El sistema hace una serie de preguntas al usuario, para conocer su grado de
;;;; en los temas que corresponden a las ramas.
;;;; Por cada pregunta, el sistema almacena la informacion que ha
;;;; obtenido del usuario de la siguiente manera:
;;;; Si ha repondido que le gustan las mates, el sistema registra el hecho
;;;; (gusta mates si)
;;;; Y si ha respondido que le gusta la regular programar registra
;;;;(gusta programar regular)

(defrule Consejo_por_defecto
   (declare (salience 1000))
   (rama ?r)
   =>
   (assert (consejo ?r por_defecto))
   (printout t "consejo " ?r " por_defecto" crlf)
)

(defrule Primera_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gustan las mates? (si/no)" crlf)
   (assert (gusta mates (read)) (terminar))
)

(defrule Segunda_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gusta programar? (si/no)" crlf)
   (assert (gusta programar (read)) (terminar))
)

(defrule Tercera_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gusta las bases de datos? (si/no)" crlf)
   (assert (gusta bases_de_datos (read)) (terminar))
)

(defrule Cuarta_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gusta el hardware? (si/no)" crlf)
   (assert (gusta hardware (read)) (terminar))
)

(defrule Quinta_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gusta la docencia? (si/no)" crlf)
   (assert (gusta docencia (read)) (terminar))
)

(defrule Sexta_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gusta las informatica relacionada con web? (si/no)" crlf)
   (assert (gusta web (read)) (terminar))
)

(defrule Septima_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gusta la administracion de sistemas? (si/no)" crlf)
   (assert (gusta sistemas (read)) (terminar))
)

(defrule Octava_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gustan los videojuegos? (si/no)" crlf)
   (assert (gusta videojuegos (read)) (terminar))
)

(defrule Novena_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gustan la robotica? (si/no)" crlf)
   (assert (gusta robotica (read)) (terminar))
)

(defrule Decima_pregunta
   (declare (salience 100))
   (not (terminado si))
   =>
   (printout t "Te gustan las redes (internet)? (si/no)" crlf)
   (assert (gusta red (read)) (terminado si))
)


;;;; Cada vez que se ha respondido al usuario, el sistema pregunta si ha terminado
;;;; y por tanto si quiere recibir una recomendación con la informacion actual.

(defrule Preguntar_Final
   (declare (salience 100))
   ?f <- (terminar)
   =>
   (printout t "¿Has terminado? (si/no)" crlf)
   (assert (terminado (read)))
   (retract ?f)
)

;;;; Regla que define cuando se ha terminado de preguntar

(defrule Terminar
   (declare (salience 100))
   (terminado si)
   =>
   (assert (final))
)

(defrule Info_obtenida
   (declare (salience 11))
   (gusta ?r ?n)
   =>
   (printout t "gusta " ?r " " ?n crlf)
)

(defrule Razonar_gusto_rama
   (declare (salience 10))
   (gusta ?r ?n)
   (relacion ?r ?R)
   =>
   (assert (gusta_rama ?r ?R ?n))
   (printout t "gusta_rama " ?r " " ?R " " ?n crlf)

)

(defrule Razonar_consejo
   (declare (salience 5))
   (gusta_rama ?r ?R $? no)
   ?g <- (consejo ?R $? por_defecto)
   =>
   (retract ?g)
   (assert (consejo ?R no))
   (printout t "consejo " ?R " no" crlf)
)

(defrule Razonar_consejo_si
   (declare (salience 5))
   (gusta_rama ?r ?R $? si)
   ?g <- (consejo ?R ?n)
   (test (neq ?n si))
   =>
   (retract ?g)
   (assert (consejo ?R si))
   (printout t "consejo " ?R " si" crlf)
)

(defrule Motivos_consejo_por_defecto
   (declare (salience 1))
   ?g <- (consejo ?R por_defecto)
   ?f <- (expl_consejo ?R ?expl)
   (explicacion por_defecto ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo))
   (assert (expl_consejo ?R ?texto))
   (retract ?g ?f)
)

(defrule Motivos_consejo
   ?g <- (gusta_rama ?r ?R $? si)
   (consejo ?R $? si)
   ?f <- (expl_consejo ?R ?expl)
   (explicacion ?r ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (expl_consejo ?R ?texto))
   (retract ?g ?f)
)

(defrule Expl_razonada
   (declare (salience -10))
   (consejo ?R ?n)
   (test (or (eq ?n si) (eq ?n por_defecto)))
   (expl_consejo ?R ?expl)
   =>
   (printout t "Te aconsejo " ?R " porque " ?expl " - Manza" crlf)
)
