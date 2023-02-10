%adauga1(L:Lista, R:Lista)
adauga1([L1],[L1,1]):-
    mod(L1,2)=:=0,!.
adauga1([L1],[L1]).
adauga1([H|T],R):-
    mod(H,2)=:=0,!,
    adauga1(T,R1),
    R=[H,1|R1].
adauga1([H|T],R):-
    adauga1(T,R1),
    R=[H|R1].
