;L2 16


(defun echilibrat(arb)
    (cond
        ((null arb) t)
        ((> (abs (- (adancime (cadr arb)) (adancime (caddr arb)))) 1) nil)
        (t (and (echilibrat (caddr arb)) (echilibrat (cadr arb))))
    )
)

(defun adancime(arb)
    (cond 
        ((null arb) 0)
        (t (+ 1 (max (adancime (cadr arb)) (adancime(caddr arb)))))
    )
)



(print (echilibrat '(A (B (H () (I (J) (K)))())(C (D () (G)) (E)))))

(print (echilibrat '(A (B (H () (I (J) (K)))())(C (D) (E)))))

(print (echilibrat '(A (B (D) ()) (C))))