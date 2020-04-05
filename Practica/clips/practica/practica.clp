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

(defrule Gusta_mates_si
   (gusta_mates si)
   (gusta_programar si)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes "Te gustan las mates y programar" "Manza"))
)

(defrule Gusta_mates_no
   (gusta_mates no)
   (gusta_programar si)
   =>
   (assert (Consejo Ingenieria_del_Software "Te gusta programar" "Manza"))
)

(defrule gusta_programar_sis
   (gusta_mates si)
   (gusta_programar no)
   =>
   (assert (Consejo Sistemas_de_Informacion "Te gustan las mates" "Manza"))
)

(defrule gusta_programar_no
   (gusta_mates no)
   (gusta_programar no)
   =>
   (assert (Consejo Tecnologias_de_la_Informacion "No te gusta nada" "Manza"))
)

(defrule Consejo
   (Consejo ?r ?m ?e)
   =>
   (printout t  ?e " te aconseja " ?r ", por el motivo: " ?m crlf )
)
