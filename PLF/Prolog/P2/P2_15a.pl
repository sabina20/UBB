%secventa(L:list, C:list, LEN:integer, R:list, LMAX:integer, RES:list)
secventa([], C, LEN, _, LMAX, C):-LEN > LMAX, !.
secventa([], _, LEN, R, LMAX, R):-LMAX >= LEN, !.
secventa([H|T], C, LEN, R, LMAX, RES):-
    0 is H mod 2, !, LEN2 is LEN+1,
    secventa(T, [H|C], LEN2, R, LMAX, RES).
secventa([H|T], C, LEN, _, LMAX, RES):-
    1 is H mod 2, LEN > LMAX, !,
    secventa(T, [], 0, C, LEN, RES).
secventa([H|T], _, LEN, R, LMAX, RES):-
    1 is H mod 2, LEN =< LMAX, !,
    secventa(T, [], 0, R, LMAX, RES).

%detSecv(L:list, R:list)
detSecv(L, R):-secventa(L, [], 0, [], 0, R).
