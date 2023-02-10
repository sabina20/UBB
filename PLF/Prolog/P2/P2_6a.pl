%concateneaza(L:Lista, P:Lista, R:lista)
concateneaza([],[],[]):-!.
concateneaza([],P,P):-!.
concateneaza(L,[],L):-!.
concateneaza([H|T],P,R):-
    concateneaza(T,P,R1),
    R=[H|R1].

%inlocuieste(L:Lista, E:intreg, X:Lista, R:Lista)
inlocuieste([],_,_,[]):-!.
inlocuieste([H|T],E,X,R):-
    H=E,
    !,
    inlocuieste(T,E,X,R1),
    concateneaza(X,R1,R).
inlocuieste([H|T],E,X,R):-
    inlocuieste(T,E,X,R1),
    R=[H|R1].
