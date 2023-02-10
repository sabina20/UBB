%lista_pare(L: List, R: List, N: Integer)
%Modele de flux: (i,o,o), (i,i,i), (i,o,i), (i,i,o)
%L - lista initiala de intregi
%R - lista L din care s-au eliminat numerele impare
%N - numarul elementelor listei R
lista_pare([],[],0).
lista_pare([H|T],R,N):-
    mod(H,2)=\=0,
    lista_pare(T,R,N).
lista_pare([H|T],R,N):-
    mod(H,2)=:=0,
    lista_pare(T,R1,NT),
    N is NT+1,
    R=[H|R1].

%lista_impare(L: List, R: List, N: Integer)
%Modele de flux: (i,o,o), (i,i,i), (i,o,i), (i,i,o)
%L - lista initiala de intregi
%R - lista L din care s-au eliminat numerele pare
%N - numarul elementelor listei R
lista_impare([],[],0).
lista_impare([H|T],R,N):-
    mod(H,2)=:=0,
    lista_impare(T,R,N).
lista_impare([H|T],R,N):-
    mod(H,2)=\=0,
    lista_impare(T,R1,NT),
    N is NT+1,
    R=[H|R1].

%descompune(L:List, R:List)
%Modele de flux: (i,o), (i,i)
%L - lista initiala de numere care va fi descompusa
/*R - lista formata din lista numerelor pare, lista numerelor impare, numarul de numere pare si numarul de numere impare*/
descompune([],[]).
descompune(L,R):-
    lista_pare(L,P,N),
    lista_impare(L,I,M),
    R=[P,I,N,M].
