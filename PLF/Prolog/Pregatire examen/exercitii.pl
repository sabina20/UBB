candidat([H|_], H).
candidat([_,H2|T],E):-candidat([H2|T],E).

solutie(_,S,C,S,C).
solutie(L,S,[],SC,R):-
    candidat(L,X),
    SC1 is SC+X,
    S >= SC1,
    solutie(L,S,[X],SC1,R).
solutie(L,S,[H|T],SC,R):-
    candidat(L,X),
    X>H,
    SC1 is SC+X,
    S >= SC1,
    solutie(L,S,[X,H|T],SC1,R).

toate_solutiile(L,S,R):-
    findall(R1, solutie(L, S, [], 0, R1), R).

f([],-1).
f([H|T],S):-
    f(T,S1),
    S1>0,
    !,
    S is S1+H.
f([_|T],S):-
    f(T,S1),
    S is S1.


lungime([],0).
lungime([_|T],R):-
    lungime(T,R1),
    R is R1+1.

aranjamente(_,K,P,C,P,C):-lungime(C,X),
    X = K.
aranjamente(L,K,P,[H|T],PC,R):-
    candidat(L,X),
    PC1 is PC*X,
    lungime([H|T],LU),
    LU1 is LU+1,
    K >= LU1,
    not(candidat([H|T],X)),
    aranjamente(L,K,P,[X,H|T],PC1,R).
aranjamente(L,K,P,[],PC,R):-
    candidat(L,X),
    PC1 is PC*X,
    K >= 1,
    aranjamente(L,K,P,[X],PC1,R).

%creeaza_lista(N:Intreg, X:Intreg, R:Lista)
creeaza_lista(_,-1,[]).
creeaza_lista(N,X,R):-
    X1 is X-1,
    S is N+X,
    creeaza_lista(N,X1,R1),
    R=[S|R1].


%solutie2(L:Lista, C:lista, R:Lista)
solutie2(L,C,C):-
    lungime(L,X1),
    lungime(C,X2),
    X1=X2.
solutie2(L,[H|T],R):-
    candidat(L,X),
    D is abs(X-H),
    2 >= D,
    not(candidat([H|T],X)),
    solutie2(L,[X,H|T],R).
solutie2(L,[],R):-
    candidat(L,X),
    solutie2(L,[X],R).

%insereaza(L:Lista, PC:Intreg, P:Intreg, E:Intreg, R:Lista)
insereaza([],_,_,_,[]).
insereaza([H|T],PC,P,E,R):-
    PC = P, !,
    PC1 is PC+1,
    P1 is 2*P-1,
    insereaza(T,PC1,P1,E,R1),
    R=[H,E|R1].
insereaza([H|T],PC,P,E,R):-
    PC1 is PC+1,
    insereaza(T,PC1,P,E,R1),
    R=[H|R1].

func([],0).
func([H|T],S):-func(T,S1),S1<2,!,S=S1+H.
func([_|T],S):-func(T,S1),S=S1+1.

func2([],0).
func2([H|T],S):-func2(T,S1),
    aux(H,S1,S).

aux(H,S1,S):-
    S1<2, !,
    S=S1+H.
aux(_,S1,S):-
    S=S1+1.


f3([],0).
f3([H|T],S):-
    H mod 2 =:= 0,!,
    f3(T,S1),
    S is S1+1.
f3([_|T],S):-
    f3(T,S1),
    S is S1.

sol([],_,_,_,[]).
sol([_],_,_,_,[]).
sol(_,C,LC,SC,C):-
    LC mod 2 =:= 0,
    SC mod 2 =:= 1.
sol(L,C,LC,SC,R):-
    candidat(L,X),
    not(candidat(C,X)),
    LC1 is LC+1,
    SC1 is SC+X,
    sol(L,[X|C],LC1,SC1,R).



