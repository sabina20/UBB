(defun subliste(l)
	(cond
		((atom l) nil)
		(t (apply 'append (list l) (mapcar #'subliste l)))
	)
)

;(print (subliste '(1 2 (3 (4 5) (6 7)) 8 (9 10)) ))


(defun atomi(l)
	(cond
		((atom l)(list l))
		(t(mapcan #'atomi l))
	)
)

;(print (atomi '(((A B) C) (D E))))

(defun my_reverse(l)
	(cond
		((null l) nil)
		(t (append (my_reverse (cdr l)) (list (car l))))
	)
)

;(print (my_reverse '(1 2 3 4 5)))

(defun inversare_secv(l c)
	(cond
		((null l) (my_reverse c))
		((atom (car l))(inversare_secv (cdr l) (append c (list (car l)))))
		(t (append (my_reverse c) (cons (inversare_secv (car l) nil) (inversare_secv (cdr l) nil))))
	)
)

;(print (inversare_secv '(a b c (d (e f) g h i)) '()))

(defun ultim(l)
	(cond
		((null l) nil)
		((eq (cadr l) nil)(car l))
		(t (ultim (cdr l)))
	)
)

(defun inlocuire_subliste(l)
	(cond
		((null l) nil)
		((atom (car  l))(cons (car l) (inlocuire_subliste (cdr l))))
		(t (cons (ultim (car l)) (inlocuire_subliste (cdr l))))
	)
)

;(print (inlocuire_subliste '(a (b c) (d ((e) f)))))
;(print (inlocuire_subliste '(A C ((E) F))))

(defun inversare(l)
	(cond
		((null l) nil)
		((atom (car l))(append (inversare(cdr l))(list (car l))))
		(t (append (inversare (cdr l))(list (inversare (car l)))))
	)
)

;(print (inversare '(1 2 (3 (4 5) (6 7)) 8 (9 10 11))))

(defun _expression (op a b)
	(cond
		((string= op "+") (+ a b))
		((string= op "-") (- a b))
		((string= op "*") (* a b))
		((string= op "/") (floor a b))
	)
)

(defun expression (l)
    (cond
        ((null l) nil)
        ((and (and (numberp (cadr l)) (numberp (caddr l))) (atom (car l))) (cons (_expression (car l) (cadr l) (caddr l)) (expression (cdddr l))))
        (T (cons (car l) (expression (cdr l))))
    )
)

(defun solve (l)
    (cond
        ((null (cdr l)) (car l))
        (T (solve (expression l)))
    )
)

;(print (solve '(+ * 2 4 - 5 * 2 2)))

(defun perechi(l)
	(cond
		((null l)nil)
		(t (append (mapcar #'(lambda(x)(list (car l) x))(cdr l)) (perechi (cdr l))))
	)
)
(print (perechi '(a b c d)))

(defun pereche_aparitii(l)
	(cond
		((null l)nil)
		(t (append (mapcar #'(lambda(x)(list (car l)
