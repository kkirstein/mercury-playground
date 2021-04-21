% benchmark.m Various benchmarks for the Mercury compiler
%
% vim: ft=mercury ts=4 sw=4 et

:- module benchmark.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is cc_multi.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module int, float, list, string, integer.
:- import_module fib.
:- import_module perfect_number.
:- import_module mandelbrot.
:- import_module benchmarking.

%-----------------------------------------------------------------------------%

:- pred time_fun_scalar(string, func(T1) = T2, T1, T2, int, io, io).
:- mode time_fun_scalar(in, func(in) = out is det, in, out, in, di, uo)
    is cc_multi.

time_fun_scalar(NAME, FUN, IN, RESULT, REP, !IO) :-
    benchmark_func(FUN, IN, RESULT, REP, Elapsed),
    io.format("%s = ", [s(NAME)], !IO),
    io.write(RESULT, !IO),
    io.format("\nElapsed time %dms for %d repetitions (%.3fms/run).\n",
        [i(Elapsed), i(REP), f(float(Elapsed)/float(REP))], !IO).

:- pred time_fun_integer(string, func(T1) = integer, T1, int, io, io).
:- mode time_fun_integer(in, func(in) = out is det, in, in, di, uo) is cc_multi.

time_fun_integer(NAME, FUN, IN, REP, !IO) :-
    benchmark_func(FUN, IN, RESULT, REP, Elapsed),
    io.format("%s = ", [s(NAME)], !IO),
    io.write(integer.to_string(RESULT), !IO),
    io.format("\nElapsed time %dms for %d repetitions (%.3fms/run).\n",
        [i(Elapsed), i(REP), f(float(Elapsed)/float(REP))], !IO).
    
%-----------------------------------------------------------------------------%

main(!IO) :-

    % Fibonacci numbers
    % =================
    Inp1 = 35,
    Inp2 = integer.integer(1000),

    time_fun_scalar(string.format("fib(%d) (int)", [i(Inp1)]),
        fib_i, Inp1, _, 10, !IO),
    io.nl(!IO),

    time_fun_scalar(string.format("fib(%d) (int, tail-recursive) ", [i(Inp1)]),
        fib_int_t, Inp1, _, 1000, !IO),
    io.nl(!IO),

    time_fun_integer(string.format("fib(%s) (bigint, tail-recursive) ",
        [s(integer.to_string(Inp2))]), fib_bigint_t, Inp2, 1000, !IO),
    io.nl(!IO),

    % Perfect numbers
    % ===============
    benchmark_det(perfect_numbers, 10000, PN, 10, Elapsed_pn),
    io.write_string("Perfect Numbers: ", !IO),
    io.write(PN, !IO),
    io.nl(!IO),
    io.format("Elapsed time %dms for %d repetitions (%.3fms/run).\n",
        [i(Elapsed_pn), i(10), f(float(Elapsed_pn)/float(10))], !IO),
    io.nl(!IO),

    % Finished
    % ========
    %io.write_string("Press <ENTER> to continue..", !IO),
    %io.read_char(stdin_stream, _, !IO).
    io.nl(!IO).

