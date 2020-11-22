:- module(commands, [
    init_board/1,
    put_tile/2,
    remove_tiles/2,
    suggest_move/2
]).

:- use_module(board).
:- use_module(rules).
:- use_module(math).

init_board([SizeX, SizeY]) :-
  retractall(board:board_size(_, _)),
  retractall(board:tile_at(_, _)),
  assertz(board:board_size(SizeX, SizeY)).

set_board(Size, Tiles) :-
  init_board(Size),
  put_tiles(Tiles).

remove_tiles(Pos1, Pos2) :-
  rules:can_remove_tiles(Pos1, Pos2),
  retractall(board:tile_at(Pos1, _)),
  retractall(board:tile_at(Pos2, _)).

suggest_move(Pos1, Pos2) :-
  rules:suggested_tiles_to_remove(Pos1, Pos2).

suggest_moves :-
  findall([Pos1, Pos2], rules:suggested_move(Pos1, Pos2), Moves),
  print(Moves).
