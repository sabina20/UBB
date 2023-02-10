%adauga_aux(L:Lista, E:Integer, C:Integer, D:integer, R:Lista)

adauga_aux([],_,_,_,[]):-!.
adauga_aux([H|T],E,C,D,R):-
    C = D,
    !,
    C1 is C+1,
    D1 is D*2,
    adauga_aux(T,E,C1,D1,R1),
    R=[H,E|R1].
adauga_aux([H|T],E,C,D,R):-
    C1 is C+1,
    adauga_aux(T,E,C1,D,R1),
    R=[H|R1].
