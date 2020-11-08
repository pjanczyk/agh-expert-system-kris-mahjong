:- use_module(commands).

:- commands:init_board([3, 3]).
:- commands:put_tile([2, 2], y).
:- commands:put_tile([3, 3], y).
:- commands:put_tile([3, 2], x).
:- commands:put_tile([1, 3], x).
:- commands:put_tile([2, 3], y).

:- commands:suggest_moves.
