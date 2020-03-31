
;;;; HECHOS GENERALES DEL SISTEMA ;;;;;
;;;;(seran v�lidos para todas las ejecuciones del sistema ;;;;

; Listado de personas de la familia en cuestion introducidas con la propiedad unaria de hombre o mujer

(deffacts personas
   (hombre Antonio) ; "Antonio es un hombre"
   (hombre Luis)
   (hombre Juan)
   (hombre Pepito)
   (hombre JoseEmilio)
   (hombre Jose)
   (hombre Juanito)
   (hombre Pablo)
   (hombre Alvaro)
   (hombre JuanFrancisco)
   (mujer Laura)         ; Laura es una mujer
   (mujer Julia)
   (mujer Rosalia)
   (mujer Rosa)
   (mujer Rosalia)
   (mujer Mercedes)
   (mujer Lidia)
   (mujer Carmen) )

;;;;; Plantilla t�pica de Relaciones binarias, ajustada a relaciones de parentesco restringiendo los valores de tipo de relacion a estas. Se usa para registrar "El <sujeto> es <tipo de relacion> de <objeto>", por ejemplo "Juan es TIO de Julia"

(deftemplate Relacion
  (slot tipo (type SYMBOL) (allowed-symbols HIJO PADRE ABUELO NIETO HERMANO ESPOSO PRIMO TIO SOBRINO  CUNIADO YERNO SUEGRO))
  (slot sujeto)
  (slot objeto))

;;;;; Datos de la relacion HIJO y ESPOSO en mi familia que es suficiente para el problema, pues el resto se deduce de estas

(deffacts relaciones
   (Relacion (tipo HIJO) (sujeto Luis) (objeto Antonio)) ; "Luis es HIJO de Antonio
   (Relacion (tipo HIJO) (sujeto Julia) (objeto Antonio))
   (Relacion (tipo HIJO) (sujeto Antonio) (objeto Jose))
   (Relacion (tipo HIJO) (sujeto Pepito) (objeto Jose))
   (Relacion (tipo HIJO) (sujeto Laura) (objeto JuanFrancisco))
   (Relacion (tipo HIJO) (sujeto Juan) (objeto JuanFrancisco))
   (Relacion (tipo HIJO) (sujeto Juanito) (objeto Juan))
   (Relacion (tipo HIJO) (sujeto Pablo) (objeto Juan))
   (Relacion (tipo HIJO) (sujeto Alvaro) (objeto Juan))
   (Relacion (tipo HIJO) (sujeto Lidia) (objeto Pepito))
   (Relacion (tipo HIJO) (sujeto JoseEmilio) (objeto Pepito))
   (Relacion (tipo ESPOSO) (sujeto Antonio) (objeto Laura)) ; "Antonio es ESPOSO de Laura"
   (Relacion (tipo ESPOSO) (sujeto Juan) (objeto Carmen))
   (Relacion (tipo ESPOSO) (sujeto JuanFrancisco) (objeto Rosalia))
   (Relacion (tipo ESPOSO) (sujeto Jose) (objeto Mercedes))
   (Relacion (tipo ESPOSO) (sujeto Pepito) (objeto Rosa)))

;;;;;;; Cada relacion tiene una relacion dual que se produce al cambiar entre si objeto y sujeto. Por ejejmplo, Si x es HIJO de y, y es PADRE de x". Para poder deducirlo con una sola regla metemos esa informacion como hechos con la etiqueta dual, "Dual de HIJO PADRE", y asi con todas las relaciones consideradas

(deffacts duales
(dual HIJO PADRE) (dual ABUELO NIETO) (dual HERMANO HERMANO) (dual ESPOSO ESPOSO) (dual PRIMO PRIMO) (dual TIO SOBRINO) (dual CUNIADO CUNIADO) (dual YERNO SUEGRO))

;;;;;; Para deducir las reglas que se aplican son de composicion, del tipo "el HERMANO del PADRE es un TIO". Por comodidad, en lugar de crear una regla por cada posible composici�n, metemos como hechos la relacion que se obtiene por composicion. Solo metemos unas cuantas composiciones que sean suficientes para deducir cualquier cosa

(deffacts compuestos
(comp HIJO HIJO NIETO) (comp PADRE PADRE ABUELO) (comp ESPOSO PADRE PADRE)(comp HERMANO PADRE TIO) (comp HERMANO ESPOSO CUNIADO) (comp ESPOSO HIJO YERNO) (comp ESPOSO HERMANO CUNIADO) (comp HIJO PADRE HERMANO) (comp ESPOSO CUNIADO CUNIADO) (comp ESPOSO TIO TIO)  (comp HIJO TIO PRIMO)  )


;;;;;; Para que cuando digamos por pantalla el parentesco lo espresemos correctamente, y puesto que el nombre que hemos puesto a cada relacion es el caso masculino, vamos a meter como hechos como se diaria esa relacion en femenino mediante la etiqueta femenino

(deffacts femenino
(femenino HIJO HIJA) (femenino PADRE MADRE) (femenino ABUELO ABUELA) (femenino NIETO NIETA) (femenino HERMANO HERMANA) (femenino ESPOSO ESPOSA) (femenino PRIMO PRIMA) (femenino TIO TIA) (femenino SOBRINO SOBRINA) (femenino CUNIADO CUNIADA) (femenino YERNO NUERA) (femenino SUEGRO SUEGRA))


;;;;; REGLAS DEL SISTEMA ;;;;;

;;;; La dualidad es simetrica: si r es dual de t, t es dual de r. Por eso solo metimos como hecho la dualidad en un sentidos, pues en el otro lo podiamos deducir con esta regla

(defrule autodualidad
      (razonar)
      (dual ?r ?t)
=>
   (assert (dual ?t ?r)))


;;;; Si  x es R de y, entonces y es dualdeR de x

(defrule dualidad
   (razonar)
   (Relacion (tipo ?r) (sujeto ?x) (objeto ?y))
   (dual ?r ?t)
=>
   (assert (Relacion (tipo ?t) (sujeto ?y) (objeto ?x))))


;;;; Si  y es R de x, y x es T de z entonces y es RoT de z
;;;; a�adimos que z e y sean distintos para evitar que uno resulte hermano de si mismo y cosas asi.

(defrule composicion
   (razonar)
   (Relacion (tipo ?r) (sujeto ?y) (objeto ?x))
   (Relacion (tipo ?t) (sujeto ?x) (objeto ?z))
   (comp ?r ?t ?u)
   (test (neq ?y ?z))
=>
   (assert (Relacion (tipo ?u) (sujeto ?y) (objeto ?z))))

;;;;; Como puede deducir que tu hermano es tu cu�ado al ser el esposo de tu cu�ada, eliminamos los cu�ados que sean hermanos

(defrule limpiacuniados
    (Relacion (tipo HERMANO) (sujeto ?x) (objeto ?y))
    ?f <- (Relacion (tipo CUNIADO) (sujeto ?x) (objeto ?y))
=>
	(retract ?f) )

;;;;; Solicitamos el nombre de la primera persona sobre el que se desea informacion y guardamos y a�adimos ese hecho

(defrule pregunta
=>
   (printout t "Dime el nombre de la primera persona de la Familia Castro sobre la que quieres informaci�n (escribe solo el nombre): " crlf)
   (assert (primerapersona (read))))

   ;;;;; Solicitamos el nombre de la segunda persona

(defrule pregunta2
(primerapersona ?primero)
=>
   (printout t "Dime el nombre de la persona de la Familia Castro de la que quieres saber su relacion con " ?primero " (escribe solo el nombre): " crlf)
   (assert (segundapersona (read)))
   (assert (razonar))  )

;;;;; Hacemos que nos diga por pantalla la relacion entre las persona introducidas. Como la forma de expresarlo dependera del sexo, usamos dos reglas, una para cada sexo

(defrule relacionmasculino
   ?f <- (razonar)
   (primerapersona ?x)
   (segundapersona ?y)
   (Relacion (tipo ?r) (sujeto ?y) (objeto ?x))
   (hombre ?y)
 =>
   (printout t ?y " es " ?r " de " ?x crlf)
   (retract ?f)   )

(defrule relacionfemenino
    ?f <- (razonar)
   (primerapersona ?x)
   (segundapersona ?y)
   (Relacion (tipo ?r) (sujeto ?y) (objeto ?x))
   (mujer ?y)
   (femenino ?r ?t)
 =>
   (printout t ?y " es " ?t " de " ?x crlf)
   (retract ?f)    )
