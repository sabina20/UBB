%nr_par(L:Lista)
nr_par([]):-!.
nr_par([_,_|T]):-
    nr_par(T).
