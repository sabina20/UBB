%elem_max(L:Lista, M:Intreg, E:Intreg)
elem_max([],M,M):-!.
elem_max([H|T],M,R):-
    H>M,
    !,
    elem_max(T,H,R).
elem_max([_|T],M,R):-
    elem_max(T,M,R).

%poz(L:Lista, C:Intreg, E:Intreg, R:Lista)
poz([],_,_,[]):-!.
poz([H|T],C,E,R):-
    H = E,
    !,
    C1 is C+1,
    poz(T,C1,E,R1),
    R=[C|R1].
poz([_|T],C,E,R):-
    C1 is C+1,
    poz(T,C1,E,R).

%poz_princ(L:lista, R:Lista)
poz_princ(L,R):-
    M is 0,
    elem_max(L,M,E),
    C is 1,
    poz(L,C,E,R).
