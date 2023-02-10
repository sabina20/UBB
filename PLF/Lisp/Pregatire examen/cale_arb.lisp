(defun apartine(e l)
	(cond
		((null l) nil)
		((and (atom (car l)) (eq (car l) e)) t)
		((atom (car l)) (apartine e (cdr l)))
		((listp (car l)) (or (apartine e (car l)) (apartine e (cdr l)))) 
	)
)

;(print (apartine 'E '(A (B (H () (I (J) (K)))())(C (D () (G)) (E)))))
;(print (apartine 'E '(B (H () (I (J) (K)))())))
;(print (apartine 'E '(C (D () (G)) (E))))

(defun cale(e arb)
	(cond
		((null arb) nil)
		((equal (car arb) e) (list e))
		((apartine e (cadr arb)) (cons (car arb) (cale e (cadr arb))))
		((apartine e (caddr arb)) (cons (car arb) (cale e (caddr arb))))
		(t nil)
	)
)


;(print (cale 'E '(A (B (H () (I (J) (K)))())(C (D () (G)) (E)))))
;(print (cale 'G '(A (B (H () (I (J) (K)))())(C (D () (G)) (E)))))
;(print (cale 'I '(A (B (H () (I (J) (K)))())(C (D () (G)) (E)))))


(defun exista(l x)
	(cond
		((AND (atom l)(not (eq l x))) 0)
		((AND (atom l)(eq l x)) 1)
		(t (apply '+(mapcar #' (lambda(a)
				(exista a x))l)))
	)
)

(print (exista '(a (b (g)) (c (d (e)) (f))) 'x))

(defun cale2(arb e)
	(cond
		((null arb) nil)
		((atom arb) ())
		((not(=(exista arb e)0))(cons (car arb)(mapcan #'(lambda(x)(cale2 x e))arb)))
		(t(cale2 (cdr arb) e))
	)
)

(print (cale2 '(a (b (g)) (c (d (e)) (f))) 'a))