(defun inlocuire(l k niv)
	(cond
		((and (atom l)(= niv k)) 0)
		((atom l) l)
		(t (mapcar #'(lambda(x)(inlocuire x k (+ niv 1))) l))
	)
)



;(print (inlocuire '(a (b (g)) (c (d (e)) (f))) 2 0))

(defun G(L)
	(* (car L) (cadr L))
)


(defun f(l)
	(cond
		((null l)0)
		((> (f (car l))2)(+ (car l)(f (cdr l))))
		(t (f (car l)))
	)
)

;(print (f '(2 14 5 6 9 10)))

(defun f1(l)
	(lambda(x)
		(cond
			((null l)0)
			((> x 2)(+ (car l)(f1 (cdr l))))
			(t x)
		)
	)(f1 (car l))
)

;(print (f1 '(2 14 5 6 9 10)))

(defun inlocuire1(l e e1)
	(cond
		((and (atom l)(eq l e)) e1)
		((atom l) l)
		(t (mapcar #'(lambda(x)(inlocuire1 x e e1)) l))
	)
)

;(print (inlocuire1 '(1 (2 A (3 A)) (A)) 'A 'B))

(defun liniarizare(l)
	(cond
		((numberp l)())
		((atom l)(list l))
		(t (mapcan #'liniarizare l))
	)
)

(defun aparitii(l e)
	(cond
		((null l)0)
		((eq (car l) e)(+ 1 (aparitii (cdr l) e)))
		(t (aparitii (cdr l) e))
	)
)

(defun construire(li l c)
	(cond
		((null l) c)
		((and (= (mod (aparitii li (car l)) 2) 0) (= (aparitii c (car l)) 0)) (construire li (cdr l) (cons (car l) c)))
		(t (construire li (cdr l) c))
	)
)

(defun rezolvare(l)
	((lambda(f)(
		construire f f nil
		)
	)
		(liniarizare l)
	)
)
;(print (liniarizare '(F A 2 3 (B 1 (A D 5) C C (F)) 8 11 D (A F) F)))
;(print (rezolvare '(F A 2 3 (B 1 (A D 5) C C (F)) 8 11 D (A F) F)))

(defun substituire(l e e1 niv)
	(cond
		((and (= (mod niv 2) 1) (atom l) (eq e l)) e1)
		((atom l) l)
		(t (mapcar #'(lambda(x)(substituire x e e1 (+ niv 1)))l))
	)
)

;(print (substituire '(1 d (2 d (d))) 'd 'f 0))

(defun verificare (l x niv)
	(cond
		((and (atom l) (= (mod niv 2) 0) (eq l x)) t)
		((atom l) nil)
		(t (mapcar #' (lambda(v)(verificare v x (+ niv 1)))l))
	)
)

(defun my_or (l)
	(cond 
		((null l) nil)
		((listp (car l)) (or (my_or (car l)) (my_or (cdr l))))  
		(t (or (car l)(my_or (cdr l))))
	)
)

(defun verificare_princ (l x)
	(my_or (verificare l x -1))
)
(print (verificare_princ '(a (g (g)) (c (d (e)) (f))) 'g))

;(print (verificare '(a (g (g)) (c (d (e)) (f))) 'g -1))

;(print (my_or (verificare '(a (g (g)) (c (d (e)) (f))) 'g -1)))

(defun nr_numerici(l niv)
	(cond
		((null l)0)
		((and (numberp (car l)) (not(= (mod niv 2) 0)))(+ 1 (nr_numerici(cdr l) niv)))
		((listp(car l)) (+ (nr_numerici (car l) (+ niv 1)) (nr_numerici (cdr l) niv)))
		(t(nr_numerici(cdr l) niv))
	)
)

(defun nr_nenumerici(l niv)
	(cond
		((null l)0)
		((and (not(listp (car l))) (not(numberp (car l))) (not(= (mod niv 2) 0)))(+ 1 (nr_nenumerici(cdr l) niv)))
		((listp(car l)) (+ (nr_nenumerici (car l) (+ niv 1)) (nr_nenumerici (cdr l) niv) ))
		(t(nr_nenumerici(cdr l) niv))
	)
)

(defun verifica (l)
	(cond
		((= (nr_numerici l 1) (nr_nenumerici l 1))t)
		(t nil)
	)
)

(defun liniarizeaza(l)
	(cond
		((atom l)(list l))
		(t (mapcan #'liniarizeaza l))
	)
)

(defun numara(l)
	(cond
		((atom l) 0)
		((verifica l)(+ 1 (apply '+ (mapcar #'numara l ))))
		(t (apply '+ (mapcar #'numara l )))
	)
)

;(print (numara '(A B 12 (5 D (A F (B) D (5 F) 1) 5) C 9 (F 4 (D) 9 (F (H 7) K) (P 4)) X)))

