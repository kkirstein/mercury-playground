% mandelbrot.m
% demonstrate Mandelbrot set in Mercury
%
% vim: ft=mercury sw=4 ts=4 et

:- module mandelbrot.

:- interface.
:- import_module int, float, list.

:- pred mandelbrot(int::in, int::in,
    float::in, float::in, float::in,
    list(int)::out) is det.

%-----------------------------------------------------------------------------%

:- implementation.
%:- import_module complex_numbers.

%-----------------------------------------------------------------------------%

:- pred pixel_value(float::in, float::in, int::out) is det.
pixel_value(X, Y, N) :-
    N = 0.

%-----------------------------------------------------------------------------%

mandelbrot(XMAX, YMAX, XCENTER, YCENTER, PIXELSIZE, IMAGE) :-
    IMAGE = [].

