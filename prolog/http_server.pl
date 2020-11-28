:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_unix_daemon)).
:- use_module(board).
:- use_module(rules).

:- set_setting(http:cors, [*]).

:- multifile http_json/1.

http_json:json_type('application/x-javascript').
http_json:json_type('text/javascript').
http_json:json_type('text/x-javascript').
http_json:json_type('text/x-json').

% :- http_server(http_dispatch, [port(5000)]).
:- http_handler('/api/can-remove-tiles', handle_can_remove_tile(Method), [method(Method)]).
:- http_handler('/api/suggest-moves', handle_suggest_moves(Method), [method(Method)]).

handle_can_remove_tile(options, Request) :-
  cors_enable(Request, [methods([get, post])]),
  format('~n').

handle_can_remove_tile(post, Request) :-
  cors_enable(Request, [methods([get, post])]),
  http_read_json_dict(Request, _{board:Board, positions:[Pos1, Pos2]}),
  can_remove_tiles(Board, Pos1, Pos2, Answer),
  reply_json_dict(Answer).

handle_suggest_moves(options, Request) :-
  cors_enable(Request, [methods([get, post])]),
  format('~n').

handle_suggest_moves(post, Request) :-
  cors_enable(Request, [methods([get, post])]),
  http_read_json_dict(Request, _{board:Board}),
  suggest_moves(Board, Moves),
  reply_json_dict(Moves).


can_remove_tiles(Board, Pos1, Pos2, Answer) :-
  board:init_board(Board),
  (rules:can_remove_tiles(Pos1, Pos2) ->
    Answer = true
  ;
    Answer = false
  ).

suggest_moves(Board, Moves) :-
  board:init_board(Board),
  setof([Pos1, Pos2], rules:suggested_tiles_to_remove(Pos1, Pos2), Moves).
