;;; Se establece el hecho leer
(deffacts leer
   (leer)
)

;;; lectura
(defrule openfile_read
   (leer)
   =>
   (open "datos.txt" file)
   (assert (SeguirLeyendo))
)

(defrule readfile
   ?f <- (SeguirLeyendo)
   =>
   (bind ?valor (read file))
   (retract ?f)
   (if (neq ?valor EOF) then
   (assert (Dato ?valor))
   ;;; Se imprimen los valores que se van leyendo
   (printout t ?valor crlf)
   (assert (SeguirLeyendo)))
)

(defrule closefile_read
   (declare (salience -5))
   ?f <- (leer)
   =>
   (close file)
   (retract ?f)
)
