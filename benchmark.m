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

main(!IO) :-

	% Fibonacci numbers
	% =================
	benchmark_func(fib_i, 35, Res_i, 10, Elapsed_i),
	io.format("fib_i(35) = %d (Elapsed time for 10 repetitions: %dms)\n",
		[i(Res_i), i(Elapsed_i)], !IO),
	io.nl(!IO),

	benchmark_func(fib_f, 35.0, Res_f, 10, Elapsed_f),
	io.format("fib_f(35) = %.0f (Elapsed time for 10 repetitions: %dms)\n",
		[f(Res_f), i(Elapsed_f)], !IO),
	io.nl(!IO),

	benchmark_func(fib_int_t, 35, Res_int_t, 100, Elapsed_int_t),
	io.format("fib_int_t(35) = %d (Elapsed time for 100 repetitions: %dms)\n",
		[i(Res_int_t), i(Elapsed_int_t)], !IO),
	io.nl(!IO),

	benchmark_func(fib_float_t, 1000, Res_float_t, 1000, Elapsed_float_t),
	io.format("fib_float_t(1000) = %.0f (Elapsed time for 1000 repetitions: %dms)\n",
		[f(Res_float_t), i(Elapsed_float_t)], !IO),
	io.nl(!IO),

	benchmark_func(fib_bigint_t, integer.integer(1000), Res_bigint_t, 1000, Elapsed_bigint_t),
	io.format("fib_bigint_t(1000) = %s (Elapsed time for 1000 repetitions: %dms)\n",
		[s(integer.to_string(Res_bigint_t)), i(Elapsed_bigint_t)], !IO),
	io.nl(!IO),

	% Perfect numbers
	% ===============
	benchmark_det(perfect_numbers, 10000, PN, 10, Elapsed_pn),
	io.write_string("Perfect Numbers: ", !IO),
	io.write(PN, !IO),
	io.format(" (Elapsed time for 10 repetitions: %dms)\n", [i(Elapsed_pn)], !IO),
	io.nl(!IO).

