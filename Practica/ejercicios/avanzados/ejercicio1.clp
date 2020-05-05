;;; Por defecto se establece que no hay opcion elegida y que se tiene que preguntar
(deffacts Inicio
   (preguntar)
   (OpcionElegida Nada)
)

;;; Regla que solicita los datos
;;; Establece el hecho OpcionElegida XXX
(defrule Solicitar_datos
   (declare (salience 10))
   ?p <- (OpcionElegida ?o)
   ?f <- (preguntar)
   =>
   (printout t "Elige una de las siguientes sagas de fantasía:" crlf)
   (printout t "  Nacidos_de_la_bruma" crlf)
   (printout t "  El_archivo_de_las_tormentas" crlf)
   (printout t "  Cronica_del_asesino_de_reyes" crlf)
   (printout t "  El_señor_de_los_anillos" crlf)
   (printout t "  salir" crlf)
   (assert (OpcionElegida (read)))
   (retract ?f ?p)
)

;;; Diferentes reglas segun la opción elegida
(defrule Elegido_Nacidos
   (OpcionElegida Nacidos_de_la_bruma)
   =>
   (printout t "Elegido Nacidos de la bruma" crlf)
   (printout t crlf)
   (assert (preguntar))
)

(defrule Elegido_Tormentas
   (OpcionElegida El_archivo_de_las_tormentas)
   =>
   (printout t "Elegido el archivo de las tormentas" crlf)
   (printout t crlf)
   (assert (preguntar))
)

(defrule Elegido_Cronicas
   (OpcionElegida Cronica_del_asesino_de_reyes)
   =>
   (printout t "Elegido cronicas del asesino de reyes" crlf)
   (printout t crlf)
   (assert (preguntar))
)

(defrule Elegido_Anillos
   (OpcionElegida El_señor_de_los_anillos)
   =>
   (printout t "Elegido el señor de los anillos" crlf)
   (printout t crlf)
   (assert (preguntar))
)
;;; Si se elige salir no se reinicia el bucle
(defrule Elegido_Salir
   (OpcionElegida salir)
   =>
   (printout t "Hasta luego" crlf)
   (printout t crlf)
)

(defrule Elegido_otro
   (declare (salience -10))
   ?f <- (OpcionElegida ?n)
   (test (neq Nacidos_de_la_bruma ?n))
   (test (neq El_archivo_de_las_tormentas ?n))
   (test (neq Cronica_del_asesino_de_reyes ?n))
   (test (neq El_señor_de_los_anillos ?n))
   (test (neq salir ?n))
   =>
   (printout t ?n " no era una opción" crlf)
   (printout t crlf)
   (assert (preguntar) (OpcionElegida Nada))
   (retract ?f)
)
