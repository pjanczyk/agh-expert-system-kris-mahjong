:- module(math, [
  straight_line/2,
  distance/3,
  midpoint/3
]).

straight_line([_, Y], [_, Y]) :- true, !.
straight_line([X, _], [X, _]) :- true, !.

distance(Distance, [X1, Y1], [X2, Y2]) :-
  Distance is (abs(X2 - X1) + abs(Y2 - Y1)).

midpoint([XMid, YMid], [X1, Y1], [X2, Y2]) :-
  XMid is ((X1 + X2) // 2),
  YMid is ((Y1 + Y2) // 2).
