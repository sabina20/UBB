%predecesor(L:Lista, C:Intreg, F:Intreg, R:Lista)
predecesor([],_,_,[]):-!.
predecesor([H|T],_,1,R):-
    H > 0,
    H1 is H-1,
    R=[H1|T].
predecesor([H|T],_,1,R):-
    H = 0,
    D = 9,
    predecesor(T,1,0,R1),
    R=[D|R1].
predecesor([H|T],1,0,R):-
    H > 0,
    H1 is H-1,
    predecesor(T,0,0,R1),
    R=[H1|R1].
predecesor([H|T],1,0,R):-
    H = 0,
    D = 9,
    predecesor(T,1,0,R1),
    R=[D|R1].
predecesor([H|T],C,0,R):-
    C \= 1,
    predecesor(T,C,0,R1),
    R=[H|R1].

