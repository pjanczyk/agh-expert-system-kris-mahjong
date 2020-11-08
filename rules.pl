:- module(rules, [
  can_remove_tiles/2,
  board_size/2,
  tile_at/2
]).

:- use_module(math).

:- dynamic board_size/2.
:- dynamic tile_at/2.

in_board([X, Y]) :-
  board_size(XSize, YSize),
  between(1, XSize, X),
  between(1, YSize, Y).

tile_empty(Pos) :-
  \+ tile_at(Pos, _).

can_remove_tiles(Pos1, Pos2) :-
  tiles_of_same_type(Pos1, Pos2),
  connected_by_path(Pos1, Pos2).

tiles_of_same_type(Pos1, Pos2) :-
  tile_at(Pos1, TileType),
  tile_at(Pos2, TileType).

connected_by_path(Pos1, Pos2) :-
  connected_by_straight_path(Pos1, Pos2);
  connected_by_path_with_1_turn(Pos1, Pos2);
  connected_by_path_with_2_turns(Pos1, Pos2).

connected_by_straight_path(Pos1, Pos2) :-
  math:distance(Distance, Pos1, Pos2),
  Distance =:= 1.

connected_by_straight_path(Pos1, Pos2) :- 
  math:straight_line(Pos1, Pos2),
  math:distance(Distance, Pos1, Pos2),
  Distance >= 2,
  math:midpoint(Middle, Pos1, Pos2),
  tile_empty(Middle),
  connected_by_straight_path(Pos1, Middle),
  connected_by_straight_path(Middle, Pos2).

connected_by_path_with_1_turn(Pos1, Pos2) :-
  in_board(Turn),
  tile_empty(Turn),
  connected_by_straight_path(Pos1, Turn),
  connected_by_straight_path(Turn, Pos2).

connected_by_path_with_2_turns(Pos1, Pos2) :-
  in_board(Turn),
  tile_empty(Turn),
  connected_by_straight_path(Pos1, Turn),
  connected_by_path_with_1_turn(Turn, Pos2).
