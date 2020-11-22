:- use_module(board).
:- begin_tests(board).

test(init_board) :-
  board:init_board([
    % 1  2  3  4
    [ a, b, c ], % 1
    [ d, e, - ]  % 2
  ]),
  board:board_size([3, 2]),
  board:tile_at([1, 1], a),
  board:tile_at([2, 1], b),
  board:tile_at([3, 1], c),
  board:tile_at([1, 2], d),
  board:tile_at([2, 2], e),
  board:tile_empty([3, 2]).

:- end_tests(board).
