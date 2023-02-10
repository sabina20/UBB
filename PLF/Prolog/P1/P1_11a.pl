%vale(L:Lista, D:Integer)
vale([_],1):-!.
vale([H1,H2|T],0):-
    H1>H2,
    !,
    vale([H2|T],0).
vale([H1,H2|T],_):-
    H1<H2,
    !,
    vale([H2|T],1).
