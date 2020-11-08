:- use_module(['math.pl']).
:- begin_tests(math).

test(straight_line) :-
  math:straight_line([1, 1], [1, 3]),
  math:straight_line([3, 0], [1, 0]),
  \+ math:straight_line([1, 1], [2, 3]).

test(distance) :-
  math:distance(0, [3, 3], [3, 3]),
  math:distance(1, [2, 3], [2, 4]),
  math:distance(2, [1, 2], [2, 1]).

test(midpoint) :-
  math:midpoint([5, 4], [9, 3], [2, 5]).

:- end_tests(math).
