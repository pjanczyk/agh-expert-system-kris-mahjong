:- use_module(commands).

%     1 2 3 4
%   1 . . . .
%   2 . y x .
%   3 x y y .
%   4 z . . .
:- commands:init_board([4, 4]).
:- commands:put_tile([2, 2], y).
:- commands:put_tile([3, 3], y).
:- commands:put_tile([3, 2], x).
:- commands:put_tile([1, 3], x).
:- commands:put_tile([2, 3], y).
:- commands:put_tile([1, 4], z).

:- commands:suggest_moves.
