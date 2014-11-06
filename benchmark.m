% benchmark.m Various benchmarks for the Mercury compiler
%
% vim: ft=mercury ts=4 sw=4

:- module benchmark.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is cc_multi.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module int, float, list, string, integer.
:- import_module fib.
:- import_module perfect_number.
:- import_module benchmarking.

%-----------------------------------------------------------------------------%

:- pred time_fun(string, func(T1) = T2, T1, T2, int, io, io).
:- mode time_fun(in, func(in) = out is det, in, out, in, di, uo) is cc_multi.

time_fun(NAME, FUN, IN, RESULT, REP, IO_IN, IO_OUT) :-
	benchmark_func(FUN, IN, RESULT, REP, Elapsed),
	io.format("%s = ", [s(NAME)], IO_IN, IO_1),
	io.write(RESULT, IO_1, IO_2),
	io.format("\nElapsed time %dms for %d repetitions (%.3fms/run).\n",
		[i(Elapsed), i(REP), f(float(Elapsed)/float(REP))], IO_2, IO_OUT).

%-----------------------------------------------------------------------------%

main(!IO) :-

	% Fibonacci numbers
	% =================
	Inp1 = 35,
	Inp2 = integer.integer(1000),

	time_fun(string.format("fib(%d) (int)", [i(Inp1)]),
		fib_i, Inp1, _, 10, !IO),
	io.nl(!IO),

	time_fun(string.format("fib(%d) (int, tail-recursive) ", [i(Inp1)]),
		fib_int_t, Inp1, _, 1000, !IO),
	io.nl(!IO),

	time_fun(string.format("fib(%s) (bigint, tail-recursive) ", [s(integer.to_string(Inp2))]),
		fib_bigint_t, Inp2, _, 1000, !IO),
	io.nl(!IO),

	% Perfect numbers
	% ===============
	benchmark_det(perfect_numbers, 10000, PN, 10, Elapsed_pn),
	io.write_string("Perfect Numbers: ", !IO),
	io.write(PN, !IO),
	io.format(" (Elapsed time for 10 repetitions: %dms)\n", [i(Elapsed_pn)], !IO),
	io.nl(!IO).

