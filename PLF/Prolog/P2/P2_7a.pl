%produs(L:Lista, E:Intreg, C:Intreg, R:Lista)
produs([],_,0,[]):-!.
produs([],_,C,[C]):-!.
produs([H|T],E,C,R):-
    P1 is H*E,
    P is P1+C,
    D is P mod 10,
    C1 is P div 10,
    produs(T,E,C1,R1),
    R=[D|R1].
