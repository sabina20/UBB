(DEFUN Fct(F L)
	(COND
		((NULL L) NIL)
		( (FUNCALL F (CAR L) ) (CONS ( FUNCALL F (CAR L) ) (Fct F (CDR L))))
		(T NIL)
	)
)

(defun fct1(F l)
	(cond
		((null l)nil)
		(t((lambda(x)
			(cond
				(x (cons x (fct1 F (cdr l))))
				(t nil)
			)
		) (funcall F (car l)) ))
	)
)


(defun F (a)
	(cond
		((< a 0)nil)
		(t t)
	)
)
;(print (fct1 #'F '(1 2 3 4)))
;(print (Fct #'F '(1 2 3 4)))


(defun aparitii(l x)
	(cond
		((null l)0)
		((and (atom (car l)) (eq (car l) x))(+ 1 (aparitii (cdr l) x)))
		(t (aparitii (cdr l) x))
	)
)

(defun inlocuire(l p)
	(cond 
		((numberp l) l)
		((atom l)(aparitii p l))
		(t (mapcar #'(lambda(x)(inlocuire x l))l))
	)

)

(defun f_princ(l)
	(inlocuire l l)
)

;(print (f_princ '(F A 12 13 (B 11 (A D 15) C C (F)) 18 11 D (A F) F)))

(defun cmmdc(a b)
	(cond
		((= b 0) a)
		(t(cmmdc b (mod a b)))
	)
)

(defun creare_lista(l niv)
	(cond
		((and (numberp l)(= (mod l 2) 1)(= (mod niv 2)0))(list l))
		((atom l) nil)
		(t (mapcan #'(lambda(x)(creare_lista x (+ niv 1)))l))
	)
)

(defun cmmdc_lista(l d)
	(cond
		((null l)d)
		(t(cmmdc_lista (cdr l) (cmmdc (car l) d)))
	)
)

(defun f(l)
	(cmmdc_lista(creare_lista l 0) (car (creare_lista l 0)))
)

;(print (creare_lista '(A B 12 (9 D (A F (75 B) D (45 F) 1) 15) C 9) 0))
;(print (f '(A B 12 (9 D (A F (75 B) D (45 F) 1) 15) C 9)))


(DEFUN F5(L1 L2)
(APPEND (F5 (CAR L1) L2 )
(COND
((NULL L1) (CDR L2))
(T (LIST (F5 (CAR L1) L2) (CAR L2)))
)
)
)

(defun f6(l1 l2)
	((lambda(x)
		(append x
			(cond
				((null l1)(cdr l2))
				(t(list x (car l2)))
			)
		)
	)
	(f6 (car l1) l2)
	)
)

;(print (F5 '((1 2) 3 4 5) '(6 7 8)))
;(print (f6 '((1 2) 3 4 5) '(6 7 8)))

(defun substituire(l niv e e1)
	(cond
		((and (atom l)(eq l e)(=(mod niv 2)0))e1)
		((atom l)l)
		(t (mapcar #'(lambda(x)(substituire x (+ niv 1) e e1))l))
	)
)
(print (substituire '(1 d (2 d (d))) -1 'd 'f))