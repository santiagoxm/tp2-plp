:- use_module(piezas).

%sublista(+Descartar, +Tomar, +L, -R)
sublista(Descartar,Tomar, L, R) :- length(LD, Descartar), append(LD, L1, L), 
                                   length(R, Tomar), append(R, _, L1).

%tablero(+K, -T)
tablero(K, [A,B,C,D,E|[]]) :- length(A, K), length(B, K), length(C, K), length(D, K), length(E, K).

%tamaño(+M, -F, -C)
tamaño([], 0, _).
tamaño([M|MS], F, C) :- length(M, C), tamaño(MS, Fm1, C), F is Fm1 + 1.

%coordenadas(+T, -IJ)
coordenadas(T,(I,J)):- tamaño(T,F,C), between(1,F,I), between(1,C,J).

%kPiezas(+K, -PS)
kPiezas(K, PS) :- kPiezasAux(K, 0, PS).
kPiezasAux(0, _, []).
kPiezasAux(K, S,[P|PS]) :- nombrePiezas(PI), between(S, 11, N), nth0(N, PI, P), 
                           Km1 is K - 1, Np1 is N + 1, kPiezasAux(Km1, Np1, PS).
%                 ^ promete




%Hacer que sea el resultado de sublista desde 0 hasta 12, agarrando 1 cada vez

%kPiezas(K, PS) :- length(PS, 3), nombrePiezas(X), 
%kPiezasAux(0,[],_).
%kPiezasAux(1,[P],I):- nombrePiezas(X), member(P,X), nth0(I,X,P).
%kPiezasAux(K,[P|PS],I):- K>1, nombrePiezas(X), nth0(I,X,P), H is I+1, between(H,11,J), Km1 is K - 1, kPiezasAux(Km1,PS,J).
%kPiezas(K,PS):-kPiezasAux(K,PS,_).
%kPiezasAux(K,[P|PS],Lista):- length(L,Lista), length(K,PS), K>=L, length(K,PS), .


%kPiezas(K,PS):- nombrePiezas(X), kPiezasAux(K,PS,X).

%conj(0, _, []).
%conj(K, L, PS) :- member(E,L), delete(L,E,Lse), 

%conj(0, _, []).
%conj(K, L, [P|PS]) :- member(P,L), delete(L,P,LsP), Km1 is K - 1, conj(Km1, LsP, PS).

%kPiezas(K, PS) :- nombrePiezas(X), between(0, 12, N), Np1 is N + 1, between(Np1, 12, N2), 
%                  N2p1 is N2 + 1, between(N2p1, 12, N3),
%                  sublista(N, 1, X, E1), sublista(N2, 1, X, E2), sublista(N3, 1, X, E3),
%                  append(E1, E2, E1E2), append(E1E2, E3, PS).