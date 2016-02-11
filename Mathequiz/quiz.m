% quiz.m A math quiz similar to Sudoku
%
% vim: ft=mercury ts=4 sw=4 et

:- module quiz.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is cc_multi.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module int.

%-----------------------------------------------------------------------------%
% constraints for numbers

:- pred limit(int, int, int, int, int, int, int, int, int).
:- mode limit(in, in, in, in, in, in, in, in, in) is multi.

limit(A, B, C, D, E, F, G, H, I) :-
    A > 0,
    B > 0,
    C > 0,
    D > 0,
    E > 0,
    F > 0,
    G > 0,
    H > 0,
    I > 0,
    A < 10,
    B < 10,
    C < 10,
    D < 10,
    E < 10,
    F < 10,
    G < 10,
    H < 10,
    I < 10.

:- pred distinct(int, int, int, int, int, int, int, int, int).
:- mode distinct(in, in, in, in, in, in, in, in, in) is multi.

distinct(A, B, C, D, E, F, G, H, I) :-
    A != B.
% TODO

%-----------------------------------------------------------------------------%

main(!IO) :-
    limit(A, B, C, D, E, F, G, H, I),
    distinct(A, B, C, D, E, F, G, H, I),
    solutions(numbers, R),
    io.write(R, IO).

