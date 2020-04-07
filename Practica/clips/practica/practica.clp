(deffacts Ramas
(Rama Computacion_y_Sistemas_Inteligentes)
(Rama Ingenieria_del_Software)
(Rama Ingenieria_de_Computadores)
(Rama Sistemas_de_Informacion)
(Rama Tecnologias_de_la_Informacion)
)

(deffacts Consejos
(Consejo Computacion_y_Sistemas_Inteligentes 0)
(Consejo Ingenieria_del_Software 0)
(Consejo Ingenieria_de_Computadores 0)
(Consejo Sistemas_de_Informacion 0)
(Consejo Tecnologias_de_la_Informacion 0)
)

;;;;  El experto utiliza la calificación media obtenida, tomando valores de Alta, Media
;;;;  o Baja, y se representa por (Calificacion_media Alta|Media|Baja)

(defrule Primera_pregunta
   =>
   (printout t "Te gustan las mates? (si/regular/no)" crlf)
   (assert (Gusta mates (read)))
)

(defrule Segunda_pregunta
   =>
   (printout t "Te gusta programar? (si/regular/no)" crlf)
   (assert (Gusta programar (read)))
)

(defrule Tercera_pregunta
   =>
   (printout t "Te gusta las bases de datos? (si/regular/no)" crlf)
   (assert (Gusta bases_de_datos (read)))
)

(defrule Cuarta_pregunta
   =>
   (printout t "Te gusta el hardware? (si/regular/no)" crlf)
   (assert (Gusta hardware (read)))
)

(defrule Quinta_pregunta
   =>
   (printout t "Te gusta la docencia? (si/regular/no)" crlf)
   (assert (Gusta docencia (read)))
)

(defrule Sexta_pregunta
   =>
   (printout t "Te gusta las informatica relacionada con web? (si/regular/no)" crlf)
   (assert (Gusta web (read)))
)

(defrule Septima_pregunta
   =>
   (printout t "Te gusta la administracion de sistemas? (si/regular/no)" crlf)
   (assert (Gusta sistemas (read)))
)

(defrule Octava_pregunta
   =>
   (printout t "Te gustan los videojuegos? (si/regular/no)" crlf)
   (assert (Gusta videojuegos (read)))
)

(defrule Novena_pregunta
   =>
   (printout t "Te gustan la robotica? (si/regular/no)" crlf)
   (assert (Gusta robotica (read)))
)

(defrule Decima_pregunta
   =>
   (printout t "Te gustan las redes (internet)? (si/regular/no)" crlf)
   (assert (Gusta red (read)))
)

(defrule Gusta_mates_si
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?g <- (Gusta mates si)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 5)))
   (printout t "Consejo CSI " ?i crlf)
   (retract ?f ?g)
)

(defrule Gusta_mates_regular
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?g <- (Gusta mates regular)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 2)))
   (printout t "Consejo CSI " ?i crlf)
   (retract ?f ?g)
)

(defrule Gusta_programar_si
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?h <- (Consejo Ingenieria_del_Software ?j)
   ?g <- (Gusta mates si)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 5)) (Consejo Ingenieria_del_Software (+ ?j 5)))
   (printout t "Consejo CSI " ?i crlf)
   (printout t "Consejo IS " ?j crlf)
   (retract ?f ?h ?g)
)

(defrule Gusta_programar_regular
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?h <- (Consejo Ingenieria_del_Software ?j)
   ?g <- (Gusta mates si)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 5)) (Consejo Ingenieria_del_Software (+ ?j 5)))
   (printout t "Consejo CSI " ?i crlf)
   (printout t "Consejo IS " ?j crlf)
   (retract ?f ?h ?g)
)
