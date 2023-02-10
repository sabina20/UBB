;L2 11

(defun my_length (l)
	(cond
		((null l) 0)
		((+ 1 (my_length (cdr l))))
	)
)

(defun noduri_nivel (arb niv)
	(cond
		((null arb) nil)
		((= niv 0) (list (car arb)))
		(t (append (noduri_nivel (cadr arb) (- niv 1)) (noduri_nivel (caddr arb) (- niv 1))))
	)
)

(defun niv_max (arb maxx niv)
	(setf noduri (noduri_nivel arb niv))
	(cond
		((null noduri) maxx)
		((> (my_length noduri) (my_length maxx)) (niv_max arb noduri (+ niv 1)))
		(t (niv_max arb maxx (+ niv 1)))
	)
)

(defun niv_max_princ(arb)
	(niv_max arb '() 0)
)

(print (niv_max_princ '(A (B (H () (I (J) (K)))())(C (D () (G)) (E)))))

(print (noduri_nivel '(A (B (H () (I (J) (K)))())(C (D () (G)) (E))) 0))
(print (noduri_nivel '(A (B (H () (I (J) (K)))())(C (D () (G)) (E))) 1))
(print (noduri_nivel '(A (B (H () (I (J) (K)))())(C (D () (G)) (E))) 2))
(print (noduri_nivel '(A (B (H () (I (J) (K)))())(C (D () (G)) (E))) 3))