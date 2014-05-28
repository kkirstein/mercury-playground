% chapter_1.m
% Mercury example problems taken from 
% Seven Languages in Seven Weeks, Prolog Section
%
% vim: ft=Mercury ts=4 sw=4
%

:- module chapter_1.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module list, solutions.

%-----------------------------------------------------------------------------%
% define food problem
%-----------------------------------------------------------------------------%

:- type t_product
	--->	velveeta
	;		ritz
	;		spam
	;		sausage
	;		jolt
	;		twinkie.

:- type t_kind
	--->	cheese
	;		cracker
	;		meat
	;		soda
	;		dessert.

:- type t_flavor
	--->	sweet
	;		savory.

:- pred food_type(t_product, t_kind).
:- mode food_type(in, out) is det.
:- mode food_type(out, in) is multi.
food_type(velveeta, cheese).
food_type(ritz, cracker).
food_type(spam, meat).
food_type(sausage, meat).
food_type(jolt, soda).
food_type(twinkie, dessert).

:- pred flavor(t_flavor, t_kind). 
:- mode flavor(in, out) is multi. 
:- mode flavor(out, in) is semidet. 
flavor(sweet, dessert).
flavor(savory, meat).
flavor(savory, cheese).
flavor(sweet, soda).

:- pred food_flavor(t_product, t_flavor).
:- mode food_flavor(in, out) is semidet.
:- mode food_flavor(out, in) is multi.
food_flavor(X, Y) :- food_type(X, Z), flavor(Y, Z).

:- pred solve_food_type(t_product::out) is multi.
solve_food_type(R) :-
	food_type(What, meat),
	R = What.

:- pred solve_food_flavor(t_product::out) is multi.
solve_food_flavor(R) :- food_flavor(R, savory).


%-----------------------------------------------------------------------------%
% define color problem
%-----------------------------------------------------------------------------%

:- type t_color
	--->	red
	;		green
	;		blue.

:- pred different(t_color, t_color).
%%:- mode different(in, out) is multi.
%%:- mode different(out, in) is multi.
:- mode different(out, out) is multi.
different(red, green).
different(red, blue).
different(green, red).
different(green, blue).
different(blue, red).
different(blue, green).

:- pred coloring(t_color, t_color, t_color, t_color, t_color).
%%:- mode coloring(in, in, in, in, out) is nondet.
%%:- mode coloring(in, in, in, out, in) is nondet.
%%:- mode coloring(in, in, out, in, in) is nondet.
%%:- mode coloring(in, out, in, in, in) is nondet.
%%:- mode coloring(out, in, in, in, in) is nondet.
:- mode coloring(out, out, out, out, out) is nondet.
coloring(Alabama, Mississippi, Georgia, Tennessee, Florida) :-
	different(Mississippi, Tennessee),
	different(Mississippi, Alabama),
	different(Alabama, Tennessee),
	different(Alabama, Mississippi),
	different(Alabama, Georgia),
	different(Alabama, Florida),
	different(Georgia, Florida),
	different(Georgia, Tennessee).

:- pred solve_coloring(list(t_color)::out) is nondet.
solve_coloring(R) :-
	coloring(A, M, G, T, F),
	R = [A, M, G, T, F].

%-----------------------------------------------------------------------------%

main(!IO) :- 
	io.write_string("Let's go...", !IO),
	io.nl(!IO),	
	solutions(solve_food_type, R1),
	io.write(R1, !IO),
	io.nl(!IO),
	solutions(solve_food_flavor, R2),
	io.write(R2, !IO),
	io.nl(!IO),
	solutions(solve_coloring, R3),
	io.write_string("[Alabama, Mississippi, Georgia, Tennessee, Florida]", !IO),
	io.nl(!IO),
	io.write(R3, !IO),
	io.nl(!IO).

