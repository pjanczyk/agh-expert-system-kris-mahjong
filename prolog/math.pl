:- module(math, [
  straight_line/2,
  distance/3,
  midpoint/3,
  matrix_size/2
]).

:- use_module(library(clpfd)).

straight_line([_, Y], [_, Y]).
straight_line([X, _], [X, _]).

distance(Distance, [X1, Y1], [X2, Y2]) :-
  Distance #= (abs(X2 - X1) + abs(Y2 - Y1)).

midpoint([XMid, YMid], [X1, Y1], [X2, Y2]) :-
  XMid #= ((X1 + X2) // 2),
  YMid #= ((Y1 + Y2) // 2).

matrix_size([NColumns, NRows], Matrix) :-
  length(Matrix, NRows),
  foreach(member(Row, Matrix), length(Row, NColumns)).
