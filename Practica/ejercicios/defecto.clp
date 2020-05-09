;; Autor: Alejandro Manzanares Lemus

;;;;;;;;;;;;;;;;;;Representación ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (ave ?x) representa “?x es un ave ”
; (animal ?x) representa “?x es un animal”
; (vuela ?x si|no seguro|por_defecto) representa
;“?x vuela si|no con esa certeza”

;Las aves y los mamíferos son animales
;Los gorriones, las palomas, las águilas y los pingüinos son aves
;La vaca, los perros y los caballos son mamíferos
;Los pingüinos no vuelan

(deffacts datos
   (ave gorrion)
   (ave paloma)
   (ave aguila)
   (ave pinguino)
   (mamifero vaca)
   (mamifero perro)
   (mamifero caballo)
   (vuela pinguino no seguro)
)

; Las aves son animales
(defrule aves_son_animales
   (ave ?x)
   =>
   (assert (animal ?x))
   (bind ?expl (str-cat "sabemos que un " ?x " es un animal porque las aves son
   un tipo de animal"))
   (assert (explicacion animal ?x ?expl))
)
; añadimos un hecho que contiene la explicación de la deducción

; Los mamiferos son animales (A3)
(defrule mamiferos_son_animales
   (mamifero ?x)
   =>
   (assert (animal ?x))
   (bind ?expl (str-cat "sabemos que un " ?x " es un animal porque los
   mamiferos son un tipo de animal"))
   (assert (explicacion animal ?x ?expl))
)
; añadimos un hecho que contiene la explicación de la deducción

;;; Casi todos las aves vuela --> puedo asumir por defecto que las aves vuelan
; Asumimos por defecto
(defrule ave_vuela_por_defecto
   (declare (salience -1)) ; para disminuir probabilidad de añadir erróneamente
   (ave ?x)
   =>
   (assert (vuela ?x si por_defecto))
   (bind ?expl (str-cat "asumo que un " ?x " vuela, porque casi todas las aves
   vuelan"))
   (assert (explicacion vuela ?x ?expl))
)

; Retractamos cuando hay algo en contra
(defrule retracta_vuela_por_defecto
   (declare (salience 1))
   ; para retractar antes de inferir cosas erroneamente
   ?f<- (vuela ?x ?r por_defecto)
   (vuela ?x ?s seguro)
   =>
   (retract ?f)
   (bind ?expl (str-cat "retractamos que un " ?x " " ?r " vuela por defecto, porque
   sabemos seguro que " ?x " " ?s " vuela"))
   (assert (explicacion vuela ?x ?expl))
)
;;; COMETARIO: esta regla también elimina los por defecto cuando ya esta seguro

;;; La mayor parte de los animales no vuelan --> puede interesarme asumir por defecto
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;que un animal no va a volar
(defrule mayor_parte_animales_no_vuelan
   (declare (salience -2)) ;;;; es mas arriesgado, mejor después de otros razonamientos
   (animal ?x)
   (not (vuela ?x ? ?))
   =>
   (assert (vuela ?x no por_defecto))
   (bind ?expl (str-cat "asumo que " ?x " no vuela, porque la mayor parte de los animales no vuelan"))
   (assert (explicacion vuela ?x ?expl))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Preguntamos por el animal
(defrule pregunta
   =>
   (printout t "¿Por qué animal estas interesado?" crlf)
   (assert (pregunta (read)))
)

; No conocemos el animal por el que se pregunta
(defrule no_se_de_que_animal_hablas
   (declare (salience -3))
   ?f <- (pregunta ?x)
   (not (or (mamifero ?x) (ave ?x)))
   =>
   (printout t "No se que es un " ?x " ¿es mamífero o ave?" crlf)
   (assert (respuesta ?x (read)))
   (retract ?f)
)

; Guardamos que el animal es un mamifero
(defrule guardamos_respuesta_mamifero
   (declare (salience -3))
   ?f <- (respuesta ?x mamifero)
   =>
   (assert (mamifero ?x) (pregunta ?x))
   (retract ?f)
)

; Guardamos que el animal es un ave
(defrule guardamos_respuesta_ave
   (declare (salience -3))
   ?f <- (respuesta ?x ave)
   =>
   (assert (ave ?x) (pregunta ?x))
   (retract ?f)
)

; No sabemos si el animal es mamifero o ave
(defrule descartamos_respuesta_desconocido
   (declare (salience -3))
   ?f <- (respuesta ?x ?r)
   (not (eq ?r mamifero))
   (not (eq ?r ave))
   =>
   (assert (animal ?x) (pregunta ?x))
   (retract ?f)
)

; Has preguntado por un mamifero
(defrule preguntas_por_mamifero
   (declare (salience -3))
   ?f <- (pregunta ?x)
   (mamifero ?x)
   (explicacion vuela ?x ?expl)
   =>
   (printout t ?x " es un mamifero y " ?expl crlf)
   (assert (correcto ?x))
   (retract ?f)
)

; Has preguntado por un ave
(defrule preguntas_por_ave
   (declare (salience -3))
   ?f <- (pregunta ?x)
   (ave ?x)
   (explicacion vuela ?x ?expl)
   =>
   (printout t ?x " es un ave y " ?expl crlf)
   (assert (correcto ?x))
   (retract ?f)
)

; Has preguntado por un animal
(defrule preguntas_por_desconocido
   (declare (salience -3))
   ?f <- (pregunta ?x)
   (animal ?x)
   (not (ave ?x))
   (not (mamifero ?x))
   (explicacion vuela ?x ?expl)
   =>
   (printout t ?x " es un animal y " ?expl crlf)
   (assert (correcto ?x))
   (retract ?f)
)
