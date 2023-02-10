(defun parcurg_st(arb nv nm)
	(cond 
		((null arb) nil)
		((= nv (+ nm 1)) nil)
		(t(cons (car arb) (cons (cadr arb) (parcurg_st (cddr arb) (+ nv 1) (+ nm (cadr arb))))))
	)
)

(defun parcurg_dr(arb nv nm)
	(cond
		((null arb) nil)
		((= nv (+ nm 1)) arb)
		(t(parcurg_dr (cddr arb) (+ nv 1) (+ nm (cadr arb))))
	)
)

(defun apare (arb nod)
	(cond
		((null arb) nil)
		((equal (car arb) nod) t)
		(t (apare (cddr arb) nod))
	)
)

(defun path (arb nod)
	(cond 
		((equal (car arb) nod) (list nod))
		((apare (parcurg_st (cddr arb) 0 0) nod) (append (list (car arb)) (path(parcurg_st (cddr arb) 0 0) nod)))
		((apare (parcurg_dr (cddr arb) 0 0) nod) (append (list (car arb)) (path(parcurg_dr (cddr arb) 0 0) nod)))
		(t nil)
	)
)


(print (path '(A 2 B 2 D 0 E 2 H 0 I 0 C 0) 'E))
(print (path '(A 2 B 1 H 1 I 2 J 0 K 0 C 2 D 1 G 0 E 0) 'I))
(print (path '(A 2 B 1 H 1 I 2 J 0 K 0 C 2 D 1 G 0 E 0) 'G))
(print (path '(A 2 B 1 H 1 I 2 J 0 K 0 C 2 D 1 G 0 E 0) 'E))
(print (path '(A 2 B 2 D 0 E 2 H 0 I 0 C 0) 'Z))
