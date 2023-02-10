%prim(N:Intreg, D:Intreg)
prim(N,_):-
    N = 2,!.
prim(N,_):-
    N = 3,!.
prim(N,D):-
    N1 is N div 2,
    D = N1,
    !,
    N mod D =\= 0.
prim(N,D):-
    N mod D =\= 0,
    D1 is D+1,
    prim(N,D1).

%dublare(L:Lista, R:Lista)
dublare([],[]):-!.
dublare([H|T],R):-
    prim(H,2),
    !,
    dublare(T,R1),
    R=[H,H|R1].
dublare([H|T],R):-
    dublare(T,R1),
    R=[H|R1].

