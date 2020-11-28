:- module(board, [
  board_size/1,
  tile_at/2,
  tile_empty/1,
  init_board/1,
  put_tile/2,
  remove_tile/1
]).

:- use_module(math).

:- dynamic board_size/1. % board_size([X, Y])
:- dynamic tile_at/2.    % tile_at([X, Y], Tile)

tile_empty(Pos) :-
  \+ tile_at(Pos, _).

init_board(TileMatrix) :-
  math:matrix_size(Size, TileMatrix),
  init_empty_board(Size),
  put_tiles(TileMatrix).

init_empty_board(Size) :-
  retractall(board_size(_)),
  retractall(tile_at(_, _)),
  assertz(board_size(Size)).

put_tiles(Matrix) :-
  put_tiles_(1, Matrix).
put_tiles_(_, []).
put_tiles_(CurrentY, [Row|Rows]) :-
  put_tile_row(CurrentY, Row),
  NextY is CurrentY + 1,
  put_tiles_(NextY, Rows).

put_tile_row(Y, Row) :-
  put_tile_row_(Y, 1, Row).  
put_tile_row_(_, _, []).
put_tile_row_(Y, CurrentX, [Tile|Tiles]) :-
  put_tile([CurrentX, Y], Tile),
  NextX is CurrentX + 1,
  put_tile_row_(Y, NextX, Tiles).

put_tile(_, -).
put_tile(_, "-").
put_tile(Pos, Tile) :-
  assertz(tile_at(Pos, Tile)).

remove_tile(Pos) :-
  retractall(tile_at(Pos, _)).
