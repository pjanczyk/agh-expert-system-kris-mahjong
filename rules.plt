:- use_module(rules).
:- begin_tests(rules).


% Helper rules

set_board(Matrix) :-
  retractall(board:board_size(_)),
  retractall(board:tile_at(_, _)),
  math:matrix_size(Size, Matrix),
  assertz(board:board_size(Size)),
  set_tile_rows(1, Matrix).

set_tile_rows(_, []).
set_tile_rows(CurrentY, [Row|Rows]) :-
  set_tile_row(CurrentY, 1, Row),
  NextY is CurrentY + 1,
  set_tile_rows(NextY, Rows).

set_tile_row(_, _, []).
set_tile_row(Y, CurrentX, [Tile|Tiles]) :-
    set_tile([CurrentX, Y], Tile),
    NextX is CurrentX + 1,
    set_tile_row(Y, NextX, Tiles).

set_tile(_, -).
set_tile(Pos, Tile) :-
  assertz(board:tile_at(Pos, Tile)).

test('Can remove adjacent tiles of same type') :-
  set_board([
    % 1  2  3  4
    [ ♢, ♢, ♢, ♢ ], % 1
    [ ♢, ♣, ♣, ♢ ], % 2
    [ ♢, ♣, ♢, ♢ ], % 3
    [ ♢, ♢, ♢, ♢ ]  % 4
  ]),
  rules:can_remove_tiles([2, 2], [2, 3]),
  rules:can_remove_tiles([2, 2], [3, 2]).

test('Cannot remove tiles of different type') :-
  set_board([
    % 1  2
    [ ♣, ♥ ] % 1
  ]),
  \+ rules:can_remove_tiles([1, 1], [1, 2]).

test('Can remove tiles connected by straight path') :-
  set_board([
    % 1  2  3  4  5
    [ ♢, ♢, ♢, ♥, ♢ ], % 1
    [ ♣, -, -, -, ♣ ], % 2
    [ ♢, ♢, ♢, ♥, ♢ ]  % 3
  ]),
  rules:can_remove_tiles([1, 2], [5, 2]),
  rules:can_remove_tiles([4, 1], [4, 3]).

test('Can remove tiles connected by path with 1 turn') :-
  set_board([
    % 1  2  3  4  5
    [ ♢, ♣, ♢, ♢, ♢ ], % 1
    [ ♢, -, ♢, ♢, ♢ ], % 2
    [ ♢, -, -, -, ♣ ], % 3
    [ ♢, ♢, ♢, ♢, ♢ ]  % 4
  ]),
  rules:can_remove_tiles([2, 1], [5, 3]).

test('Can remove tiles connected by path with 2 turns') :-
  set_board([
    % 1  2  3  4  5
    [ ♢, ♢, ♢, ♢, ♢ ], % 1
    [ ♢, ♣, ♢, ♢, ♢ ], % 2
    [ ♢, -, ♢, ♣, ♢ ], % 3
    [ ♢, -, -, -, ♢ ], % 4
    [ ♢, ♢, ♢, ♢, ♢ ]  % 5
  ]),
  rules:can_remove_tiles([2, 2], [4, 3]).

test('Can remove tiles connected by path with 2 turns outside board') :-
  set_board([
    % 1  2  3  4 
    [ ♣, ♢, ♢, ♣ ], % 1
    [ ♢, ♢, ♢, ♢ ], % 2
    [ ♣, ♢, ♣, ♢ ]  % 3
  ]),
  rules:can_remove_tiles([1, 1], [4, 1]),
  rules:can_remove_tiles([1, 1], [1, 3]),
  rules:can_remove_tiles([1, 3], [3, 3]).

test('Cannot remove not connected tiles') :-
  set_board([
    % 1  2  3  4 
    [ ♢, ♣, ♢, ♢ ], % 1
    [ ♢, ♢, ♢, ♢ ], % 2
    [ ♢, ♣, ♢, ♣ ], % 3
    [ ♢, ♢, ♢, ♢ ]  % 4
  ]),
  \+ rules:can_remove_tiles([2, 1], [2, 3]),
  \+ rules:can_remove_tiles([2, 1], [4, 3]),
  \+ rules:can_remove_tiles([2, 3], [4, 3]).


:- end_tests(rules).
