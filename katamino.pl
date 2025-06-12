:- use_module(piezas).
%consult('katamino.pl').
sufijo(L, P) :- append(_, P, L).
prefijo(L, P) :- append(P, _, L).
%sublista(Descartar, Tomar, L, R) :- sufijo(L,Suf), append(R, _, Suf), length(R, Tomar), prefijo(L, Pref), length(Pref, Descartar), append(Pref, Suf, L).
sublista(Descartar, Tomar, L, R) :- prefijo(L, Pref), length(Pref, Descartar), subtract(L, Pref, Lnueva), prefijo(Lnueva, R), length(R, Tomar).

igualLongitud(0,[]).
igualLongitud(K, [H|[]]):- length(H, K).
igualLongitud(K, [H|T]):- length(H,K), igualLongitud(K,T).

tablero(K, [A,B,C,D,E|[]]) :- length(A, K), length(B, K), length(C, K), length(D, K), length(E, K).

tamaño([], 0, _).
tamaño([M|MS], F, C) :- length(M, C), tamaño(MS, Fm1, C), F is Fm1 + 1.

%tamaño([],0,0).
%tamaño(M,F,C) :- length(M,F), igualLongitud(C, M).

coordenadas(T,(I,J)):- tamaño(T,F,C), numlist(1,F,Filas), member(I,Filas), numlist(1,C,Columnas), member(J, Columnas).

kPiezas(K, PS) :- 