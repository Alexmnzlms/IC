(deffunction encadenado (?fc_antecedente ?fc_regla)
   (if (> ?fc_antecedente 0)
      then
         (bind ?rv (* ?fc_antecedente ?fc_regla))
      else
         (bind ?rv 0))
   ?rv)

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

;; convertimos cada evidencia en una afirmación sobre su factor de certeza
(defrule certeza_evidencias
   (Evidencia ?e ?r)
   =>
   (assert(FactorCerteza ?e ?r 1))
)

;; También podríamos considerar evidencias con una cierta
;;incertidumbre: al preguntar por la evidencia, pedir y recoger
;;directamente el grado de certez

;R1: SI el motor obtiene gasolina Y el motor gira ENTONCES problemas
; con las bujías con certeza 0,7
(defrule R1
   (FactorCerteza motor_llega_gasolina si ?f1)
   (FactorCerteza gira_motor si ?f2)
   (test (and (> ?f1 0) (> ?f2 0)))
   =>
   (assert(FartorCerteza problema_bujias si (encadenado (* ?f1 ?f2) 0,7)))
)

;;;;;;  Combinar misma deduccion por distintos caminos
(defrule combinar
   (declare (salience 1))
   ?f <-(FactorCerteza ?h ?r ?fc1)
   ?g <-(FactorCerteza ?h ?r ?fc2)
   (test (neq ?fc1 ?fc2))
   =>
   (retract ?f ?g)
   (assert(FactorCerteza ?h ?r (combinacion ?fc1 ?fc2)))
)



(defrule combinar_signo
   (declare (salience 2))
   (FactorCerteza ?h si ?fc1)
   (FactorCerteza ?h no ?fc2)
   =>
   (assert(Certeza ?h  (- ?fc1 ?fc2)))
)
