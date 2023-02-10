(defun inserare(e arb)
	(cond 
		((null arb)(list e))
		((<= e (car arb)) (list (car arb) (inserare e (cadr arb)) (caddr arb)))
		(t (list (car arb) (cadr arb) (inserare e (caddr arb))))
	)
)

(defun construire(l)
	(cond
		((null l) nil)
		(t (inserare (car l) (construire (cdr l))))
	)
)

(print (construire '(5 1 4 6 3 2)))

(defun inordine(l)
	(cond
		((null l) nil)
		(t(append (inordine (cadr l))(list (car l))(inordine (caddr l))))
	)
)

(print (inordine(construire '(5 1 4 6 3 2))))
