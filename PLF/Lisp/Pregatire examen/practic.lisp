(defun liniarizare(l)
	(cond
		((null l)nil)
		((atom (car l)) (cons (car l) (liniarizare(cdr l))))
		(t (append (liniarizare (car l)) (liniarizare (cdr l))))
	)
)
;(print (liniarizare '(1(2 c f 1 (d 2 c 4) e))))

(defun nr_aparitii(l e)
	(cond 
		((null l)0)
		((eq (car l) e)(+ 1 (nr_aparitii (cdr l) e)))
		(t (nr_aparitii (cdr l) e))
	)
)
;(print (nr_aparitii '(1 2 C F 1 D 2 C 4 E) 'C))

(defun elimina(l c)
	(cond
		((and (atom l) (> (nr_aparitii c l) 1))nil)
		((atom l) l)
		(t(mapcar #'(lambda(x)(elimina x c))l))
	)
)

(defun elimina1 (l c)
	(cond
		((null l) nil)
		((and (atom (car l)) (> (nr_aparitii c (car l)) 1))(elimina1 (cdr l) c))
		((atom  (car l))(cons (car l) (elimina1 (cdr l) c)))
		((and (listp (car l)) (null (cdr l)))(elimina1 (car l) c))
		(t(list (elimina1 (car l) c) (elimina1 (cdr l) c)))
	)
)


(defun elimina_princ(l)
	(elimina l (liniarizare l))
)

(print (elimina_princ '(1(2 c f 1 (d 2 c 4) e))))
(print (elimina_princ '(1 2 3 4 5 4 3 2 1)))
(print (elimina_princ '(A (B C) 3 A (D C A) 5 5)))
(print (elimina_princ '(1 2 (A B A (3 A))(1 (1 (C))1))))


	