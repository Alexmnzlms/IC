(deffacts hechos
   (Hecho leer 0)
   (Hecho correr 0)
   (Preguntar)
)

(defrule Pregunta
   (declare (salience 10))
   ?f <- (Preguntar)
   =>
   (printout t "¿Que haces? leer/correr/salir" crlf)
   (assert (ContarHechos (read)))
   (retract ?f)
)

(defrule leer
   ?f <- (ContarHechos leer)
   ?g <- (Hecho leer ?n)
   =>
   (printout t "Llevas un total de " (+ ?n 1) " leer" crlf)
   (assert (Hecho leer (+ ?n 1)) (Preguntar))
   (retract ?f ?g)
)

(defrule correr
   ?f <- (ContarHechos correr)
   ?g <- (Hecho correr ?n)
   =>
   (printout t "Llevas un total de " (+ ?n 1) " correr" crlf)
   (assert (Hecho correr (+ ?n 1)) (Preguntar))
   (retract ?f ?g)
)

(defrule Elegido_Salir
   (ContarHechos salir)
   =>
   (printout t "Hasta luego" crlf)
   (printout t crlf)
)

(defrule Elegido_otro
   (declare (salience -10))
   ?f <- (ContarHechos ?n)
   (test (neq leer ?n))
   (test (neq correr ?n))
   (test (neq salir ?n))
   =>
   (printout t ?n " no era una opción" crlf)
   (assert (Preguntar))
   (retract ?f)
)
