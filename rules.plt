:- use_module(rules).
:- begin_tests(rules).

test('Can remove adjacent tiles of same type', [cleanup(retractall(rules:tile_at(_, _)))]) :-
  %     1 2
  %   1 . x
  %   2 x x
  asserta(rules:board_size(2, 2)),
  asserta(rules:tile_at([1, 2], x)),
  asserta(rules:tile_at([2, 1], x)),
  asserta(rules:tile_at([2, 2], x)),
  rules:can_remove_tiles([1, 2], [2, 2]),
  rules:can_remove_tiles([2, 1], [2, 2]).

test('Cannot remove tiles of different type', [cleanup(retractall(rules:tile_at(_, _)))]) :-
  asserta(rules:board_size(2, 2)),
  asserta(rules:tile_at([1, 1], a)),
  asserta(rules:tile_at([1, 2], b)),
  \+ rules:can_remove_tiles([1, 1], [1, 2]).

test('Can remove tiles connected by straight path', [cleanup(retractall(rules:tile_at(_, _)))]) :-
  %     1 2 3 4
  %   1 . x . x
  %   2 . . . .
  %   3 . . . .
  %   4 . x . .
  asserta(rules:board_size(4, 4)),
  asserta(rules:tile_at([2, 1], x)),
  asserta(rules:tile_at([4, 1], x)),
  asserta(rules:tile_at([2, 4], x)),
  rules:can_remove_tiles([2, 1], [4, 1]),
  rules:can_remove_tiles([2, 1], [2, 4]).

test('Can remove tiles connected by path with 1 turn', [cleanup(retractall(rules:tile_at(_, _)))]) :-
  %     1 2 3 4
  %   1 . . . x
  %   2 . . . .
  %   3 x . . .
  asserta(rules:board_size(4, 3)),
  asserta(rules:tile_at([4, 1], x)),
  asserta(rules:tile_at([1, 3], x)),
  rules:can_remove_tiles([4, 1], [1, 3]).

test('Can remove tiles connected by path with 2 turns', [cleanup(retractall(rules:tile_at(_, _)))]) :-
  %     1 2 3
  %   1 . . .
  %   2 . y x
  %   3 x y y
  asserta(rules:board_size(3, 3)),
  asserta(rules:tile_at([2, 2], y)),
  asserta(rules:tile_at([3, 2], x)),
  asserta(rules:tile_at([1, 3], x)),
  asserta(rules:tile_at([2, 3], y)),
  asserta(rules:tile_at([3, 3], y)),
  rules:can_remove_tiles([1, 3], [3, 2]).

:- end_tests(rules).
