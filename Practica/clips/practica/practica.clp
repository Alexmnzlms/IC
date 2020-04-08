(deffacts Ramas
(Rama Computacion_y_Sistemas_Inteligentes)
(Rama Ingenieria_del_Software)
(Rama Ingenieria_de_Computadores)
(Rama Sistemas_de_Informacion)
(Rama Tecnologias_de_la_Informacion)
)

(deffacts Consejos
(Consejo CSI 0)
(Consejo IS 0)
(Consejo IC 0)
(Consejo SI 0)
(Consejo TI 0)
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
   (assert (Gusta red (read)) (pregunta 10) (final))
)

(defrule Gusta_mates_si
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   (Gusta mates si)
   ?q <- (pregunta 1)
   =>
   (assert (Consejo CSI (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_mates_regular
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   (Gusta mates regular)
   ?q <- (pregunta 1)
   =>
   (assert (Consejo CSI (+ ?i 2)))
   (retract ?f ?q)
)

(defrule Gusta_programar_si
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IS ?j)
   (Gusta programar si)
   ?q <- (pregunta 2)
   =>
   (assert (Consejo CSI (+ ?i 5)) (Consejo IS (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_programar_regular
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IS ?j)
   (Gusta programar regular)
   ?q <- (pregunta 2)
   =>
   (assert (Consejo CSI (+ ?i 2)) (Consejo IS (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_bd_si
   (declare (salience 1))
   ?f <- (Consejo SI ?i)
   (Gusta bases_de_datos si)
   ?q <- (pregunta 3)
   =>
   (assert (Consejo SI (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_bd_regular
   (declare (salience 1))
   ?f <- (Consejo SI ?i)
   (Gusta bases_de_datos regular)
   ?q <- (pregunta 3)
   =>
   (assert (Consejo SI (+ ?i 2)))
   (retract ?f ?q)
)

(defrule Gusta_hardware_si
   (declare (salience 1))
   ?f <- (Consejo IC ?i)
   (Gusta hardware si)
   ?q <- (pregunta 4)
   =>
   (assert (Consejo IC (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_hardware_regular
   (declare (salience 1))
   ?f <- (Consejo IC ?i)
   (Gusta hardware regular)
   ?q <- (pregunta 4)
   =>
   (assert (Consejo IC (+ ?i 2)))
   (retract ?f ?q)
)

(defrule Gusta_docencia_si
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo SI ?j)
   (Gusta docencia si)
   ?q <- (pregunta 5)
   =>
   (assert (Consejo CSI (+ ?i 5)) (Consejo SI (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_docencia_regular
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo SI ?j)
   (Gusta docencia regular)
   ?q <- (pregunta 5)
   =>
   (assert (Consejo CSI (+ ?i 2)) (Consejo SI (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_web_si
   (declare (salience 1))
   ?f <- (Consejo IS ?i)
   ?g <- (Consejo TI ?j)
   (Gusta web si)
   ?q <- (pregunta 6)
   =>
   (assert (Consejo IS (+ ?i 5)) (Consejo TI (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_web_regular
   (declare (salience 1))
   ?f <- (Consejo IS ?i)
   ?g <- (Consejo TI ?j)
   (Gusta web regular)
   ?q <- (pregunta 6)
   =>
   (assert (Consejo IS (+ ?i 2)) (Consejo TI (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_sistemas_si
   (declare (salience 1))
   ?f <- (Consejo IC ?i)
   ?g <- (Consejo SI ?j)
   (Gusta sistemas si)
   ?q <- (pregunta 7)
   =>
   (assert (Consejo IC (+ ?i 5)) (Consejo SI (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_sistemas_regular
   (declare (salience 1))
   ?f <- (Consejo IC ?i)
   ?g <- (Consejo SI ?j)
   (Gusta sistemas regular)
   ?q <- (pregunta 7)
   =>
   (assert (Consejo IC (+ ?i 2)) (Consejo SI (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_videojuegos_si
   (declare (salience 1))
   ?f <- (Consejo IS ?i)
   (Gusta videojuegos si)
   ?q <- (pregunta 8)
   =>
   (assert (Consejo IS (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_videojuegos_regular
   (declare (salience 1))
   ?f <- (Consejo IS ?i)
   (Gusta videojuegos regular)
   ?q <- (pregunta 8)
   =>
   (assert (Consejo IS (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_robotica_si
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IC ?j)
   (Gusta robotica si)
   ?q <- (pregunta 9)
   =>
   (assert (Consejo CSI (+ ?i 5)) (Consejo IC (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_robotica_regular
   (declare (salience 1))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IC ?j)
   (Gusta robotica regular)
   ?q <- (pregunta 9)
   =>
   (assert (Consejo CSI (+ ?i 2)) (Consejo IC (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_red_si
   (declare (salience 1))
   ?f <- (Consejo TI ?i)
   (Gusta red si)
   ?q <- (pregunta 10)
   =>
   (assert (Consejo TI (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_red_regular
   (declare (salience 1))
   ?f <- (Consejo TI ?i)
   (Gusta red regular)
   ?q <- (pregunta 10)
   =>
   (assert (Consejo TI (+ ?i 2)))
   (retract ?f ?q)
)

(defrule Consejos
   (declare (salience 100))
   (Consejo ?r ?p)
   =>
   (printout t "Consejo " ?r " " ?p crlf)

)

(defrule Consejos_final
   (declare (salience -100))
   (final)
   (Consejo ?r ?p)
   =>
   (printout t "Consejo Final " ?r " " ?p crlf)

)
