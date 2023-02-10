%nr_aparitii(L:Lista, E:Atom, R:Intreg)
nr_aparitii([],_,0):-!.
nr_aparitii([H|T],E,R):-
    H=E,
    !,
    nr_aparitii(T,E,R1),
    R is R1 + 1.
nr_aparitii([_|T],E,R):-
    nr_aparitii(T,E,R).

%elimina(L:Lista, E:Atom, R:Lista)
elimina([],_,[]):-!.
elimina([L1],L1,[]):-!.
elimina([L1],E,[L1]):-
        L1 \= E,
        !.
elimina([H|T],E,R):-
    H = E,
    !,
    elimina(T,E,R).
elimina([H|T],E,R):-
    elimina(T,E,R1),
    R=[H|R1].

%ListaE = Lista*
%numar(L:Lista, R:ListaE)

numar([],[]):-!.
numar([H|T],R):-
    nr_aparitii([H|T],H,N),
    elimina(T,H,T1),
    numar(T1,R1),
    R=[[H,N]|R1].

