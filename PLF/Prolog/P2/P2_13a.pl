%divizori(E:Intreg, D:Intreg, R:Lista)
divizori(E,D,[]):-
    R is E div 2,
    D > R, !.
divizori(E,D,R):-
    S is E mod D,
    S = 0,
    D1 is D+1,
    divizori(E,D1,R1),
    R=[D|R1].
divizori(E,D,R):-
    S is E mod D,
    S =\= 0,
    D1 is D+1,
    divizori(E,D1,R).

%concatenare(L:Lista, P:Lista, R:Lista)
concatenare([],[],[]):-!.
concatenare([],P,P):-!.
concatenare([H|T],P,R):-
    concatenare(T,P,R1),
    R=[H|R1].

%adauga_div(L:Lista, R:Lista)
adauga_div([],[]):-!.
adauga_div([H|T],R):-
    D = 2,
    divizori(H,D,R1),
    adauga_div(T,R2),
    concatenare(R1,R2,R3),
    R=[H|R3].
