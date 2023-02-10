%elim(L:Lista, E:Intreg, C:intreg, R:Lista)
elim([],_,_,[]):-!.
elim([H|T],E,C,R):-
    H=E,
    C>0,
    !,
    C1 is C-1,
    elim(T,E,C1,R).
elim([H|T],E,C,R):-
    elim(T,E,C,R1),
    R=[H|R1].
