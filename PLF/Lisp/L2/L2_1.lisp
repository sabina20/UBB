;l - lista initiala
;x - nodul curent
;node - nodul destinatie
;nrc - numarul fiilor nodului curent
;p - path-ul
(defun path (l x node nrc p)
	(cond 
		((eq x node) (append p (list x)))
		((null l) nil)
		((= nrc 0) (path (cddr l) (car l) node (cadr l) p))
		(t (path (cddr l) (car l) node (cadr l) (append p (list x))))
	)
)

(defun path_princ(l node)
	(path (cddr l) (car l) node (cadr l) ())
)


(print (path_princ '(A 2 B 2 D 0 E 2 H 0 I 0) 'E))
(print (path_princ '(A 2 B 1 H 1 I 2 J 0 K 0 C 2 D 1 G 0 E 0) 'I))
(print (path_princ '(A 2 B 1 H 1 I 2 J 0 K 0 C 2 D 1 G 0 E 0) 'G))

