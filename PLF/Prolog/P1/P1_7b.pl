%ListaE = Lista*
%imperechere(E:Integer, L:Lista, R:ListaE
imperechere(_,[],[]):-!.
imperechere(E,[H|T],R):-
    imperechere(E,T,R1),
    R=[[E,H]|R1].

%concatenare(L1:ListaE, L2:ListaE, R:ListaE)
concatenare([],[],[]):-!.
concatenare([],L2,L2):-!.
concatenare([H|T],L2,R):-
    concatenare(T,L2,R1),
    R=[H|R1].

%perechi(L:Lista, R:ListaE)
perechi([],[]):-!.
perechi([H|T],R):-
    imperechere(H,T,R1),
    perechi(T,R2),
    concatenare(R1,R2,R3),
    R = R3.
