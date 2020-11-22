:- module(math, [
  straight_line/2,
  distance/3,
  midpoint/3,
  points_totally_ordered/2,
  matrix_size/2
]).

straight_line([_, Y], [_, Y]) :- true, !.
straight_line([X, _], [X, _]) :- true, !.

distance(Distance, [X1, Y1], [X2, Y2]) :-
  Distance is (abs(X2 - X1) + abs(Y2 - Y1)).

midpoint([XMid, YMid], [X1, Y1], [X2, Y2]) :-
  XMid is ((X1 + X2) // 2),
  YMid is ((Y1 + Y2) // 2).

points_totally_ordered([X1, Y1], [X2, Y2]) :-
  X1 < X2;
  (X1 = X2, Y1 < Y2).

matrix_size([NRows, NColumns], Matrix) :-
  length(Matrix, NRows),
  foreach(member(Row, Matrix), length(Row, NColumns)).
