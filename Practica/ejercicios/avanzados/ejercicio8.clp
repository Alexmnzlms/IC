;;; Por defecto se establece el texto que se quiere escribir
(deffacts escribir
   (escribir Hola esto es una prueba de escritura a fichero utilizando clips)
)

;;; escritura
(defrule write
   ?f <- (escribir $?v)
   =>
   (open "datos.txt" file "w")
   (printout file $?v)
   (close file)
   (retract ?f)
   (assert (leer))
)
