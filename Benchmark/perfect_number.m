% perfect_number.m calculate perfect numbers
%
% vim: ft=mercury ts=4 sw=4

:- module perfect_number.

:- interface.
:- import_module int, list.

:- func perfect_numbers(int) = list(int).
:- pred perfect_numbers(int::in, list(int)::out) is det.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module bool, solutions.

%-----------------------------------------------------------------------------%
% helper predicates

:- pred is_perfect(int::in) is semidet.
:- pred loop_sum(int::in, int::in, int::in) is semidet.

loop_sum(SUM, I, N) :- (
	if I = N then SUM = N
	else
		if (N mod I) = 0 then loop_sum(SUM+I, I+1, N)
		else loop_sum(SUM, I+1, N)).

is_perfect(N) :- loop_sum(0, 1, N).


%-----------------------------------------------------------------------------%
perfect_numbers(N, PN) :-
	list.filter(is_perfect, 1..N, PN).
	
perfect_numbers(N) = PN :- perfect_numbers(N, PN).

