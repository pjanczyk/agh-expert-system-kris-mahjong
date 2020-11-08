:- module(commands, [
    init_board/1,
    put_tile/2,
    remove_tiles/2
])

:- use_module(rules).

init_board([SizeX, SizeY]) :-
  retractall(board_size(_, _)),
  retractall(tile_at(_, _)),
  assertz(board_size(SizeX, SizeY)).

put_tile(Pos, TileType) :-
  assertz(tile_at(Pos, TileType)).

remove_tiles(Pos1, Pos2) :-
  can_remove_tiles(Pos1, Pos2),
  retractall(tile_at(Pos1, _)),
  retractall(tile_at(Pos2, _)).

