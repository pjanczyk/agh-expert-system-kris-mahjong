:- use_module(api).

:- api:init_board([
  % 1  2  3  4
  [ a, ♥, c, ♥ ], % 1
  [ ♦, ♦, g, h ], % 2
  [ i, ♣, -, ♣ ], % 3
  [ m, n, o, p ]  % 4
]).

:- api:suggest_moves(Moves), print(Moves).
