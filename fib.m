% fib.m calculate Fibbonacci numbers
%
% vim: ft=mercury ts=4 sw=4

:- module fib.

:- interface.
:- import_module int, integer, float.

:- func fib_f(float) = float.
:- func fib_i(int) = int.

:- func fib_int_t(int) = int.
:- func fib_bigint_t(integer) = integer.
:- func fib_float_t(int) = float.

%-----------------------------------------------------------------------------%

:- implementation.

%-----------------------------------------------------------------------------%

% naive recursive version
fib_f(N) = (if N =< 2.0 then 1.0 else fib_f(N-1.0) + fib_f(N-2.0)).

fib_i(N) = (if N =< 2 then 1 else fib_i(N-1) + fib_i(N-2)).

%-----------------------------------------------------------------------------%

% tail-recursive version
:- func fib_int_t0({int, int, int}) = {int, int, int}.
fib_int_t0({X, Y, Z}) = ( if Z = 0 then {X, Y, 0} else fib_int_t0({Y, (X+Y), (Z-1)}) ).
fib_int_t(X) = RES :- fib_int_t0({0, 1, X}) = {RES, _, _}.

:- func fib_float_t0({float, float, int}) = {float, float, int}.
fib_float_t0({A, B, N}) = ( if N = 0 then {A, B, 0} else fib_float_t0({B, (A+B), (N-1)}) ).
fib_float_t(N) = RES :- fib_float_t0({0.0, 1.0, N}) = {RES, _, _}.

:- func fib_bigint_t0({integer, integer, integer}) = {integer, integer, integer}.
fib_bigint_t0({A, B, N}) = (
	if N = integer.zero
	then {A, B, integer.zero}
	else fib_bigint_t0({B, (A+B), (N-integer.one)}) ).
fib_bigint_t(N) = RES :- fib_bigint_t0({integer.zero, integer.one, N}) = {RES, _, _}.


