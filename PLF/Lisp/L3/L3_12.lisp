(defun inlocuieste (l nod1 nod2)
	(cond
		((AND(atom l)(eq l nod1)) nod2)
		((atom l) l)
		(t (mapcar #'(lambda(x) (inlocuieste x nod1 nod2)) l))
	)
)

(print (inlocuieste '(A (B (C)) (D) (E (F))) 'B 'G))