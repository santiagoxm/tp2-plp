:- use_module(piezas).

%sublista(+Descartar, +Tomar, +L, -R)
sublista(D ,T, L, R) :- length(LD, D), append(LD, L1, L), 
                        length(R, T), append(R, _, L1).

% Es reversible en el cuarto argumento R, pero no es reversible en el primer
% argumento descartar. Esto se debe a que si D no esta instanciado, length(LD, D)
% genera listas infinitas con longitud D cada vez mas grande, ya que
% LD tampoco esta instanciado, entonces la ejecución no termina
% y se podría decir que el predicado sublista se cuelga.

%tablero(+K, -T)
tablero(K, [F1,F2,F3,F4,F5]) :- length(F1, K), length(F2, K), length(F3, K), length(F4, K), length(F5, K).

%tamaño(+M, -F, -C)
tamaño([], 0, _).
tamaño([M|MS], F, C) :- length(M, C), tamaño(MS, Fm1, C), F is Fm1 + 1.

%coordenadas(+T, -IJ)
coordenadas(T,(I,J)):- tamaño(T,F,C), between(1,F,I), between(1,C,J).

%kPiezas(+K, -PS)
kPiezas(K, PS) :- kPiezasAux(K, 0, PS).
kPiezasAux(0, _, []).
kPiezasAux(K, S,[P|PS]) :- K > 0, nombrePiezas(PI), between(S, 11, N), nth0(N, PI, P),
                           Km1 is K - 1, Np1 is N + 1, kPiezasAux(Km1, Np1, PS).

%seccionTablero(+T, +ALTO, +ANCHO, +IJ, ?ST)
seccionTablero(_, 0, _, _, []).
seccionTablero([T|TS], ALTO, ANCHO, (1,J), [ST|STS]) :- Jm1 is J - 1, sublista(Jm1, ANCHO, T, ST),
                                                        ALTOm1 is ALTO - 1, seccionTablero(TS, ALTOm1, ANCHO, (1, J), STS).
seccionTablero([_|TS], ALTO, ANCHO, (I,J), ST) :- I > 1, Im1 is I - 1, seccionTablero(TS, ALTO, ANCHO, (Im1,J), ST).

%ubicarPieza(+Tablero, +Identificador)
ubicarPieza(T, I) :- coordenadas(T, IJ), pieza(I,P), 
                     tamaño(P, F, C), seccionTablero(T, F, C, IJ, P).

%ubicarPiezas(+Tablero, +Poda, +Identificadores)
ubicarPiezas(_, _, []).
ubicarPiezas(T, P, [I|IS]) :- ubicarPieza(T, I), poda(P, T), ubicarPiezas(T, P, IS).

%llenarTablero(+Poda, +Columnas, -Tablero)
llenarTablero(P, C, T) :- tablero(C, T), kPiezas(C, X), ubicarPiezas(T, P, X).

%cantSoluciones(+Poda, +Columnas, -N)
cantSoluciones(Poda, Columnas, N) :- 
findall(T, llenarTablero(Poda, Columnas, T), TS),
length(TS, N).

% ?- time(cantSoluciones(sinPoda, 3, N)).
% 73,439,864 inferences, 5.291 CPU in 5.321 seconds (99% CPU, 13880117 Lips)
% N = 28.

% ?- time(cantSoluciones(sinPoda, 4, N)).
% 2,847,505,243 inferences, 202.913 CPU in 203.990 seconds (99% CPU, 14033156 Lips)
% N = 200.

%todosGruposLibresModulo5(+Tablero)
todosGruposLibresModulo5(Tablero) :- findall(IJ, ubicacionLibre(Tablero, IJ), Lista), agrupar(Lista, G), maplist(longMod5, G).
longMod5(F):- length(F,N), mod(N, 5)=:=0.

poda(sinPoda, _).
poda(podaMod5, T) :- todosGruposLibresModulo5(T).

ubicacionLibre(Tablero, (I,J)) :- nth1(I, Tablero, Fila), nth1(J, Fila, Columna), var(Columna).

% ?- time(cantSoluciones(podaMod5, 3, N)).
% 26,079,624 inferences, 1.904 CPU in 1.915 seconds (99% CPU, 13697778 Lips)
% N = 28.

% ?- time(cantSoluciones(podaMod5, 4, N)).
% 522,899,929 inferences, 37.558 CPU in 37.744 seconds (100% CPU, 13922380 Lips)
% N = 200.
