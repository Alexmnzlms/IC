(deffacts Ramas
(Rama Computacion_y_Sistemas_Inteligentes)
(Rama Ingenieria_del_Software)
(Rama Ingenieria_de_Computadores)
(Rama Sistemas_de_Informacion)
(Rama Tecnologias_de_la_Informacion)
)

;;;;  El experto utiliza la calificación media obtenida, tomando valores de Alta, Media
;;;;  o Baja, y se representa por (Calificacion_media Alta|Media|Baja)

(defrule Primera_pregunta
   =>
   (printout t "Te gustan las mates? (si/regular/no) ")
   (assert (gusta_mates (read)))
)

(defrule Segunda_pregunta
   =>
   (printout t "Te gusta programar? (si/regular/no) ")
   (assert (gusta_programar (read)))
)

(defrule Tercera_pregunta
   =>
   (printout t "Te gusta las bases de datos? (si/regular/no) ")
   (assert (gusta_bd (read)))
)

(defrule Cuarta_pregunta
   =>
   (printout t "Te gusta el hardware? (si/regular/no) ")
   (assert (gusta_hardware (read)))
)

(defrule Quinta_pregunta
   =>
   (printout t "Te gusta la docencia? (si/regular/no) ")
   (assert (gusta_docencia (read)))
)

(defrule Sexta_pregunta
   =>
   (printout t "Te gusta las informatica relacionada con web? (si/regular/no) ")
   (assert (gusta_web (read)))
)

(defrule Septima_pregunta
   =>
   (printout t "Te gusta la administracion de sistemas? (si/regular/no) ")
   (assert (gusta_sistemas (read)))
)

(defrule Octava_pregunta
   =>
   (printout t "Te gustan los videojuegos? (si/regular/no) ")
   (assert (gusta_videojuegos (read)))
)

(defrule Novena_pregunta
   =>
   (printout t "Te gustan la robotica? (si/regular/no) ")
   (assert (gusta_robotica (read)))
)

(defrule Decima_pregunta
   =>
   (printout t "Te gustan las redes (internet)? (si/regular/no) ")
   (assert (gusta_red (read)))
)
