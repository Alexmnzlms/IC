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
   (printout t "Te gustan las mates? (si/no) ")
   (assert (gusta_mates (read)))
)

(defrule Gusta_mates
   (gusta_mates si)
   =>
   (assert (Consejo Computacion_y_Sistemas_Inteligentes "Te gustan las mates" "Manza"))
)

(defrule Gusta_mates
   (gusta_mates no)
   =>
   (assert (Consejo Tecnologias_de_la_Informacion "Eres un ser horrible" "Manza"))
)

(defrule Consejo
   (Consejo ?r ?m ?e)
   =>
   (printout t  ?e " te aconseja " ?r ", por el motivo: " ?m crlf )
)
