;;;; Representamos las posibles ramas a recomendar.
(deffacts Ramas
(Rama Computacion_y_Sistemas_Inteligentes)
(Rama Ingenieria_del_Software)
(Rama Ingenieria_de_Computadores)
(Rama Sistemas_de_Informacion)
(Rama Tecnologias_de_la_Informacion)
)

;;;; Establecemos el nivel de consejo de cada Rama.
(deffacts Consejos
(Consejo CSI 0)
(Consejo IS 0)
(Consejo IC 0)
(Consejo SI 0)
(Consejo TI 0)
)

;;;; Establecemos la relación entre el tema que se pregunta y la rama a la que el
;;;; tema hace referencia.
(deffacts Relaciones
(Relacion mates CSI)
(Relacion programar CSI)
(Relacion programar IS)
(Relacion bases_de_datos SI)
(Relacion hardware IC)
(Relacion docencia CSI)
(Relacion docencia SI)
(Relacion web IS)
(Relacion web TI)
(Relacion sistemas IC)
(Relacion sistemas SI)
(Relacion videojuegos IS)
(Relacion robotica CSI)
(Relacion robotica IC)
(Relacion red TI  )

)

;;;; El sistema hace una serie de preguntas al usuario, para conocer su grado de
;;;; en los temas que corresponden a las ramas.
;;;; Por cada pregunta, el sistema almacena la informacion que ha
;;;; obtenido del usuario de la siguiente manera:
;;;; Si ha repondido que le gustan las mates, el sistema registra el hecho
;;;; (Gusta mates si)
;;;; Y si ha respondido que le gusta la regular programar registra
;;;;(Gusta programar regular)

(defrule Primera_pregunta
   (not (terminado si))
   =>
   (printout t "Te gustan las mates? (si/regular/no)" crlf)
   (assert (Gusta mates (read)) (pregunta 1) (terminar))
)

(defrule Segunda_pregunta
   (not (terminado si))
   =>
   (printout t "Te gusta programar? (si/regular/no)" crlf)
   (assert (Gusta programar (read)) (pregunta 2) (terminar))
)

(defrule Tercera_pregunta
   (not (terminado si))
   =>
   (printout t "Te gusta las bases de datos? (si/regular/no)" crlf)
   (assert (Gusta bases_de_datos (read)) (pregunta 3) (terminar))
)

(defrule Cuarta_pregunta
   (not (terminado si))
   =>
   (printout t "Te gusta el hardware? (si/regular/no)" crlf)
   (assert (Gusta hardware (read)) (pregunta 4) (terminar))
)

(defrule Quinta_pregunta
   (not (terminado si))
   =>
   (printout t "Te gusta la docencia? (si/regular/no)" crlf)
   (assert (Gusta docencia (read)) (pregunta 5) (terminar))
)

(defrule Sexta_pregunta
   (not (terminado si))
   =>
   (printout t "Te gusta las informatica relacionada con web? (si/regular/no)" crlf)
   (assert (Gusta web (read)) (pregunta 6) (terminar))
)

(defrule Septima_pregunta
   (not (terminado si))
   =>
   (printout t "Te gusta la administracion de sistemas? (si/regular/no)" crlf)
   (assert (Gusta sistemas (read)) (pregunta 7) (terminar))
)

(defrule Octava_pregunta
   (not (terminado si))
   =>
   (printout t "Te gustan los videojuegos? (si/regular/no)" crlf)
   (assert (Gusta videojuegos (read)) (pregunta 8) (terminar))
)

(defrule Novena_pregunta
   (not (terminado si))
   =>
   (printout t "Te gustan la robotica? (si/regular/no)" crlf)
   (assert (Gusta robotica (read)) (pregunta 9) (terminar))
)

(defrule Decima_pregunta
   (not (terminado si))
   =>
   (printout t "Te gustan las redes (internet)? (si/regular/no)" crlf)
   (assert (Gusta red (read)) (pregunta 10) (terminado si))
)

;;;; Una vez ha registrado los intereses del usuario, razona que puntuacion debe
;;;; darle a cada recomendación en función del grado de interes que ha mostrado
;;;; el usuario por cada tema. Cada tema se relaciona con una rama, por lo que
;;;; responder si o regular, aumenta el nivel de recomendación de la rama
;;;; relacionada con el tema.
;;;; +5 si el tema le gusta, +2 si le gusta regular.

(defrule Gusta_mates_si
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   (Gusta mates si)
   ?q <- (pregunta 1)
   =>
   (assert (Consejo CSI (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_mates_regular
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   (Gusta mates regular)
   ?q <- (pregunta 1)
   =>
   (assert (Consejo CSI (+ ?i 2)))
   (retract ?f ?q)
)

(defrule Gusta_programar_si
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IS ?j)
   (Gusta programar si)
   ?q <- (pregunta 2)
   =>
   (assert (Consejo CSI (+ ?i 5)) (Consejo IS (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_programar_regular
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IS ?j)
   (Gusta programar regular)
   ?q <- (pregunta 2)
   =>
   (assert (Consejo CSI (+ ?i 2)) (Consejo IS (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_bd_si
   (declare (salience 10))
   ?f <- (Consejo SI ?i)
   (Gusta bases_de_datos si)
   ?q <- (pregunta 3)
   =>
   (assert (Consejo SI (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_bd_regular
   (declare (salience 10))
   ?f <- (Consejo SI ?i)
   (Gusta bases_de_datos regular)
   ?q <- (pregunta 3)
   =>
   (assert (Consejo SI (+ ?i 2)))
   (retract ?f ?q)
)

(defrule Gusta_hardware_si
   (declare (salience 10))
   ?f <- (Consejo IC ?i)
   (Gusta hardware si)
   ?q <- (pregunta 4)
   =>
   (assert (Consejo IC (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_hardware_regular
   (declare (salience 10))
   ?f <- (Consejo IC ?i)
   (Gusta hardware regular)
   ?q <- (pregunta 4)
   =>
   (assert (Consejo IC (+ ?i 2)))
   (retract ?f ?q)
)

(defrule Gusta_docencia_si
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo SI ?j)
   (Gusta docencia si)
   ?q <- (pregunta 5)
   =>
   (assert (Consejo CSI (+ ?i 5)) (Consejo SI (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_docencia_regular
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo SI ?j)
   (Gusta docencia regular)
   ?q <- (pregunta 5)
   =>
   (assert (Consejo CSI (+ ?i 2)) (Consejo SI (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_web_si
   (declare (salience 10))
   ?f <- (Consejo IS ?i)
   ?g <- (Consejo TI ?j)
   (Gusta web si)
   ?q <- (pregunta 6)
   =>
   (assert (Consejo IS (+ ?i 5)) (Consejo TI (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_web_regular
   (declare (salience 10))
   ?f <- (Consejo IS ?i)
   ?g <- (Consejo TI ?j)
   (Gusta web regular)
   ?q <- (pregunta 6)
   =>
   (assert (Consejo IS (+ ?i 2)) (Consejo TI (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_sistemas_si
   (declare (salience 10))
   ?f <- (Consejo IC ?i)
   ?g <- (Consejo SI ?j)
   (Gusta sistemas si)
   ?q <- (pregunta 7)
   =>
   (assert (Consejo IC (+ ?i 5)) (Consejo SI (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_sistemas_regular
   (declare (salience 10))
   ?f <- (Consejo IC ?i)
   ?g <- (Consejo SI ?j)
   (Gusta sistemas regular)
   ?q <- (pregunta 7)
   =>
   (assert (Consejo IC (+ ?i 2)) (Consejo SI (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_videojuegos_si
   (declare (salience 10))
   ?f <- (Consejo IS ?i)
   (Gusta videojuegos si)
   ?q <- (pregunta 8)
   =>
   (assert (Consejo IS (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_videojuegos_regular
   (declare (salience 10))
   ?f <- (Consejo IS ?i)
   (Gusta videojuegos regular)
   ?q <- (pregunta 8)
   =>
   (assert (Consejo IS (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_robotica_si
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IC ?j)
   (Gusta robotica si)
   ?q <- (pregunta 9)
   =>
   (assert (Consejo CSI (+ ?i 5)) (Consejo IC (+ ?j 5)))
   (retract ?f ?g ?q)
)

(defrule Gusta_robotica_regular
   (declare (salience 10))
   ?f <- (Consejo CSI ?i)
   ?g <- (Consejo IC ?j)
   (Gusta robotica regular)
   ?q <- (pregunta 9)
   =>
   (assert (Consejo CSI (+ ?i 2)) (Consejo IC (+ ?j 2)))
   (retract ?f ?g ?q)
)

(defrule Gusta_red_si
   (declare (salience 10))
   ?f <- (Consejo TI ?i)
   (Gusta red si)
   ?q <- (pregunta 10)
   =>
   (assert (Consejo TI (+ ?i 5)))
   (retract ?f ?q)
)

(defrule Gusta_red_regular
   (declare (salience 10))
   ?f <- (Consejo TI ?i)
   (Gusta red regular)
   ?q <- (pregunta 10)
   =>
   (assert (Consejo TI (+ ?i 2)))
   (retract ?f ?q)
)

;;;; Se ha añadido la caracteristica de que al detectar una alta puntuacion para
;;;; recomendar una rama, respecto a la puntuación total que puede obtener,
;;;; el sistema pare de preguntar y recomiende la rama que considera mas adecuada
;;;; en base a la puntuación.

(defrule CSI_max
   (declare (salience 10))
   (Consejo CSI ?n)
   (test (eq ?n 15))
   ?f <- (terminar)
   =>
   (printout t "He detectado que CSI puede ser la mejor rama" crlf)
   (assert (terminado si))
   (retract ?f)
)

(defrule IS_max
   (declare (salience 10))
   (Consejo IS ?n)
   (test (eq ?n 10))
   ?f <- (terminar)
   =>
   (printout t "He detectado que IS puede ser la mejor rama" crlf)
   (assert (terminado si))
   (retract ?f)
)

(defrule IC_max
   (declare (salience 10))
   (Consejo IC ?n)
   (test (eq ?n 10))
   ?f <- (terminar)
   =>
   (printout t "He detectado que IC puede ser la mejor rama" crlf)
   (assert (terminado si))
   (retract ?f)
)

(defrule SI_max
   (declare (salience 10))
   (Consejo SI ?n)
   (test (eq ?n 10))
   ?f <- (terminar)
   =>
   (printout t "He detectado que SI puede ser la mejor rama" crlf)
   (assert (terminado si))
   (retract ?f)
)

(defrule TI_max
   (declare (salience 10))
   (Consejo TI ?n)
   (test (eq ?n 5))
   ?f <- (terminar)
   =>
   (printout t "He detectado que TI puede ser la mejor rama" crlf)
   (assert (terminado si))
   (retract ?f)
)

;;;; Cada vez que se ha respondido al usuario, el sistema pregunta si ha terminado
;;;; y por tanto si quiere recibir una recomendación con la informacion actual.

(defrule Preguntar_Final
   (declare (salience 1))
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

;;;; Estas regla muestran los motivos por los cuales se recomienda una rama.

(defrule Aconsejo
   (declare (salience 100))
   (final)
   (Consejo ?r ?p)
   (test (neq ?p 0))
   (Relacion ?m ?r)
   (Gusta ?m si)
   =>
   (printout t "Te recomiendo " ?r " porque te gusta " ?m crlf)
)

(defrule Aconsejo_regular
   (declare (salience 90))
   (final)
   (Consejo ?r ?p)
   (test (neq ?p 0))
   (Relacion ?m ?r)
   (Gusta ?m regular)
   =>
   (printout t "Tambien te recomiendo " ?r " porque te gusta regular " ?m crlf)
)
