%cmmdc(A:Integer, B:Integer, R:Integer)
cmmdc(0,A,A):-!.
cmmdc(A,0,A):-!.
cmmdc(A,A,A):-!.
cmmdc(A,B,R):-
    A>B,!,
    A1 is A-B,
    cmmdc(A1,B,R).
cmmdc(A,B,R):-
    B1 is B-A,
    cmmdc(A,B1,R).

%cmmmc_lista(L:Lista, D:Integer)
cmmmc_lista([],0):-!.
cmmmc_lista([L1],L1):-!.
cmmmc_lista([H|T],R):-
    cmmmc_lista(T,R1),
    P is R1*H,
    cmmdc(H,R1,R2),
    R is P div R2.
