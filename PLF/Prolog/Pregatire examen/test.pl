%prim(E:Intreg, D:Intreg)
%Modele de flux: (i,i) determinist
%E: Intregul al carui calitate de numar prim se verifica
% D: Intreg care joaca rolul de divizor, se verifica impartirea exacta a
% lui N la acest divizor
prim(2,_):-!.
prim(3,_):-!.
prim(E,D):-
    E > 3,
    R is E div 2,
    D > R.
prim(E,D):-
    E > 3,
    E mod D =\= 0,
    D1 is D+1,
    prim(E,D1).

%Lista=Intreg*
%construire(L:Lista, R:Lista)
%Modele de flux: (i,o), (i,i) deterministe
%L:Lista initiala de intregi din care se vor extrage numerele prime
%R: Lista rezultata in urma adaugarii numerelor prime din lista L
construire([],[]):-!.
construire([H|T],R):-
    prim(H,2),
    !,
    construire(T,R1),
    R=[H|R1].
construire([_|T],R):-
    construire(T,R).
