:- module(commands, [
    init_board/1,
    put_tile/2,
    remove_tiles/2,
    suggest_move/2
]).

:- use_module(rules).
:- use_module(math).

init_board([SizeX, SizeY]) :-
  retractall(rules:board_size(_, _)),
  retractall(rules:tile_at(_, _)),
  assertz(rules:board_size(SizeX, SizeY)).

put_tile(Pos, TileType) :-
  assertz(rules:tile_at(Pos, TileType)).

remove_tiles(Pos1, Pos2) :-
  rules:can_remove_tiles(Pos1, Pos2),
  retractall(rules:tile_at(Pos1, _)),
  retractall(rules:tile_at(Pos2, _)).

suggest_move(Pos1, Pos2) :-
  rules:in_board(Pos1),
  rules:in_board(Pos2),
  math:points_totally_ordered(Pos1, Pos2),
  rules:can_remove_tiles(Pos1, Pos2).

suggest_moves :-
  findall([Pos1, Pos2], suggest_move(Pos1, Pos2), Moves),
  print(Moves).
