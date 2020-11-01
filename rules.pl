:- dynamic board_size/2.
:- dynamic tile_at/2.
:- dynamic tile_empty/1.

tile_type(tileA).
tile_type(tileB).
tile_type(tileC).
tile_type(tileD).

range(x, 1, Xmax) :- board_size(Xmax, _), !.
range(y, 1, Ymax) :- board_size(_, Ymax), !.

in_range(Axis, X) :- range(Axis, Min, Max), X >= Min, X =< Max.
in_board([X, Y]) :- integer(X), integer(Y), in_range(x, X), in_range(y, Y).

are_of_same_type(Pos1, Pos2) :- 
  in_board(Pos1),
  in_board(Pos2),
  tile_type(Tile_type),
  tile_at(Pos1, Tile_type),
  tile_at(Pos2, Tile_type),
  !.

can_remove_tiles(Pos1, Pos2) :-
  are_of_same_type(Pos1, Pos2),
  are_connect_by_road(Pos1, Pos2).

are_connect_by_road(Pos1, Pos2) :- are_connect_by_road_with_0_corners(Pos1, Pos2).
are_connect_by_road(Pos1, Pos2) :- are_connect_by_road_with_1_corner(Pos1, Pos2).
are_connect_by_road(Pos1, Pos2) :- are_connect_by_road_with_2_corners(Pos1, Pos2).

init_state :-
  % Board:
  %      1 2 3 4
  %   1  A A A A
  %   2  B A D A
  %   3  C B D B
  %   4  A C B A
  asserta(board_size(4, 4)),
  asserta(tile_at([1, 1], tileA)),
  asserta(tile_at([1, 2], tileB)),
  asserta(tile_at([1, 3], tileC)),
  asserta(tile_at([1, 4], tileA)),
  asserta(tile_at([2, 1], tileA)),
  asserta(tile_at([2, 2], tileA)),
  asserta(tile_at([2, 3], tileB)),
  asserta(tile_at([2, 4], tileC)),
  asserta(tile_at([3, 1], tileA)),
  asserta(tile_at([3, 2], tileD)),
  asserta(tile_at([3, 3], tileD)),
  asserta(tile_at([3, 4], tileB)),
  asserta(tile_at([4, 1], tileA)),
  asserta(tile_at([4, 2], tileA)),
  asserta(tile_at([4, 3], tileB)),
  asserta(tile_at([4, 4], tileA)).

cleanup :-
  retractall(board_size(_, _)),
  retractall(tile_at(_, _)),
  retractall(tile_empty(_)).

remove_tiles(Pos1, Pos2) :-
  can_remove_tiles(Pos1, Pos2),
  retractall(tile_at(Pos1, _)),
  retractall(tile_at(Pos2, _)),
  assertz(tile_empty(Pos1)),
  assertz(tile_empty(Pos2)).
