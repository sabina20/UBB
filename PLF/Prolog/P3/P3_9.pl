%Lista=Intreg*
%creeaza_lista(N:Intreg, R:Lista)
%Modele de flux: (i,o), (i,i) deterministe
%N: numarul de elemente care va fi generat
%R: lista numerelor consecutive intre 1 si N
creeaza_lista(0,[]):-!.
creeaza_lista(N,R):-
    N1 is N-1,
    creeaza_lista(N1,R1),
    R=[N|R1].

%insereaza(L:Lista, E:Intreg, R:Lista)
%Modele de flux: (i,i,o) nedeterminist, (i,i,i) determinist
%L: lista de elemente in care se va insera
%E: elementul care va fi inserat pe toate pozitiile din lista L
%R: lista rezultata prin inserarea lui E
insereaza(L,E,[E|L]).
insereaza([H|T],E,[H|R]):-
    insereaza(T,E,R).

%perm(L:Lista, R:Lista)
%Modele de flux: (i,o) nedeterminist, (i,i) determinist
%L: lista elementelor care vor fi permutate
%R: permutare a listei L
perm([],[]).
perm([H|T],R):-
    perm(T,R1),
    insereaza(R1,H,R).

%verif(L:Lista, E:Intreg)
%Modele de flux: (i,i) determinist
% L: lista elementelor in care se va verifica daca exista element care
% sa indeplineasca conditia |E - v(i)|=1
% E: elementul intreg cu care se va verifica conditia
verif([H|_],E):-
    R is H-E,
    abs(R) =:= 1, !.
verif([_|T],E):-
    verif(T,E).

%verif_perm(L:Lista)
%Modele de flux: (i) determinist
% L: lista in care se va verifica daca oricare ar fi 2<=i<=n exista un
% 1<=j<=i astfel incat |v((i)-v(j)|=1
verif_perm([H|T]):-
    verif(T,H), !.
verif_perm([_|T]):-
    verif_perm(T).

%solutie(L:Lista, R:Lista)
%Modele de flux: (i,o) nedeterminist, (i,i) determinist
%L: lista elementelor care vor fi permutate
%R: permutare a listei L care indeplineste conditia verif_perm
solutie(L,R):-
    perm(L,R),
    verif_perm(R).

%ListaR=Lista*
%toate_solutiile(N:Intreg, R:ListaR)
%N: numarul de elemente care vor fi permutate
%R: lista permutarilor de N elemente care indeplinesc conditia
toate_solutiile(N,R):-
    creeaza_lista(N,L),
    findall(R1, solutie(L,R1), R).


f([], -1).
f([H|T],S):-H>0, f(T,S1) ,S1<H,!,S is H.
f([_|T],S):- f(T,S1) , S is S1.

f1([], -1).
f1([H|T], S):- f1(T, S1), aux(H, S1, S).

aux(H, S1, S):- H>0, S1<H, !, S is H.
aux(_, S, S).





