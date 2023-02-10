%interclasare(L:Lista, P:Lista, R:Lista)
interclasare([],[],[]):-!.
interclasare([],P,P):-!.
interclasare(L,[],L):-!.
interclasare([H1|T1],[H2|T2],R):-
    H1<H2,
    interclasare(T1, [H2|T2], R1),
    R=[H1|R1].
interclasare([H1|T1],[H2|T2],R):-
    H1=H2,
    interclasare(T1,T2,R1),
    R=[H1|R1].
interclasare([H1|T1],[H2|T2],R):-
    H1>H2,
    interclasare([H1|T1],T2,R1),
    R=[H2|R1].
