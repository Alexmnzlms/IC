; ;;;; Representamos las posibles ramas a recomendar.
; (deffacts Ramas
;    (rama CSI)
;    (rama IS)
;    (rama IC)
;    (rama SI)
;    (rama TI)
; )
;
; ;;;; Establecemos la relación entre el tema que se pregunta y la rama a la que el
; ;;;; tema hace referencia.
; (deffacts Relaciones
;    (relacion mates CSI)
;    (relacion programar CSI)
;    (relacion programar IS)
;    (relacion bases_de_datos SI)
;    (relacion hardware IC)
;    (relacion docencia CSI)
;    (relacion docencia SI)
;    (relacion web IS)
;    (relacion web TI)
;    (relacion sistemas IC)
;    (relacion sistemas SI)
;    (relacion videojuegos IS)
;    (relacion robotica CSI)
;    (relacion robotica IC)
;    (relacion red TI)
; )
;
; (deffacts Explicaciones
;    (explicacion mates "te gustan las matematicas")
;    (explicacion programar "te gusta programar")
;    (explicacion bases_de_datos "te gustan las bases de datos")
;    (explicacion hardware "te gustan el hardware")
;    (explicacion docencia "te gustan la dodencia")
;    (explicacion web "te gusta la programación web o diseño web")
;    (explicacion sistemas "te gusta la administracion de sistemas")
;    (explicacion videojuegos "te gustan los videoguejos")
;    (explicacion robotica "te gustan los robocs")
;    (explicacion red "te gustan las redes, te contaria un chiste UDP, pero igual no lo pillas")
;    (explicacion por_defecto " no tengo suficiente información para no recomendarte esta rama, puesto que siempre puedes descubrir algo nuevo")
; )
;
; (deffacts Explicacion_consejo
;    (expl_consejo CSI "")
;    (expl_consejo IS "")
;    (expl_consejo IC "")
;    (expl_consejo SI "")
;    (expl_consejo TI "")
; )
;
; ;;;; El sistema hace una serie de preguntas al usuario, para conocer su grado de
; ;;;; en los temas que corresponden a las ramas.
; ;;;; Por cada pregunta, el sistema almacena la informacion que ha
; ;;;; obtenido del usuario de la siguiente manera:
; ;;;; Si ha repondido que le gustan las mates, el sistema registra el hecho
; ;;;; (gusta mates si)
; ;;;; Y si ha respondido que le gusta la regular programar registra
; ;;;;(gusta programar regular)
;
; (defrule Consejo_por_defecto
;    (declare (salience 1000))
;    (rama ?r)
;    =>
;    (assert (consejo ?r por_defecto))
;    (printout t "consejo " ?r " por_defecto" crlf)
; )
;
; (defrule Primera_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gustan las mates? (si/no)" crlf)
;    (assert (gusta mates (read)) (terminar))
; )
;
; (defrule Segunda_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gusta programar? (si/no)" crlf)
;    (assert (gusta programar (read)) (terminar))
; )
;
; (defrule Tercera_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gusta las bases de datos? (si/no)" crlf)
;    (assert (gusta bases_de_datos (read)) (terminar))
; )
;
; (defrule Cuarta_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gusta el hardware? (si/no)" crlf)
;    (assert (gusta hardware (read)) (terminar))
; )
;
; (defrule Quinta_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gusta la docencia? (si/no)" crlf)
;    (assert (gusta docencia (read)) (terminar))
; )
;
; (defrule Sexta_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gusta las informatica relacionada con web? (si/no)" crlf)
;    (assert (gusta web (read)) (terminar))
; )
;
; (defrule Septima_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gusta la administracion de sistemas? (si/no)" crlf)
;    (assert (gusta sistemas (read)) (terminar))
; )
;
; (defrule Octava_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gustan los videojuegos? (si/no)" crlf)
;    (assert (gusta videojuegos (read)) (terminar))
; )
;
; (defrule Novena_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gustan la robotica? (si/no)" crlf)
;    (assert (gusta robotica (read)) (terminar))
; )
;
; (defrule Decima_pregunta
;    (declare (salience 100))
;    (not (terminado si))
;    =>
;    (printout t "Te gustan las redes (internet)? (si/no)" crlf)
;    (assert (gusta red (read)) (terminado si))
; )
;
;
; ;;;; Cada vez que se ha respondido al usuario, el sistema pregunta si ha terminado
; ;;;; y por tanto si quiere recibir una recomendación con la informacion actual.
;
; (defrule Preguntar_Final
;    (declare (salience 100))
;    ?f <- (terminar)
;    =>
;    (printout t "¿Has terminado? (si/no)" crlf)
;    (assert (terminado (read)))
;    (retract ?f)
; )
;
; ;;;; Regla que define cuando se ha terminado de preguntar
;
; (defrule Terminar
;    (declare (salience 100))
;    (terminado si)
;    =>
;    (assert (final))
; )
;
; (defrule Info_obtenida
;    (declare (salience 11))
;    (gusta ?r ?n)
;    =>
;    (printout t "gusta " ?r " " ?n crlf)
; )
;
; (defrule Razonar_gusto_rama
;    (declare (salience 10))
;    (gusta ?r ?n)
;    (relacion ?r ?R)
;    =>
;    (assert (gusta_rama ?r ?R ?n))
;    (printout t "gusta_rama " ?r " " ?R " " ?n crlf)
;
; )
;
; (defrule Razonar_consejo
;    (declare (salience 5))
;    (gusta_rama ?r ?R $? no)
;    ?g <- (consejo ?R $? por_defecto)
;    =>
;    (retract ?g)
;    (assert (consejo ?R no))
;    (printout t "consejo " ?R " no" crlf)
; )
;
; (defrule Razonar_consejo_si
;    (declare (salience 5))
;    (gusta_rama ?r ?R $? si)
;    ?g <- (consejo ?R ?n)
;    (test (neq ?n si))
;    =>
;    (retract ?g)
;    (assert (consejo ?R si))
;    (printout t "consejo " ?R " si" crlf)
; )
;
; (defrule Motivos_consejo_por_defecto
;    (declare (salience 1))
;    ?g <- (consejo ?R por_defecto)
;    ?f <- (expl_consejo ?R ?expl)
;    (explicacion por_defecto ?motivo)
;    =>
;    (bind ?texto (str-cat ?expl ?motivo))
;    (assert (expl_consejo ?R ?texto))
;    (retract ?g ?f)
; )
;
; (defrule Motivos_consejo
;    ?g <- (gusta_rama ?r ?R $? si)
;    (consejo ?R $? si)
;    ?f <- (expl_consejo ?R ?expl)
;    (explicacion ?r ?motivo)
;    =>
;    (bind ?texto (str-cat ?expl ?motivo ", "))
;    (assert (expl_consejo ?R ?texto))
;    (retract ?g ?f)
; )
;
; (defrule Expl_razonada
;    (declare (salience -10))
;    (consejo ?R ?n)
;    (test (or (eq ?n si) (eq ?n por_defecto)))
;    (expl_consejo ?R ?expl)
;    =>
;    (printout t "Te aconsejo " ?R " porque " ?expl " - Manza" crlf)
; )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffacts asignaturas
   (asignatura ALEM)
   (asignatura CA)
   (asignatura FP)
   (asignatura FS)
   (asignatura FFT)
   (asignatura ES)
   (asignatura IES)
   (asignatura LMD)
   (asignatura MP)
   (asignatura TOC)
   (asignatura SCD)
   (asignatura SO)
   (asignatura ED)
   (asignatura EC)
   (asignatura PDOO)
   (asignatura ALG)
   (asignatura AC)
   (asignatura FBD)
   (asignatura FIS)
   (asignatura IA)
)

(deffacts primero
   (primero ALEM)
   (primero CA)
   (primero FP)
   (primero FS)
   (primero FFT)
   (primero ES)
   (primero IES)
   (primero LMD)
   (primero MP)
   (primero TOC)
)

(deffacts matematicas
   (relacion mates ALEM)
   (relacion mates CA)
   (relacion mates FFT)
   (relacion mates ES)
   (relacion mates LMD)
)

(deffacts Programar
   (relacion programar FP)
   (relacion programar MP)
   (relacion programar ED)
   (relacion programar SCD)
   (relacion programar PDOO)
   (relacion programar ALG)
   (relacion programar IA)
)

(deffacts Hardware
   (relacion hardware FFT)
   (relacion hardware TOC)
   (relacion hardware EC)
   (relacion hardware AC)
)

(deffacts Teoricas
   (relacion teoria ALEM)
   (relacion teoria CA)
   (relacion teoria TOC)
   (relacion teoria FFT)
   (relacion teoria IES)
   (relacion teoria LMD)
   (relacion teoria ES)
)

(deffacts Practicas
   (relacion practica FP)
   (relacion practica FS)
   (relacion practica MP)
   (relacion practica SCD)
   (relacion practica PDOO)
   (relacion practica EC)
   (relacion practica SO)
   (relacion practica ED)
   (relacion practica ALG)
   (relacion practica FBD)
   (relacion practica FIS)
   (relacion practica IA)
   (relacion practica AC)
)

(deffunction combinacion (?fc1 ?fc2)
(if (and (> ?fc1 0) (> ?fc2 0) )
   then
      (bind ?rv (- (+ ?fc1 ?fc2) (* ?fc1 ?fc2) ) )
   else
      (if (and (< ?fc1 0) (< ?fc2 0) )
         then
            (bind ?rv (+ (+ ?fc1 ?fc2) (* ?fc1 ?fc2) ) )
         else
            (bind ?rv (/ (+ ?fc1 ?fc2) (- 1 (min (abs ?fc1) (abs ?fc2))) ))))
   ?rv)

(defrule Numero_de_asignaturas
   (declare (salience 1000))
   =>
   (printout t "Dime el numero de creditos: " 60 " max" crlf)
   (assert (n_asig (integer (/ (read) 6 ))) (pedir_asignaturas))
)

(defrule Creditos
   (declare (salience 1000))
   (n_asig ?n)
   (test(<= ?n 10))
   =>
   (printout t "Numero de asignatuas " ?n crlf)
   (assert (contador ?n))
)

(defrule Creditos_exceso
   (declare (salience 1000))
   (n_asig ?n)
   (test(>

       ?n 10))
   =>
   (printout t "NUMERO EXCESIVO DE CREDITOS " crlf)
   (assert (contador 0) (exceso))
)

(defrule Pedir_asignaturas
   (declare (salience 100))
   ?f <- (pedir_asignaturas)
   (contador ?c)
   (test (neq 0 ?c))
   =>
   (retract ?f)
   (printout t "Dime una asignatura que te interese: " crlf)
   (assert (confirmar (read)))
)

(defrule Confirmar_asignatura
   (declare (salience 100))
   ?f <- (confirmar ?n)
   ?cn <- (contador ?c)
   (test (neq 0 ?c))
   (asignatura ?m)
   (test (eq ?m ?n))
   =>
   (retract ?f ?cn)
   (printout t "Te quedan " (- ?c 1) " asignaturas" crlf)
   (assert (interes ?m) (contador (- ?c 1)) (pedir_asignaturas))
)

(defrule Confirmar_asignatura_no_valida
   (declare (salience 100))
   ?f <- (confirmar ?n)
   (contador ?c)
   (test (neq 0 ?c))
   =>
   (retract ?f)
   (printout t "Asignatura no valida" crlf)
   (assert (pedir_asignaturas))
)

(defrule Intereses
   (declare (salience 10))
   (interes ?n)
   =>
   (printout t "Te interesa " ?n crlf)
   (assert (FactorCerteza ?n 0))
)

(defrule Primera_pregunta
   (declare (salience 1))
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gustan las mates? (si/no)" crlf)
   (assert (gusta mates (read)) (terminar))
)

(defrule Segunda_pregunta
   (declare (salience 1))
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta programar? (si/no)" crlf)
   (assert (gusta programar (read)) (terminar))
)

(defrule Tercera_pregunta
   (declare (salience 1))
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta el hardware? (si/no)" crlf)
   (assert (gusta hardware (read)) (terminar))
)

(defrule Cuarta_pregunta
   (declare (salience 1))
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta la teoria? (si/no)" crlf)
   (assert (gusta teoria (read)) (terminar))
)

(defrule Quinta_pregunta
   (declare (salience 1))
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta la practica? (si/no)" crlf)
   (assert (gusta practica (read)) (terminado si))
)

(defrule Terminar
   (declare (salience 2))
   ?f <- (terminar)
   (not (exceso))
   =>
   (printout t "¿Has terminado? (si/no)" crlf)
   (assert (terminado (read)))
   (retract ?f)
)

; (defrule Info_obtenida
;    (gusta ?r ?n)
;    =>
;    (printout t "gusta " ?r " " ?n crlf)
; )

(defrule Razonar_gusto
   ; (declare (salience 10))
   (gusta ?r si)
   (relacion ?r ?a)
   (interes ?a)
   =>
   (assert (gusta_tipo ?r ?a))
   ; (printout t "gusta_tipo " ?r " " ?a crlf)
)

(defrule Certeza_mates
   ?g <- (gusta_tipo mates ?a)
   ?fc <- (FactorCerteza ?a ?f)
   =>
   (retract ?fc ?g)
   (assert (FactorCerteza ?a (combinacion ?f 0.75)))
)

(defrule Certeza_programar
   ?g <- (gusta_tipo programar ?a)
   ?fc <- (FactorCerteza ?a ?f)
   =>
   (retract ?fc ?g)
   (assert (FactorCerteza ?a (combinacion ?f 0.65)))
)

(defrule Certeza_hardware
   ?g <- (gusta_tipo hardware ?a)
   ?fc <- (FactorCerteza ?a ?f)
   =>
   (retract ?fc ?g)
   (assert (FactorCerteza ?a (combinacion ?f 0.8)))
)

(defrule Certeza_teoria
   ?g <- (gusta_tipo teoria ?a)
   ?fc <- (FactorCerteza ?a ?f)
   =>
   (retract ?fc ?g)
   (assert (FactorCerteza ?a (combinacion ?f 0.65)))
)

(defrule Certeza_practica
   ?g <- (gusta_tipo practica ?a)
   ?fc <- (FactorCerteza ?a ?f)
   =>
   (retract ?fc ?g)
   (assert (FactorCerteza ?a (combinacion ?f 0.35)))
)
(defrule Certeza_primero
   ?g <- (primero ?a)
   ?fc <- (FactorCerteza ?a ?f)
   =>
   (retract ?fc ?g)
   (assert (FactorCerteza ?a (combinacion ?f 0.5)))
)

(defrule Factores_certeza
   (declare (salience -100))
   (FactorCerteza ?r ?n)
   =>
   (printout t "Factor de certeza de " ?r " es " ?n crlf)
)
