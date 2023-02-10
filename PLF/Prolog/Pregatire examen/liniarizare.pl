concatenare([],[],[]).
concatenare(L1,[],L1).
concatenare([],L2,L2).
concatenare([H|T],L2,R):-
    concatenare(T,L2,R1),
    R=[H|R1].

liniarizare([],[]).
liniarizare([H|T],R):-
    number(H),
    liniarizare(T,R1),
    R=[H|R1].
liniarizare([H|T],R):-
    is_list(H),
    liniarizare(H,R1),
    liniarizare(T,R2),
    concatenare(R1,R2,R).

inversare([],C,C).
inversare([H|T],C,R):-
    inversare(T,[H|C],R).


simetrie([]).
simetrie(L):-
    inversare(L,[],R1),
    egale(L,R1).
