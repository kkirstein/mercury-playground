% mandelbrot.m
% demonstrate Mandelbrot set in Mercury
%
% vim: ft=mercury sw=4 ts=4

:- module mandelbrot.

:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

%-----------------------------------------------------------------------------%

:- implementation.
:- import_module complex_numbers.

%-----------------------------------------------------------------------------%

main(!IO) :-
	io.write_string("Calculating Mandelbrot set...", !IO),
	io.nl(!IO).

