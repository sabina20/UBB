%suma(L:Lista, P:Lista, C:Intreg, R:Lista)
suma([],[],0,[]):-!.
suma([],[],C,[C]):-!.
suma([],[H|T],C,R):-
    S is H+C,
    S < 10,
    suma([],T,0,R1),
    R=[S|R1].
suma([],[H|T],C,R):-
    S is H+C,
    S >= 10,
    S1 is S mod 10,
    suma([],T,1,R1),
    R=[S1|R1].
suma([H|T],[],C,R):-
    S is H+C,
    S < 10,
    suma([],T,0,R1),
    R=[S|R1].
suma([H|T],[],C,R):-
    S is H+C,
    S >= 10,
    S1 is S mod 10,
    suma([],T,1,R1),
    R=[S1|R1].
suma([H1|T1],[H2|T2],C,R):-
    S is H1+H2+C,
    S < 10,
    suma(T1,T2,0,R1),
    R=[S|R1].
suma([H1|T1],[H2|T2],C,R):-
    S is H1+H2+C,
    S >= 10,
    S1 is S mod 10,
    suma(T1,T2,1,R1),
    R=[S1|R1].
