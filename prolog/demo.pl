:- use_module(api).

:- api:init_board([
  % 1  2  3  4
  [ a, 2, c, 2 ], % 1
  [ 1, 1, g, h ], % 2
  [ 2, -, 2, l ], % 3
  [ m, n, o, p ]  % 4
]).

:- api:suggest_moves(Moves), print(Moves), nl.

:- api:remove_tiles([1, 2], [2, 2]).

:- api:suggest_moves(Moves), print(Moves), nl.

:- api:remove_tiles([2, 1], [4, 1]).

:- api:suggest_moves(Moves), print(Moves), nl.

:- api:remove_tiles([1, 3], [3, 3]).
