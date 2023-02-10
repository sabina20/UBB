(defun F(L)
	(MAX (car L) (caddr L))
)
;(print (F '(8 11 2 3 7 9)))
;(print (SETQ F 10))
;(print (SETF #'G #'F))

;(print (G '(8 11 2 3 7 9)))
;(print (FUNCALL (EVAL #'G) '(8 11 2 3 7 9)))
;(print (FUNCALL #'G '(8 11 2 3 7 9)))

(defun inlocuire(arb k e niv)
	(cond
		((and (= niv k) (atom arb)) e)
		((atom arb) arb)
		(t (mapcar #'(lambda(a)(inlocuire a k e (+ niv 1))) arb))
	)
)

;(print (inlocuire '(a (b (g)) (c (d (e)) (f))) 2 'h -1 ))



(defun liniarizare_numerica(l)
	(cond
		((numberp l)(list l))
		((atom l)())
		(t (mapcan #'liniarizare_numerica l))
	)
)

(defun numara(x)
	(cond
		((atom x)0)
		((verifica x)(+ 1 (apply '+ (mapcar #'numara x))))
		(t (apply '+ (mapcar #'numara x)))
	)
)

(defun verifica(l)
	(cond
		((= (mod (car (liniarizare_numerica l)) 2) 0) t)
		(t nil)
	)
)

;(print (numara '(A 3 (B 2) (1 C 4) (D 2 (6 F))((G 4) 6))))

(defun inloc_succ(l)
	(cond
		((null l) nil)
		((and (numberp (car l))(= (mod (car l) 2) 0)) (cons (+ (car l) 1) (inloc_succ (cdr l))))
		((atom (car l))(cons (car l) (inloc_succ (cdr l))))
		((listp (car l))(cons (inloc_succ (car l)) (inloc_succ (cdr l))))
	)
)

;(print (inloc_succ '(1 s 4 (2 f (7)))))

(defun inloc_succ2 (l)
	(cond
		((and (numberp l) (= (mod l 2) 0)) (+ l 1))
		((atom l) l)
		(t (mapcar #'inloc_succ2 l))
	)
)

;(print (inloc_succ2 '(1 s 4 (2 f (7)))))

(defun maxim(l max)
	(cond
		((null l) max)
		((and (numberp (car l))(> (car l) max))(maxim (cdr l) (car l)))
		(t (maxim (cdr l) max))
	)
)


(defun verifica2(l)
	(cond
		((= (mod (maxim l 0) 2) 0) t)
		(t nil)
	)
)

(defun numara2(x niv)
	(cond
		((atom x)0)
		((and (verifica2 x)(= (mod niv 2) 1))(+ 1 (apply '+ (mapcar #'(lambda(x)(numara2 x (+ niv 1)))x))))
		(t (apply '+ (mapcar #'(lambda(x)(numara2 x (+ niv 1)))x)))
	)
)


;(print (numara2 '(A (B 2) (1 C 4)(1 (6 F))(((G) 4) 6)) 0))

(defun f(l)
	(cond
		((atom l) -1)
		((> (f(car l)) 0)(+ (car l)(f (car l))(f (cdr l))))
		(t (f (cdr l)))
	)
)

(defun f2(l)
		((lambda(v)
			(cond
				((atom l) -1)
				((> v 0)(+ (car l) v (f (cdr l))))
				(t( f (cdr l)))
			)
		)
		(f(car l))
		)
	
)

;(print (f2 '(1 (5 (1) -7) 9 (-3 2))))


