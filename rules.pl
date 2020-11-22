:- module(rules, [
  suggested_tiles_to_remove/2,
  can_remove_tiles/2
]).

:- use_module(board).
:- use_module(math).

suggested_tiles_to_remove(Pos1, Pos2) :-
  in_board(Pos1),
  in_board(Pos2),
  math:points_totally_ordered(Pos1, Pos2),
  can_remove_tiles(Pos1, Pos2).

can_remove_tiles(Pos1, Pos2) :-
  tiles_of_same_type(Pos1, Pos2),
  connected_by_path(Pos1, Pos2).

tiles_of_same_type(Pos1, Pos2) :-
  board:tile_at(Pos1, TileType),
  board:tile_at(Pos2, TileType).

connected_by_path(Pos1, Pos2) :-
  connected_by_straight_path(Pos1, Pos2) ;
  connected_by_path_with_1_turn(Pos1, Pos2) ;
  connected_by_path_with_2_turns(Pos1, Pos2).

connected_by_straight_path(Pos1, Pos2) :-
  math:distance(1, Pos1, Pos2).

connected_by_straight_path(Pos1, Pos2) :- 
  math:straight_line(Pos1, Pos2),
  math:distance(Distance, Pos1, Pos2),
  Distance >= 2,
  math:midpoint(Middle, Pos1, Pos2),
  board:tile_empty(Middle),
  connected_by_straight_path(Pos1, Middle),
  connected_by_straight_path(Middle, Pos2).

connected_by_path_with_1_turn(Pos1, Pos2) :-
  in_board_or_adjacent(Turn),
  tile_empty(Turn),
  connected_by_straight_path(Pos1, Turn),
  connected_by_straight_path(Turn, Pos2).

connected_by_path_with_2_turns(Pos1, Pos2) :-
  in_board_or_adjacent(Turn),
  board:tile_empty(Turn),
  connected_by_straight_path(Pos1, Turn),
  connected_by_path_with_1_turn(Turn, Pos2).

in_board([X, Y]) :-
  board:board_size([SizeX, SizeY]),
  between(1, SizeX, X),
  between(1, SizeY, Y).

in_board_or_adjacent([X, Y]) :-
  board:board_size([SizeX, SizeY]),
  MinX is 0,
  MaxX is SizeX + 1,
  MinY is 0,
  MaxY is SizeY + 1,
  between(MinX, MaxX, X),
  between(MinY, MaxY, Y).
