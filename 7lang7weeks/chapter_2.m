% chapter_2.m
% Mercury example problems taken from 
% Seven Languages in Seven Weeks, Prolog Section
%
% vim: ft=Mercury ts=4 sw=4
%

:- module chapter_2.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module int, list, solutions.


%-----------------------------------------------------------------------------%
% define familiy problem
%-----------------------------------------------------------------------------%

:- type family_t
	--->	zeb
	;		john_boy_sr
	;		john_boy_jr.

:- pred father(family_t, family_t).
:- mode father(out, out) is multi.
%:- mode father(in, out) is semidet.
father(zeb, 		john_boy_sr).
father(john_boy_sr,	john_boy_jr).

:- pred ancestor(family_t, family_t).
%:- mode ancestor(out, out) is multi.
:- mode ancestor(in, out) is nondet.
ancestor(X, Y) :- father(X, Y).
ancestor(X, Y) :- father(X, Z), ancestor(Z, Y).

:- pred is_ancestor_of(list(family_t)::out) is nondet.
is_ancestor_of(S) :-
	ancestor(zeb, S1),
	S = [S1].


%-----------------------------------------------------------------------------%
% list math predicates
%-----------------------------------------------------------------------------%

:- pred count(int, list(T)).
:- mode count(out, in) is det.
count(0, []).
count(Count, [_|Tail]) :-
	count(TailCount, Tail),
	Count = TailCount + 1.

:- pred sum(int::out, list(int)::in) is det.
sum(0, []).
sum(Total, [Head|Tail]) :-
	sum(Sum, Tail),
	Total = Head + Sum.

%-----------------------------------------------------------------------------%

main(!IO) :- 
	io.nl(!IO),
	solutions(is_ancestor_of, R1),
	io.write_string("zeb is ancestor of ", !IO),
	io.write(R1, !IO),
	io.nl(!IO), io.nl(!IO),
	io.write_string("Doing some list-math:", !IO),
	io.nl(!IO),
	L1 = [1, 2, 3, 4],
	count(L1_count, L1),
	io.write_string("count(", !IO), io.write(L1, !IO), io.write_string(") = ", !IO),
	io.write(L1_count, !IO), io.nl(!IO),
	sum(L1_sum, L1),
	io.write_string("sum(", !IO), io.write(L1, !IO), io.write_string(") = ", !IO),
	io.write(L1_sum, !IO), io.nl(!IO),
	io.write_string("Finished!", !IO),
	io.nl(!IO).

