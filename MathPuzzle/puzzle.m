% puzzle.m A math quiz similar to Sudoku
%
% vim: ft=mercury ts=4 sw=4 et

:- module puzzle.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module int.
:- import_module list, solutions.

%-----------------------------------------------------------------------------%
% constraints for numbers

:- type t_num ---> one; two; three; four; five; six; seven; eight; nine.

:- pred limit(int, int, int, int, int, int, int, int, int).
:- mode limit(in, in, in, in, in, in, in, in, in) is semidet.

limit(A, B, C, D, E, F, G, H, I) :-
    A > 0, B > 0, C > 0, D > 0, E > 0, F > 0, G > 0, H > 0, I > 0,
    A < 10, B < 10, C < 10, D < 10, E < 10, F < 10, G < 10, H < 10, I < 10.


:- pred different(t_num, t_num).
:- mode different(out, out) is multi.
different(one, two).
different(one, three).
different(one, four).
different(one, five).
different(one, six).
different(one, seven).
different(one, eight).
different(one, nine).
different(two, three).
different(two, four).
different(two, five).
different(two, six).
different(two, seven).
different(two, eight).
different(two, nine).
different(three, four).
different(three, five).
different(three, six).
different(three, seven).
different(three, eight).
different(three, nine).
different(four, five).
different(four, six).
different(four, seven).
different(four, eight).
different(four, nine).
different(five, six).
different(five, seven).
different(five, eight).
different(five, nine).
different(six, seven).
different(six, eight).
different(six, nine).
different(seven, eight).
different(seven, nine).
different(eight, nine).

:- pred distinct(t_num, t_num, t_num, t_num, t_num, t_num, t_num, t_num, t_num).
:- mode distinct(out, out, out, out, out, out, out, out, out) is nondet.
% should be multi???

distinct(A, B, C, D, E, F, G, H, I) :-
    different(A, B), different(A, C), different(A, D), different(A, E), 
    different(A, F), different(A, G), different(A, H), different(A, I), 
    different(B, C), different(B, D), different(B, E), 
    different(B, F), different(B, G), different(B, H), different(B, I), 
    different(C, D), different(C, E), 
    different(C, F), different(C, G), different(C, H), different(C, I), 
    different(D, E), 
    different(D, F), different(D, G), different(D, H), different(D, I), 
    different(E, F), different(E, G), different(E, H), different(E, I), 
    different(F, G), different(F, H), different(F, I), 
    different(G, H), different(G, I), 
    different(H, I). 


%-----------------------------------------------------------------------------%
% define puzzle

:- func to_int(t_num) = int.

to_int(S) = (if conv(S, N) then N else 0).
    
:- pred conv(t_num, int).
:- mode conv(in, out) is det.
:- mode conv(out, in) is semidet.

conv(one, 1).
conv(two, 2).
conv(three, 3).
conv(four, 4).
conv(five, 5).
conv(six, 6).
conv(seven, 7).
conv(eight, 8).
conv(nine, 9).


:- pred row_sum(t_num, t_num, t_num, t_num, int).
:- mode row_sum(in, in, in, out, in) is semidet.
:- mode row_sum(in, in, out, in, in) is semidet.
:- mode row_sum(in, out, in, in, in) is semidet.
:- mode row_sum(out, in, in, in, in) is semidet.

row_sum(X1, X2, X3, X4, SUM) :-
    conv(X1, N1),
    conv(X2, N2),
    conv(X3, N3),
    conv(X4, N4),
    SUM = N1 + N2 + N3 + N4.


:- pred puzzle(list(t_num)).
:- mode puzzle(out) is nondet.

puzzle(R) :-
    distinct(A, B, C, D, E, F, G, H, I),

    row_sum(A, G, H, D, SUM),
    row_sum(B, G, I, E, SUM),
    row_sum(C, H, I, F, SUM),

    SUM = 17,
    A = six,
    F = five,
    R = [A, B, C, D, E, F, G, H, I].

%-----------------------------------------------------------------------------%

main(!IO) :-
    solutions(puzzle, R),
    io.write(R, !IO),
    io.nl(!IO).

