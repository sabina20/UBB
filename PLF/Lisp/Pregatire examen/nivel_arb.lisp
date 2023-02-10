;L2 10
(defun apartine(e l)
	(cond
		((null l) nil)
		((and (atom (car l)) (eq (car l) e)) t)
		((atom (car l)) (apartine e (cdr l)))
		((listp (car l)) (or (apartine e (car l)) (apartine e (cdr l)))) 
	)
)

(defun nivel(e arb lvl)
	(cond
		((null arb) nil)
		((equal e (car arb)) lvl)
		((apartine e (cadr arb)) (nivel e (cadr arb) (+ lvl 1)))
		((apartine e (caddr arb)) (nivel e (caddr arb) (+ lvl 1)))
		(t nil)
	)
)



(print (nivel 'E '(A (B (H () (I (J) (K)))())(C (D () (G)) (E))) 0))
(print (nivel 'G '(A (B (H () (I (J) (K)))())(C (D () (G)) (E))) 0))
(print (nivel 'I '(A (B (H () (I (J) (K)))())(C (D () (G)) (E))) 0)) 