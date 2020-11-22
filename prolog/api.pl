:- module(api, [
    init_board/1,
    remove_tiles/2,
    suggest_move/2,
    suggest_moves/1
]).

:- use_module(board).
:- use_module(rules).

init_board(TileMatrix) :-
  board:init_board(TileMatrix).

can_remove_tiles(Pos1, Pos2) :-
  rules:can_remove_tiles(Pos1, Pos2).

remove_tiles(Pos1, Pos2) :-
  rules:can_remove_tiles(Pos1, Pos2),
  board:remove_tile(Pos1),
  board:remove_tile(Pos2).

suggest_move(Pos1, Pos2) :-
  rules:suggested_tiles_to_remove(Pos1, Pos2).

suggest_moves(Moves) :-
  setof([Pos1, Pos2], rules:suggested_tiles_to_remove(Pos1, Pos2), Moves).
