;a)
;lista - lista data, poz - pozitia elementului pe care il dublam, c - pozitia curenta pe care ne aflam
(defun dublare(lista poz c)
	(cond
		((null lista) nil)
		((= poz c)(cons (car lista)(cons (car lista) (dublare (cdr lista) poz (+ c 1)))))
		(t (cons (car lista) (dublare (cdr lista) poz (+ c 1))))
	)
)

;lista - lista data, poz - pozitia elementului pe care il dublam
(defun dublare_princ (lista poz)
	(dublare lista poz 1)
)
(print (dublare_princ '(10 20 30 40 50) 3))


;b)
;l1 - lista elementelor pe care le vom asocia cu cele din lista l2, l2 - lista
(defun asociere(l1 l2)
	(cond
		((AND (not(null l1)) (not(null l2)))(cons (cons (car l1) (car l2)) (asociere (cdr l1) (cdr l2))))
		(nil)
	)
)

(print (asociere '(A B C) '(D E F)))

;c)
;lista - lista data in care vom numara sublistele, nr - numarul de subliste
(defun nr_subliste(lista nr)
	(cond
		((null lista) nr)
		((atom (car lista)) (nr_subliste (cdr lista) nr))
		((listp (car lista)) (+  1 (nr_subliste (car lista) nr) (nr_subliste (cdr lista) nr)))
	)
)
		

;lista - lista data
(defun nr_subliste_princ(lista)
	(+ 1 (nr_subliste lista 0))
)

(print (nr_subliste_princ '(12 (3 (4 5) (6 7)) 8 (9 10))))

;d)
;lista - lista data in care vom numara atomii de la nivel superficial
(defun nr_atomi (lista)
	(cond
		((null lista) 0)
		((atom (car lista))(+ 1 (nr_atomi (cdr lista))))
		(t (nr_atomi(cdr lista)))
	)
)
(print (nr_atomi '(A 56 8 (12 3 (6)))))
