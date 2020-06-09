(defrule elegir_modulo
   (declare (salience 10000))
   =>
   (printout t "Sobre que necesitas consejor: [rama/asig]" crlf)
   (assert (modulo (read)))
)

;;;; Representamos las posibles ramas a recomendar.
(deffacts Ramas
   (rama CSI)
   (rama IS)
   (rama IC)
   (rama SI)
   (rama TI)
)

;;;; Establecemos la relación entre el tema que se pregunta y la rama a la que el
;;;; tema hace referencia.
(deffacts Relaciones
   (relacion mates CSI)
   (relacion programar CSI)
   (relacion programar IS)
   (relacion bases_de_datos SI)
   (relacion hardware IC)
   (relacion docencia CSI)
   (relacion docencia SI)
   (relacion web IS)
   (relacion web TI)
   (relacion sistemas IC)
   (relacion sistemas SI)
   (relacion videojuegos IS)
   (relacion robotica CSI)
   (relacion robotica IC)
   (relacion red TI)
)

(deffacts Explicaciones
   (explicacion mates "te gustan las matematicas")
   (explicacion programar "te gusta programar")
   (explicacion bases_de_datos "te gustan las bases de datos")
   (explicacion hardware "te gusta el hardware")
   (explicacion docencia "te gusta la docencia")
   (explicacion web "te gusta la programación web o diseño web")
   (explicacion sistemas "te gusta la administracion de sistemas")
   (explicacion videojuegos "te gustan los videojuegos")
   (explicacion robotica "te gustan la robotica")
   (explicacion red "te gustan las redes")
   (explicacion por_defecto "no tengo suficiente información para no recomendarte esta rama, puesto que siempre puedes descubrir algo nuevo")
)

(deffacts Explicacion_consejo
   (expl_consejo CSI "")
   (expl_consejo IS "")
   (expl_consejo IC "")
   (expl_consejo SI "")
   (expl_consejo TI "")
)

;;;; El sistema hace una serie de preguntas al usuario, para conocer su grado de
;;;; en los temas que corresponden a las ramas.
;;;; Por cada pregunta, el sistema almacena la informacion que ha
;;;; obtenido del usuario de la siguiente manera:
;;;; Si ha repondido que le gustan las mates, el sistema registra el hecho
;;;; (gusta mates si)
;;;; Y si ha respondido que le gusta la regular programar registra
;;;;(gusta programar regular)

(defrule Consejo_por_defecto
   (declare (salience 1000))
   (modulo rama)
   (rama ?r)
   =>
   (assert (consejo ?r por_defecto))
   ; (printout t "consejo " ?r " por_defecto" crlf)
)

(defrule Primera_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gustan las mates? (si/no)" crlf)
   (assert (gusta mates (read)) (terminar))
)

(defrule Segunda_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gusta programar? (si/no)" crlf)
   (assert (gusta programar (read)) (terminar))
)

(defrule Tercera_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gusta las bases de datos? (si/no)" crlf)
   (assert (gusta bases_de_datos (read)) (terminar))
)

(defrule Cuarta_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gusta el hardware? (si/no)" crlf)
   (assert (gusta hardware (read)) (terminar))
)

(defrule Quinta_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gusta la docencia? (si/no)" crlf)
   (assert (gusta docencia (read)) (terminar))
)

(defrule Sexta_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gusta las informatica relacionada con web? (si/no)" crlf)
   (assert (gusta web (read)) (terminar))
)

(defrule Septima_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gusta la administracion de sistemas? (si/no)" crlf)
   (assert (gusta sistemas (read)) (terminar))
)

(defrule Octava_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gustan los videojuegos? (si/no)" crlf)
   (assert (gusta videojuegos (read)) (terminar))
)

(defrule Novena_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gustan la robotica? (si/no)" crlf)
   (assert (gusta robotica (read)) (terminar))
)

(defrule Decima_pregunta
   (declare (salience 100))
   (modulo rama)
   (not (terminado si))
   =>
   (printout t "Te gustan las redes (internet)? (si/no)" crlf)
   (assert (gusta red (read)) (terminado si))
)


;;;; Cada vez que se ha respondido al usuario, el sistema pregunta si ha terminado
;;;; y por tanto si quiere recibir una recomendación con la informacion actual.

(defrule Preguntar_Final
   (declare (salience 100))
   (modulo rama)
   ?f <- (terminar)
   =>
   (printout t "¿Has terminado? (si/no)" crlf)
   (assert (terminado (read)))
   (retract ?f)
)

;;;; Regla que define cuando se ha terminado de preguntar

(defrule Terminar
   (declare (salience 100))
   (modulo rama)
   (terminado si)
   =>
   (assert (final))
)

(defrule Info_obtenida
   (declare (salience 11))
   (modulo rama)
   (gusta ?r ?n)
   =>
   ; (printout t "gusta " ?r " " ?n crlf)
)

(defrule Razonar_gusto_rama
   (declare (salience 10))
   (modulo rama)
   (gusta ?r ?n)
   (relacion ?r ?R)
   =>
   (assert (gusta_rama ?r ?R ?n))
   ; (printout t "gusta_rama " ?r " " ?R " " ?n crlf)

)

(defrule Razonar_consejo
   (declare (salience 5))
   (modulo rama)
   (gusta_rama ?r ?R $? no)
   ?g <- (consejo ?R $? por_defecto)
   =>
   (retract ?g)
   (assert (consejo ?R no))
   ; (printout t "consejo " ?R " no" crlf)
)

(defrule Razonar_consejo_si
   (declare (salience 5))
   (modulo rama)
   (gusta_rama ?r ?R $? si)
   ?g <- (consejo ?R ?n)
   (test (neq ?n si))
   =>
   (retract ?g)
   (assert (consejo ?R si))
   ; (printout t "consejo " ?R " si" crlf)
)

(defrule Motivos_consejo_por_defecto
   (declare (salience 1))
   (modulo rama)
   (consejo ?R por_defecto)
   ?f <- (expl_consejo ?R ?expl)
   (explicacion por_defecto ?motivo)
   (not (defecto ?R))
   =>
   (bind ?texto (str-cat ?expl ?motivo))
   (assert (expl_consejo ?R ?texto) (defecto ?R))
   (retract ?f)
)

(defrule Motivos_consejo
   (modulo rama)
   ?g <- (gusta_rama ?r ?R $? si)
   (consejo ?R $? si)
   ?f <- (expl_consejo ?R ?expl)
   (explicacion ?r ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (expl_consejo ?R ?texto))
   (retract ?g ?f)
)

(defrule Expl_razonada
   (declare (salience -10))
   (modulo rama)
   (consejo ?R ?n)
   (test (or (eq ?n si) (eq ?n por_defecto)))
   (expl_consejo ?R ?expl)
   =>
   (printout t "Te aconsejo " ?R " porque " ?expl " - Manza" crlf)
)

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

(deffacts nombres
   (nombre ALEM "Algebra Lineal y Estructuras Matematicas")
   (nombre CA "Calculo")
   (nombre FP "Fundamentos de la Programación")
   (nombre FS "Fundamentos del Software")
   (nombre FFT "Fundamentos Fisicos y Tecnologicos")
   (nombre ES "Estadistica")
   (nombre IES "Ingeniería Empresa y Sociedad")
   (nombre LMD "Logica y Metodos Discretos")
   (nombre MP "Metodologia de la Programación")
   (nombre TOC "Tecnologia y Organizacion de Computadores")
   (nombre SCD "Sistemas Concurrentes y Distribuidos")
   (nombre SO "Sistemas Operativos")
   (nombre ED "Estructura de Datos")
   (nombre EC "Estructura de Computadores")
   (nombre PDOO "Programación y Diseño Orientado a Objetos")
   (nombre ALG "Algoritmica")
   (nombre AC "Arquitectura de Computadores")
   (nombre FBD "Fundamentos de Bases de Datos")
   (nombre FIS "Fundamentos de la Ingeniería del Software")
   (nombre IA "Inteligencia Artificial")
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

(deffacts software
   (relacion desarrollo FIS)
   (relacion desarrollo PDOO)
   (relacion desarrollo SO)
   (relacion desarrollo SCD)
   (relacion desarrollo FBD)
)

(deffacts Explicaciones_asig
   (explicacion mates "te gustan las matematicas")
   (explicacion programar "te gusta programar")
   (explicacion hardware "te gustan el hardware")
   (explicacion software "te gustan el desarrollo software")
   (explicacion teoria "te gusta mas la teoria que la practica")
   (explicacion practica "te gusta mas la practica que la teoria")
   (explicacion primero "esta asignatura es de primero y por tanto conviene hacerla")
)

(deffacts Explicacion_consejo_asig
   (expl_consejo ALEM "")
   (expl_consejo CA "")
   (expl_consejo FP "")
   (expl_consejo FS "")
   (expl_consejo FFT "")
   (expl_consejo ES "")
   (expl_consejo IES "")
   (expl_consejo LMD "")
   (expl_consejo MP "")
   (expl_consejo TOC "")
   (expl_consejo SCD "")
   (expl_consejo SO "")
   (expl_consejo ED "")
   (expl_consejo EC "")
   (expl_consejo PDOO "")
   (expl_consejo ALG "")
   (expl_consejo AC "")
   (expl_consejo FBD "")
   (expl_consejo FIS "")
   (expl_consejo IA "")
)

(deffacts maximo
   (maximo_necesario)
)

(deftemplate FactorCerteza (slot asig) (slot certeza) )

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

(defrule Cod_asig
   (declare (salience 1001))
   (modulo asig)
   (nombre ?n ?N)
   =>
   (printout t "Puedes elegir: " ?n " - " ?N crlf)

)

(defrule Numero_de_asignaturas
   (declare (salience 1000))
   (modulo asig)
   =>
   (printout t "Dime el numero de creditos: " 30 " max" crlf)
   (assert (n_asig (integer (/ (read) 6 ))) (pedir_asignaturas))
)

(defrule Creditos
   (declare (salience 1000))
   (modulo asig)
   (n_asig ?n)
   (test(<= ?n 5))
   =>
   (printout t "Ahora dime asignaturas que te interesen" crlf)
   (printout t "Minimo número de asignaturas: " ?n crlf)
   (assert (contador 1))
)

(defrule Creditos_exceso
   (declare (salience 1000))
   (modulo asig)
   (n_asig ?n)
   (test(> ?n 5))
   =>
   (printout t "NUMERO EXCESIVO DE CREDITOS " crlf)
   (assert (exceso))
)

(defrule Pedir_asignaturas
   (declare (salience 100))
   (modulo asig)
   (not (exceso))
   (not (terminado_asig si))
   ?f <- (pedir_asignaturas)
   =>
   (retract ?f)
   (printout t "Dime una asignatura que te interese: " crlf)
   (assert (confirmar (read)))
)

(defrule Confirmar_asignatura
   (declare (salience 100))
   (modulo asig)
   ?f <- (confirmar ?n)
   ?cn <- (contador ?c)
   (n_asig ?max)
   (test (< ?c ?max))
   (asignatura ?n)
   =>
   (retract ?f ?cn)
   (printout t "Llevas " ?c " asignaturas" crlf)
   (assert (interes ?n) (contador (+ ?c 1)) (pedir_asignaturas))
)

(defrule Confirmar_asignatura_no_valida
   (declare (salience 100))
   (modulo asig)
   ?f <- (confirmar ?n)
   (contador ?c)
   (n_asig ?max)
   (test (< ?c ?max))
   =>
   (retract ?f)
   (printout t "Asignatura no valida" crlf)
   (assert (pedir_asignaturas))
)

(defrule Confirmar_asignatura_max
   (declare (salience 100))
   (modulo asig)
   ?f <- (confirmar ?n)
   ?cn <- (contador ?c)
   (n_asig ?max)
   (test (>= ?c ?max))
   (test (< ?c 10))
   (asignatura ?n)
   =>
   (retract ?f ?cn)
   (printout t "Llevas " ?c " asignaturas [de max " 10 "]" crlf)
   (assert (interes ?n) (contador (+ ?c 1)) (terminar_asig))
)

(defrule Confirmar_asignatura_no_valida_max
   (declare (salience 100))
   (modulo asig)
   ?f <- (confirmar ?n)
   (contador ?c)
   (n_asig ?max)
   (test (>= ?c ?max))
   (test (< ?c 10))
   =>
   (retract ?f)
   (printout t "Asignatura no valida" crlf)
   (assert (terminar_asig))
)

(defrule Terminar_asig_max
   (declare (salience 2))
   (modulo asig)
   ?f <- (terminar_asig)
   (not (exceso))
   =>
   (printout t "¿Has terminado? (si/no)" crlf)
   (assert (terminado_asig (read)) (pedir_asignaturas))
   (retract ?f)
)

(defrule Intereses
   (declare (salience 10))
   (modulo asig)
   (interes ?n)
   =>
   (printout t "Te interesa " ?n crlf)
   (assert (FactorCerteza (asig ?n) (certeza 0)))
)

(defrule Primera_pregunta_asig
   (declare (salience 1))
   (modulo asig)
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gustan las mates? (si/no)" crlf)
   (assert (gusta mates (read)) (terminar))
)

(defrule Segunda_pregunta_asig
   (declare (salience 1))
   (modulo asig)
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta programar? (si/no)" crlf)
   (assert (gusta programar (read)) (terminar))
)

(defrule Tercera_pregunta_asig
   (declare (salience 1))
   (modulo asig)
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta el hardware? (si/no)" crlf)
   (assert (gusta hardware (read)) (terminar))
)

(defrule Cuarta_pregunta_asig
   (declare (salience 1))
   (modulo asig)
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta el software? (si/no)" crlf)
   (assert (gusta software (read)) (terminar))
)

(defrule Quinta_pregunta_asig
   (declare (salience 1))
   (modulo asig)
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta la teoria? (si/no)" crlf)
   (assert (gusta teoria (read)) (terminar))
)

(defrule Sexta_pregunta_asig
   (declare (salience 1))
   (modulo asig)
   (not (exceso))
   (not (terminado si))
   =>
   (printout t "Te gusta la practica? (si/no)" crlf)
   (assert (gusta practica (read)) (terminado si))
)

(defrule Terminar_asig
   (declare (salience 2))
   (modulo asig)
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
   (modulo asig)
   (gusta ?r si)
   (relacion ?r ?a)
   (interes ?a)
   =>
   (assert (gusta_tipo ?r ?a))
   ; (printout t "gusta_tipo " ?r " " ?a crlf)
)

(defrule Certeza_mates
   (modulo asig)
   ?g <- (gusta_tipo mates ?a)
   ?fc <- (FactorCerteza (asig ?a) (certeza ?f))
   ?e <- (expl_consejo ?a ?expl)
   (explicacion mates ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (FactorCerteza (asig ?a) (certeza (combinacion ?f 0.75))) (expl_consejo ?a ?texto))
   (retract ?fc ?g ?e)
)

(defrule Certeza_programar
   (modulo asig)
   ?g <- (gusta_tipo programar ?a)
   ?fc <- (FactorCerteza (asig ?a) (certeza ?f))
   ?e <- (expl_consejo ?a ?expl)
   (explicacion programar ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (FactorCerteza (asig ?a) (certeza (combinacion ?f 0.65))) (expl_consejo ?a ?texto))
   (retract ?fc ?g ?e)
)

(defrule Certeza_hardware
   (modulo asig)
   ?g <- (gusta_tipo hardware ?a)
   ?fc <- (FactorCerteza (asig ?a) (certeza ?f))
   ?e <- (expl_consejo ?a ?expl)
   (explicacion hardware ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (FactorCerteza (asig ?a) (certeza (combinacion ?f 0.8))) (expl_consejo ?a ?texto))
   (retract ?fc ?g ?e)
)

(defrule Certeza_teoria
   (modulo asig)
   ?g <- (gusta_tipo teoria ?a)
   ?fc <- (FactorCerteza (asig ?a) (certeza ?f))
   ?e <- (expl_consejo ?a ?expl)
   (explicacion teoria ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (FactorCerteza (asig ?a) (certeza (combinacion ?f 0.65))) (expl_consejo ?a ?texto))
   (retract ?fc ?g ?e)
)

(defrule Certeza_practica
   (modulo asig)
   ?g <- (gusta_tipo practica ?a)
   ?fc <- (FactorCerteza (asig ?a) (certeza ?f))
   ?e <- (expl_consejo ?a ?expl)
   (explicacion practica ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (FactorCerteza (asig ?a) (certeza (combinacion ?f 0.35))) (expl_consejo ?a ?texto))
   (retract ?fc ?g ?e)
)

(defrule Certeza_primero
   (modulo asig)
   ?g <- (primero ?a)
   ?fc <- (FactorCerteza (asig ?a) (certeza ?f))
   ?e <- (expl_consejo ?a ?expl)
   (explicacion primero ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (FactorCerteza (asig ?a) (certeza (combinacion ?f 0.5))) (expl_consejo ?a ?texto))
   (retract ?fc ?g ?e)
)

(defrule Certeza_software
   (modulo asig)
   ?g <- (gusta_tipo software ?a)
   ?fc <- (FactorCerteza (asig ?a) (certeza ?f))
   ?e <- (expl_consejo ?a ?expl)
   (explicacion software ?motivo)
   =>
   (bind ?texto (str-cat ?expl ?motivo ", "))
   (assert (FactorCerteza (asig ?a) (certeza (combinacion ?f 0.8))) (expl_consejo ?a ?texto))
   (retract ?fc ?g ?e)
)

; (defrule Factores_certeza
;    (declare (salience -90))
;    (modulo asig)
;    (FactorCerteza (asig ?r) (certeza ?n))
;    =>
;    (printout t "Factor de certeza de " ?r " es " ?n crlf)
; )

(defrule Contador_maximo
   (declare (salience 1000))
   (modulo asig)
   (n_asig ?n)
   (not (contador_max))
   =>
   (assert (cont_asig ?n) (contador_max))
)

(defrule Factor_maximo
   (declare (salience -1))
   ?max <- (maximo_necesario)
   ?f <- (FactorCerteza (asig ?r) (certeza ?n))
   (not (FactorCerteza (certeza ?value2&:(> ?value2 ?n))))
   =>
   (assert (maximo ?r ?n))
   ; (printout t "maximo " ?r " " ?n crlf)
   (retract ?max ?f)
)


(defrule Factores_certeza_muy_seguro
   (declare (salience -100))
   (modulo asig)
   ?cn <- (cont_asig ?c)
   ?f <- (maximo ?r ?n)
   (test (>= ?n 0.8))
   (expl_consejo ?r ?expl)
   (test (> ?c 0))
   =>
   (printout t "Te recomiendo muchisimo " ?r " porque " ?expl " - Manza" crlf)
   (assert (cont_asig (- ?c 1)) (maximo_necesario))
   (retract ?f ?cn)
)

(defrule Factores_certeza_seguro
   (declare (salience -100))
   (modulo asig)
   ?cn <- (cont_asig ?c)
   ?f <- (maximo ?r ?n)
   (test (>= ?n 0.5))
   (expl_consejo ?r ?expl)
   (test (> ?c 0))
   =>
   (printout t "Te aconsejo " ?r " porque " ?expl " - Manza" crlf)
   (assert (cont_asig (- ?c 1)) (maximo_necesario))
   (retract ?f ?cn)
)

(defrule Factores_certeza_no_seguro
   (declare (salience -100))
   (modulo asig)
   ?cn <- (cont_asig ?c)
   ?f <- (maximo ?r ?n)
   (test (< ?n 0.5))
   (test (> ?c 0))
   =>
   (printout t "No te aconsejo " ?r " - Manza" crlf)
   (assert (cont_asig (- ?c 1)) (maximo_necesario))
   (retract ?f ?cn)
)
