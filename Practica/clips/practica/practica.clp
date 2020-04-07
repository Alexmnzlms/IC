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
   (assert (Gusta mates (read)) (pregunta 1))
)

(defrule Segunda_pregunta
   =>
   (printout t "Te gusta programar? (si/regular/no)" crlf)
   (assert (Gusta programar (read)) (pregunta 2))
)

(defrule Tercera_pregunta
   =>
   (printout t "Te gusta las bases de datos? (si/regular/no)" crlf)
   (assert (Gusta bases_de_datos (read)) (pregunta 3))
)

(defrule Cuarta_pregunta
   =>
   (printout t "Te gusta el hardware? (si/regular/no)" crlf)
   (assert (Gusta hardware (read)) (pregunta 4))
)

(defrule Quinta_pregunta
   =>
   (printout t "Te gusta la docencia? (si/regular/no)" crlf)
   (assert (Gusta docencia (read)) (pregunta 5))
)

(defrule Sexta_pregunta
   =>
   (printout t "Te gusta las informatica relacionada con web? (si/regular/no)" crlf)
   (assert (Gusta web (read)) (pregunta 6))
)

(defrule Septima_pregunta
   =>
   (printout t "Te gusta la administracion de sistemas? (si/regular/no)" crlf)
   (assert (Gusta sistemas (read)) (pregunta 7))
)

(defrule Octava_pregunta
   =>
   (printout t "Te gustan los videojuegos? (si/regular/no)" crlf)
   (assert (Gusta videojuegos (read)) (pregunta 8))
)

(defrule Novena_pregunta
   =>
   (printout t "Te gustan la robotica? (si/regular/no)" crlf)
   (assert (Gusta robotica (read)) (pregunta 9))
)

(defrule Decima_pregunta
   =>
   (printout t "Te gustan las redes (internet)? (si/regular/no)" crlf)
   (assert (Gusta red (read)) (pregunta 10))
)

(defrule Gusta_mates_si
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?g <- (Gusta mates si)
   ?q <- (pregunta 1)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 5)))
   (printout t "Consejo CSI " ?i crlf)
   (retract ?f ?g ?q)
)

(defrule Gusta_mates_regular
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?g <- (Gusta mates regular)
   ?q <- (pregunta 1)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 2)))
   (printout t "Consejo CSI " ?i crlf)
   (retract ?f ?g ?q)
)

(defrule Gusta_programar_si
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?g <- (Consejo Ingenieria_del_Software ?j)
   (Gusta programar si)
   ?q <- (pregunta 2)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 5)) (Consejo Ingenieria_del_Software (+ ?j 5)))
   (printout t "Consejo CSI " ?i crlf)
   (printout t "Consejo IS " ?j crlf)
   (retract ?f ?g ?q)
)

(defrule Gusta_programar_regular
   (declare (salience 1))
   ?f <- (Consejo Computacion_y_Sistemas_Inteligentes ?i)
   ?g <- (Consejo Ingenieria_del_Software ?j)
   (Gusta programar regular)
   ?q <- (pregunta 2)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes (+ ?i 5)) (Consejo Ingenieria_del_Software (+ ?j 5)))
   (printout t "Consejo CSI " ?i crlf)
   (printout t "Consejo IS " ?j crlf)
   (retract ?f ?g ?q)
)
