nr_pare([],0).
nr_pare([H|T],R):-
    H mod 2 =:= 0,!,
    nr_pare(T,R1),
    R is R1+1.
nr_pare([_|T],R):-
    nr_pare(T,R).

candidat([H|_],H).
candidat([_,H|T],R):-
    candidat([H|T],R).

solutie(_,C,SC,C):-
    SC mod 2 =:= 1,
    nr_pare(C,X),
    X =\= 0,
    X mod 2 =:= 0.
solutie(L,C,SC,R):-
    candidat(L,X),
    not(candidat(C,X)),
    SC1 is SC+X,
    solutie(L,[X|C],SC1,R).

aranjamente(_,K,V,C,LC,PC,C):-
    LC=K,
    PC<V.
aranjamente(L,K,V,C,LC,PC,R):-
    candidat(L,X),
    not(candidat(C,X)),
    LC1 is LC+1,
    K >= LC1,
    PC1 is PC*X,
    PC1 < V,
    aranjamente(L,K,V,[X|C],LC1,PC1,R).

submultimi(_,S,C,SC,C):-
    SC=S,
    nr_pare(C,X),
    X mod 2 =:= 0.
submultimi(L,S,[H|T],SC,R):-
    candidat(L,X),
    X < H,
    SC1 is SC+X,
    S >= SC1,
    submultimi(L,S,[X,H|T],SC1,R).
submultimi(L,S,[],SC,R):-
    candidat(L,X),
    SC1 is SC+X,
    S >= SC1,
    submultimi(L,S,[X],SC1,R).

toate_sol(L,S,R):-
    findall(R1, submultimi(L,S,[],0,R1), R).


f([], 0).
f([H|T],S):- f(T,S1) ,H<S1,!,S is H+S1.
f([_|T],S):- f(T,S1) , S is S1+2.

f2([],0).
f2([H|T],S):-f2(T,S1),aux(H,S,S1).

aux(H,S,S1):-H<S1,!,S is H+S1.
aux(_,S,S1):-S is S1+2.

f3(1, 1):-!.
f3(K,X):-K1 is K-1, f3(K1,Y) , Y>1, !, K2 is K1-1, X is K2.
f3(K,X):-K1 is K-1, f3(K1,Y) , Y>0.5, !, X is Y.
f3(K,X):-K1 is K-1, f3(K1,Y) , X is Y-1.

f4(1,1):-!.
f4(K,X):-K1 is K-1, f4(K1,Y), aux2(X,Y,K1).

aux2(X,Y,K1):-Y>1,!,K2 is K1-1, X is K2.
aux2(X,Y,_):-Y>0.5,!,X is Y.
aux2(X,Y,_):-X is Y-1.
