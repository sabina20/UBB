%constuieste(M:Intreg, N:Intreg, R:Lista)
construieste(M,N,[M]):-
    M=N,
    !.
construieste(M,N,R):-
    M<N,
    !,
    M1 is M+1,
    construieste(M1,N,R1),
    R=[M|R1].
construieste(M,N,R):-
    M1 is M-1,
    construieste(M1,N,R1),
    R=[M|R1].
