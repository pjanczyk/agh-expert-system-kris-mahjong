:- module(board, [
  board_size/1,
  tile_at/2,
  tile_empty/1
]).

:- dynamic board_size/1. % board_size([X, Y])
:- dynamic tile_at/2.    % tile_at([X, Y], Tile)

tile_empty(Pos) :-
  \+ tile_at(Pos, _).
