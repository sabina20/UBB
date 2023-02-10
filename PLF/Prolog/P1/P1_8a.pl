%aparitii(L:Lista, E:Intreg, R:Intreg)
aparitii([],_,0):-!.
aparitii([H|T],E,R):-
    H=E,
    !,
    aparitii(T,E,R1),
    R is R1+1.
aparitii([_|T],E,R):-
    aparitii(T,E,R).

%multime(L:Lista)
multime([]).
multime([H|T]):-
    aparitii(T,H,R),
    R = 0,
    multime(T).
